include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))
using .PxWebClient

for (key, segs) in [
    ("EXT010900", ["40 Statistica economica","21 EXT","EXT010","serii anuale","EXT010900.px"]),
    ("AGR020600reg", ["60 Statistica regionala","16 AGR","AGR020600reg.px"]),
    ("EXT010800", ["40 Statistica economica","21 EXT","EXT010","serii anuale","EXT010800.px"]),
    ("EXT010700", ["40 Statistica economica","21 EXT","EXT010","serii anuale","EXT010700.px"]),
]
    println("==== $key ====")
    m = get_meta(segs; dry=false)
    for v in m["variables"]
        if lowercase(v["code"]) == "ani" || lowercase(v["text"]) == "ani" || occursin("Ani", v["text"])
            println("  ", v["code"], " values: ", collect(v["values"]))
        end
    end
end
