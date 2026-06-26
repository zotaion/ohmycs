# One-shot metadata inspector for a list of (key, segments) tuples.
# Usage: julia --project=. scripts/inspect_meta.jl
include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))
using .PxWebClient

const CANDIDATES = [
    ("reg_SAL010510 wages x activity", ["60 Statistica regionala","03 FM","SAL010","SAL010510reg.px"]),
    ("reg_SAL014910 wages quarterly",  ["60 Statistica regionala","03 FM","SAL010","SAL014910reg.px"]),
]

for (key, segs) in CANDIDATES
    println("=====================")
    println("KEY: ", key)
    try
        m = get_meta(segs; dry=false)
        println("TITLE: ", get(m, "title", ""))
        nvars = 1
        for v in m["variables"]
            n = length(v["values"])
            nvars *= n
            println("  ", v["code"], " (", v["text"], "): ", n, " values")
        end
        println("  CROSS-PRODUCT = ", nvars)
    catch e
        println("ERROR: ", string(e))
    end
end
