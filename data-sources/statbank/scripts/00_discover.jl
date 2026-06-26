include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))

using .PxWebClient: BASE, get_meta

const ROOT_SEGMENTS = String[]   # table_url([]) == BASE * "/"

function main()
    if "--fetch" in ARGS
        doc = get_meta(ROOT_SEGMENTS; dry=false)
        println("Top-level subjects:")
        for item in doc
            println("  [", item["type"], "] id=", item["id"], "  text=", item["text"])
        end
    else
        @info "DRY-RUN: discover"
        @info "would GET" url=string(BASE, "/")
        println("Run with --fetch to list top-level subjects (1 GET).")
    end
end

main()
