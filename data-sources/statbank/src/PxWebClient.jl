module PxWebClient

using JSON3
using DataFrames
using CSV
using SHA
using Dates

const BASE = "https://statbank.statistica.md:443/PxWeb/api/v1/ro"
const USER_AGENT = "ohmycs-statbank-fetcher/0.1 (manual; research)"

# Output dir = project's served data folder (committed; served at /data/statbank/).
const OUTDIR = normpath(joinpath(@__DIR__, "..", "..", "..", "static", "data", "statbank"))

# tiny manual percent-encoder for a single URL path segment (RFC 3986 unreserved set).
# replaces HTTP.URIs.escapeuri so the HTTP.jl dep can be dropped entirely.
function _escapeuri(s::AbstractString)
    unreserved = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    out = ""
    for b in codeunits(s)
        c = Char(b)
        if occursin(c, unreserved)
            out *= c
        else
            out *= "%" * uppercase(string(b, base=16, pad=2))
        end
    end
    return out
end

table_url(segments::Vector{String}) =
    string(BASE, "/", join(_escapeuri.(segments), "/"))

function _cache_path(method::Symbol, url::String, body::String="")
    ext = method === :get ? "json" : "csv"
    h = bytes2hex(sha256(string(method) * url * body))
    return joinpath("cache", "raw", first(h, 16) * "." * ext)
end

# GET a PxWeb *folder* URL. Unlike `get_meta` (which targets a `.px` table and
# returns metadata), a folder GET returns a JSON array of children:
#   [{"dbid": "<segment>", "text": "<label>"}, ...]
# (Note: this PxWeb instance uses `dbid`/`text`, not the `id`/`type`/`text`
# schema some other PxWeb servers emit.)
function list_folder(segments; force::Bool=false, dry::Bool=true)
    url = table_url(String.(segments))
    if dry
        @info "DRY GET (folder)" url=url
        return nothing
    end
    cachefile = _cache_path(:get, url)
    if isfile(cachefile) && !force
        return JSON3.read(read(cachefile, String))
    end
    mkpath(dirname(cachefile))
    status = try
        readchomp(`curl -sS -m 60 -L
                       -H "User-Agent: $(USER_AGENT)"
                       -H "Accept: application/json"
                       -w "%{http_code}"
                       -o $(cachefile)
                       $(url)`)
    catch e
        error("curl GET (folder) failed for $url: $(string(e))")
    end
    sleep(1.5)
    if status != "200"
        body = isfile(cachefile) ? read(cachefile, String) : ""
        isfile(cachefile) && rm(cachefile)
        error("PxWeb folder GET returned HTTP $status for $url; body: $(first(body, 200))")
    end
    return JSON3.read(read(cachefile, String))
end

function get_meta(segments; force::Bool=false, dry::Bool=true)
    url = table_url(String.(segments))
    if dry
        @info "DRY GET" url=url
        return nothing
    end
    cachefile = _cache_path(:get, url)
    if isfile(cachefile) && !force
        return JSON3.read(read(cachefile, String))
    end
    mkpath(dirname(cachefile))
    status = try
        readchomp(`curl -sS -m 60 -L
                       -H "User-Agent: $(USER_AGENT)"
                       -H "Accept: application/json"
                       -w "%{http_code}"
                       -o $(cachefile)
                       $(url)`)
    catch e
        error("curl GET failed for $url: $(string(e))")
    end
    sleep(1.5)
    if status != "200"
        body = isfile(cachefile) ? read(cachefile, String) : ""
        isfile(cachefile) && rm(cachefile)
        error("PxWeb GET returned HTTP $status for $url; body: $(first(body, 200))")
    end
    return JSON3.read(read(cachefile, String))
end

function post_data(segments, query; force::Bool=false, dry::Bool=true,
                   format::AbstractString="json")
    url = table_url(String.(segments))
    body = JSON3.write(Dict("query" => query, "response" => Dict("format" => format)))
    if dry
        @info "DRY POST" url=url body=body
        return nothing
    end
    # Cache key includes the body (so JSON vs CSV queries land in separate files).
    ext = format == "json" ? "json" : "csv"
    h = bytes2hex(sha256(string(:post) * url * body))
    cachefile = joinpath("cache", "raw", first(h, 16) * "." * ext)
    if isfile(cachefile) && !force
        return read(cachefile, String)
    end
    mkpath(dirname(cachefile))
    bodyfile = tempname()
    write(bodyfile, body)
    accept = format == "json" ? "application/json" : "text/csv"
    status = try
        readchomp(`curl -sS -m 120 -L -X POST
                       -H "User-Agent: $(USER_AGENT)"
                       -H "Content-Type: application/json"
                       -H "Accept: $(accept)"
                       --data @$bodyfile
                       -w "%{http_code}"
                       -o $(cachefile)
                       $(url)`)
    catch e
        rm(bodyfile; force=true)
        error("curl POST failed for $url: $(string(e))")
    end
    rm(bodyfile; force=true)
    sleep(1.5)
    if status != "200"
        rb = isfile(cachefile) ? read(cachefile, String) : ""
        isfile(cachefile) && rm(cachefile)
        error("PxWeb POST returned HTTP $status for $url; body: $(first(rb, 200))")
    end
    return read(cachefile, String)
end

function _mode(xs::Vector{Int})
    d = Dict{Int,Int}()
    for x in xs
        d[x] = get(d, x, 0) + 1
    end
    best, bestn = first(xs), 0
    for (k, v) in d
        if v > bestn
            best, bestn = k, v
        end
    end
    return best
end

function long_dataframe(csvtext::String)
    lines = split(csvtext, r"\r?\n")
    while !isempty(lines) && isempty(strip(last(lines)))
        pop!(lines)
    end
    isempty(lines) && return DataFrame()
    joined = join(lines)
    nsemi = count(==(';'), joined)
    ncomma = count(==(','), joined)
    primary = nsemi >= ncomma ? ';' : ','
    secondary = primary == ';' ? ',' : ';'
    # quote-aware field count: a delimiter inside "..." is not a separator.
    # (PxWeb headers embed commas, e.g. "In procente, anul precedent=100";
    # a naive count(==(',')) would over-count header lines and mis-detect the
    # header row, scrambling the wide layout.)
    counts = [_count_fields(l, primary) for l in lines]
    mode_count = _mode([c for (l, c) in zip(lines, counts) if !isempty(strip(l))])
    header_idx = findfirst(==(mode_count), counts)
    if header_idx === nothing
        header_idx = 1
    end
    for delim in (primary, secondary)
        try
            return DataFrame(CSV.File(IOBuffer(csvtext);
                header=header_idx, delim=delim))
        catch e
            @warn "CSV parse failed with delimiter, trying fallback" tried=delim err=string(e)
        end
    end
    error("long_dataframe: could not parse CSV text with either delimiter")
end

function _count_fields(line::AbstractString, delim::Char)
    n = 1
    inq = false
    for c in line
        if c == '"'
            inq = !inq
        elseif c == delim && !inq
            n += 1
        end
    end
    return n
end

# Build a tidy LONG DataFrame from a PxWeb JSON data response.
# The JSON shape is:
#   {"columns": [{code,text,type}, ...], "data": [{key:[...], values:[...]}, ...]}
# `type` is "d" (dimension), "t" (time), or "c" (content/measure).
# Each data cell has one entry per dim col in `key` and one or more measures in
# `values`. We emit one row per cell with one column per dim (labelled with
# valueTexts looked up from `meta`) and a single `value` column for the measure.
# (PxWeb CSV pivots one dim into many columns -> compound headers that cannot be
# cleanly melted; JSON is deterministic and label-friendly.)
function long_dataframe_from_json(jsontext::AbstractString, meta)
    obj = JSON3.read(jsontext)
    cols = obj[:columns]
    data = obj[:data]

    # Map each dimension's value codes -> valueTexts using the metadata.
    code_to_text = Dict{String,Dict{String,String}}()
    if meta !== nothing
        for v in meta["variables"]
            d = Dict{String,String}()
            for (c, t) in zip(collect(v["values"]), collect(v["valueTexts"]))
                d[String(c)] = String(t)
            end
            code_to_text[String(v["code"])] = d
        end
    end

    dim_cols = [c for c in cols if String(c["type"]) in ("d", "t")]
    content_cols = [c for c in cols if String(c["type"]) == "c"]

    # Build column store (Any[] since values are mixed string codes -> text).
    colnames = [String(c["text"]) for c in dim_cols]
    # Sanitise: ensure unique, non-empty names.
    colnames = _unique_names(colnames)
    push!(colnames, "value")
    coldata = Dict{String,Vector{Any}}(n => Any[] for n in colnames)

    n_content = length(content_cols)
    for cell in data
        key = collect(cell["key"])
        values = collect(cell["values"])
        for (i, dc) in enumerate(dim_cols)
            code = String(key[i])
            lookup = get(code_to_text, String(dc["code"]), nothing)
            txt = lookup === nothing ? code : get(lookup, code, code)
            push!(coldata[colnames[i]], txt)
        end
        # Single measure per cell is the norm -> put it in `value`.
        v = n_content >= 1 ? values[1] : missing
        # PxWeb emits ".." for suppressed cells; keep as-is so ML can filter.
        push!(coldata["value"], v)
    end

    # Construct DataFrame column-by-column to preserve order (Dict iteration
    # order is unspecified in Julia, so `DataFrame(dict, names)` would scramble
    # the column <-> value association).
    df = DataFrame()
    for n in colnames
        df[!, n] = coldata[n]
    end
    return df
end

# Ensure a vector of column names has unique, non-empty entries.
function _unique_names(names::Vector{String})
    out = String[]
    seen = Dict{String,Int}()
    for n in names
        base = isempty(strip(n)) ? "col" : n
        if haskey(seen, base)
            seen[base] += 1
            push!(out, base * "_" * string(seen[base]))
        else
            seen[base] = 1
            push!(out, base)
        end
    end
    return out
end

function tidy_and_write!(df, name::AbstractString; source_url::AbstractString, query)
    mkpath(OUTDIR)
    CSV.write(joinpath(OUTDIR, "$(name).csv"), df)
    meta = Dict(
        "source" => source_url,
        "query" => query,
        "fetched_at" => Dates.format(now(UTC), dateformat"yyyy-mm-ddTHH:MM:SSZ"),
        "n_rows" => nrow(df),
        "columns" => names(df),
    )
    open(joinpath(OUTDIR, "$(name).meta.json"), "w") do io
        write(io, JSON3.write(meta))
    end
    return df
end

export BASE, OUTDIR, table_url, list_folder, get_meta, post_data,
       long_dataframe, long_dataframe_from_json, tidy_and_write!

end
