include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))

using .PxWebClient
using TOML
using DataFrames
using Dates

const CONFIG = TOML.parsefile(joinpath(@__DIR__, "..", "tables.toml"))
const T = CONFIG["environment"]
const SEGMENTS = String.(T["path"])

function build_query()
    return [begin
        filter = String(get(q, "filter", "item"))
        # filter:"all" emits PxWeb wildcard values:["*"] (the empty [] variant
        # is rejected by statbank with HTTP 400 "Parameter error").
        values = filter == "all" ? ["*"] : String.(q["values"])
        Dict("code" => String(q["code"]),
             "selection" => Dict("filter" => filter, "values" => values))
    end for q in T["query"]]
end

function print_variables(meta)
    println("title: ", get(meta, "title", ""))
    for v in meta["variables"]
        vals = collect(v["values"])
        txts = collect(v["valueTexts"])
        n = min(10, length(vals))
        println("  code=", v["code"], "  text=", v["text"])
        println("    values      (", length(vals), "): ", vals[1:n])
        println("    valueTexts  (", length(txts), "): ", txts[1:n])
    end
end

function main()
    if "--meta" in ARGS
        meta = get_meta(SEGMENTS; dry=false)
        meta === nothing && error("no metadata (dry?)")
        print_variables(meta)
    elseif "--fetch" in ARGS
        query = build_query()
        csv = post_data(SEGMENTS, query; dry=false)
        csv === nothing && error("no data (dry?)")
        df = long_dataframe(csv)
        tidy_and_write!(df, "environment"; source_url=table_url(SEGMENTS), query=query)
        @info "fetched environment" n_rows=nrow(df)
    else
        @info "DRY-RUN: environment"
        get_meta(SEGMENTS; dry=true)
        post_data(SEGMENTS, build_query(); dry=true)
        println("Run with --fetch to fetch, --meta to inspect variables.")
    end
end

main()
