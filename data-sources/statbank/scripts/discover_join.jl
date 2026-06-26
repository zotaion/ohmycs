# Discovery for the two join tasks. Lists folders (cache-friendly) and, if a
# table id is given as 2nd arg, fetches+prints its variables.
#
#   julia --project=. scripts/discover_join.jl             # list target folders
#   julia --project=. scripts/discover_join.jl POP020300   # also print meta for a table id
#
# Each list_folder call hits the disk cache if present (0 requests); otherwise 1
# polite GET. Table-id meta fetch is 1 GET (cached).

include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))
using .PxWebClient

function show_folder(segs)
    println("\n=== FOLDER: ", join(segs, " / "), " ===")
    doc = try
        list_folder(segs; dry=false)
    catch e
        println("  (folder not listed: ", string(e), ")")
        return
    end
    doc === nothing && (println("  (dry)"); return)
    if !(doc isa AbstractVector)
        println("  (unexpected non-array body: ", String(typeof(doc)), ")")
        return
    end
    for item in doc
        idv = haskey(item, "id") ? item["id"] : (haskey(item, "dbid") ? item["dbid"] : "?")
        typ = haskey(item, "type") ? item["type"] : ""
        println("  [", typ, "] ", idv, "  =>  ", haskey(item, "text") ? item["text"] : "")
    end
end

show_folder(["60 Statistica regionala"])
show_folder(["60 Statistica regionala", "06 LOC"])
show_folder(["60 Statistica regionala", "14 IND"])
show_folder(["30 Statistica sociala", "08 SAN", "SAN020"])

# Optional: print variables for each <tableid> given as args, found in a cached folder.
if !isempty(ARGS) && ARGS[1] != "--list"
    for tid in ARGS
        println("\n=== META for table id containing '", tid, "' ===")
        found = false
        for base in (["60 Statistica regionala", "02 POP"],
                     ["60 Statistica regionala", "06 LOC"],
                     ["60 Statistica regionala", "14 IND"],
                     ["30 Statistica sociala", "08 SAN", "SAN020"])
            doc = try
                list_folder(base; dry=false)
            catch e
                continue
            end
            doc === nothing && continue
            doc isa AbstractVector || continue
            for item in doc
                idv = String(haskey(item, "id") ? item["id"] : "")
                if occursin(tid, idv)
                    segs = push!(copy(base), idv)
                    println("path: ", join(segs, " / "))
                    meta = get_meta(segs; dry=false)
                    if meta !== nothing
                        println("title: ", haskey(meta, :title) ? meta[:title] : "")
                        for v in meta[:variables]
                            vals = collect(v["values"])
                            txts = collect(v["valueTexts"])
                            n = min(12, length(vals))
                            println("  code=", v["code"], "  text=", v["text"])
                            println("    values     (", length(vals), "): ", vals[1:n])
                            println("    valueTexts (", length(txts), "): ", txts[1:n])
                        end
                    end
                    found = true
                end
            end
        end
        found || println("  (no table with id containing '", tid, "' in the searched folders)")
    end
end
