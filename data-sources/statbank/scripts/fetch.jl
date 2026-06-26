# Generic fetcher for any table in tables.toml.
#
#   julia --project=. scripts/fetch.jl --list <seg1> [seg2 ...]   # list a folder (cached GET)
#   julia --project=. scripts/fetch.jl <key>                      # dry-run: print planned GET+POST
#   julia --project=. scripts/fetch.jl <key> --meta               # print variable codes/values (1 GET)
#   julia --project=. scripts/fetch.jl <key> --fetch              # fetch CSV -> out/<key>.csv
#
# <key> is a top-level table key in tables.toml (e.g. prices_cpi).

include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))

using .PxWebClient
using TOML
using DataFrames
using Dates

const CONFIG = TOML.parsefile(joinpath(@__DIR__, "..", "tables.toml"))

build_query(query_blocks) = [begin
    filter = String(get(q, "filter", "item"))
    # filter:"all" emits PxWeb wildcard values:["*"] (the empty [] variant
    # is rejected by statbank with HTTP 400 "Parameter error").
    values = filter == "all" ? ["*"] : String.(q["values"])
    Dict("code" => String(q["code"]),
         "selection" => Dict("filter" => filter, "values" => values))
end for q in query_blocks]

function print_variables(meta)
    println("title: ", get(meta, "title", ""))
    for v in meta["variables"]
        vals = collect(v["values"])
        txts = collect(v["valueTexts"])
        n = min(10, length(vals))
        println("  code=", v["code"], "  text=", v["text"], "  (time=", get(v, "time", false), ")")
        println("    values      (", length(vals), "): ", vals[1:n])
        println("    valueTexts  (", length(txts), "): ", txts[1:n])
    end
end

function list_mode(segs)
    doc = list_folder(segs; dry=false)
    doc === nothing && error("no folder listing (dry?)")
    println("Folder children (", length(doc), "):")
    for item in doc
        dbid = get(item, "dbid", get(item, "id", "?"))
        text = get(item, "text", "")
        println("  ", dbid, "  =>  ", text)
    end
end

function table_mode(key)
    haskey(CONFIG, key) || error("unknown table key '$key' (not in tables.toml)")
    T = CONFIG[key]
    SEGMENTS = String.(T["path"])
    QS = get(T, "query", [])
    if "--meta" in ARGS
        meta = get_meta(SEGMENTS; dry=false)
        meta === nothing && error("no metadata (dry?)")
        print_variables(meta)
    elseif "--fetch" in ARGS
        isempty(QS) && error("Add [[$key.query]] blocks to tables.toml first (run --meta)")
        query = build_query(QS)
        # Fetch as JSON (deterministic) and melt to long tidy layout. Metadata is
        # needed to map dimension value codes -> human-readable valueTexts.
        meta = get_meta(SEGMENTS; dry=false)
        json = post_data(SEGMENTS, query; dry=false, format="json")
        json === nothing && error("no data (dry?)")
        df = long_dataframe_from_json(json, meta)
        tidy_and_write!(df, key; source_url=table_url(SEGMENTS), query=query)
        @info "fetched $key" n_rows=nrow(df) n_cols=ncol(df)
    else
        @info "DRY-RUN" key=key title=get(T, "title", "")
        get_meta(SEGMENTS; dry=true)
        if !isempty(QS)
            post_data(SEGMENTS, build_query(QS); dry=true)
        else
            println("No [[query]] yet — run --meta to see variables.")
        end
    end
end

function main()
    args = collect(ARGS)
    if isempty(args)
        error("usage: fetch.jl <key> [--meta|--fetch]  |  fetch.jl --list <seg1> [seg2 ...]")
    end
    if args[1] == "--list"
        segs = args[2:end]
        isempty(segs) && error("--list needs at least one path segment")
        list_mode(String.(segs))
    else
        table_mode(args[1])
    end
end

main()
