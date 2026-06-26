# Builds the two joined outputs from Moldova StatBank (PxWeb):
#   PART A  -> static/data/statbank/regional_indicators.csv   (wide raion x year
#              feature matrix, >=15 indicator columns; OVERWRITES the old thin
#              SAL-only version).
#   PART B  -> static/data/statbank/morbidity.csv             (stacked long
#              morbidity table from 4 SAN020* tables; OVERWRITES old single-table
#              version).
#
# All tables are declared in tables.toml. post_data/get_data are disk-cached +
# polite (1.5s sleep); re-runs hit the cache. Raion join keys on the dimension
# CODE (identical across tables even though labels differ), then a single
# canonical `raion` name is attached.
#
#   julia --project=. scripts/build_joins.jl

include(joinpath(@__DIR__, "..", "src", "PxWebClient.jl"))
using .PxWebClient
using DataFrames
using CSV
using JSON3
using Dates
using TOML

const OUTDIR = PxWebClient.OUTDIR
const CONFIG = TOML.parsefile(joinpath(@__DIR__, "..", "tables.toml"))

# ---- query builder (same convention as scripts/fetch.jl) ---------------------
function build_query(blocks)
    [begin
        filter = String(get(q, "filter", "item"))
        values = filter == "all" ? ["*"] : String.(q["values"])
        Dict("code" => String(q["code"]),
             "selection" => Dict("filter" => filter, "values" => values))
    end for q in blocks]
end

# fetch tidy-long DataFrame + metadata + source URL for a tables.toml key
function fetch_table(key)
    T = CONFIG[key]
    segs = String.(T["path"])
    meta = get_meta(segs; dry=false)
    json = post_data(segs, build_query(T["query"]); dry=false, format="json")
    df = long_dataframe_from_json(json, meta)
    return df, meta, table_url(segs)
end

# PxWeb emits ".." for suppressed cells; numbers come back as Int/Float, some as
# strings. Coerce everything to Float64? (missing for suppressed/unparseable).
function to_float(x)
    (x === nothing || x === missing) && return missing
    x isa Number && return Float64(x)
    s = string(x)
    (s == ".." || s == "...") && return missing
    v = tryparse(Float64, s)
    return v === nothing ? missing : v
end

# code <- text lookup for one metadata dimension
function text_to_code_map(meta, dim_code)
    d = Dict{String,String}()
    for v in meta[:variables]
        if String(v[:code]) == dim_code
            for (c, t) in zip(collect(v[:values]), collect(v[:valueTexts]))
                d[String(t)] = String(c)
            end
        end
    end
    return d
end

# canonical raion name <- code (from POP020300reg labels, leading ".." stripped)
function canonical_raion_names(meta_pop)
    d = Dict{String,String}()
    for v in meta_pop[:variables]
        if String(v[:code]) == "Raioane/Regiuni"
            for (c, t) in zip(collect(v[:values]), collect(v[:valueTexts]))
                d[String(c)] = replace(String(t), r"^\.\." => "")
            end
        end
    end
    return d
end

# Drop the national total (code "0") and the 3 development-region aggregations
# (Nord/Centru/Sud). Keep the 35 actual territorial units (raioane + the 2
# municipalities Mun. Chisinau / Mun. Balti + UTA Gagauzia).
const DROP_CODES = Set(["0", "MD011", "MD012", "MD013"])

# tag a tidy frame with :raion_code (looked up from its own raion dim text)
function add_raion_code!(df, meta, raion_dim_code, text_col)
    rmap = text_to_code_map(meta, raion_dim_code)
    df.raion_code = [get(rmap, String(x), String(x)) for x in df[:, text_col]]
    return df
end

parse_year(col) = [something(tryparse(Int, strip(string(x))), 0) for x in col]

# write a provenance sidecar (mirrors tidy_and_write!, but for joined outputs).
function write_meta_json(name::AbstractString; n_rows::Int, columns, sources::AbstractString,
                         note::AbstractString)
    meta = Dict(
        "fetched_at" => Dates.format(now(UTC), dateformat"yyyy-mm-ddTHH:MM:SSZ"),
        "n_rows"     => n_rows,
        "columns"    => columns,
        "sources"    => sources,
        "note"       => note)
    open(joinpath(OUTDIR, "$(name).meta.json"), "w") do io
        write(io, JSON3.write(meta))
    end
end

# ============================================================================
# PART A -- regional multi-indicator feature matrix
# ============================================================================
println("\n" * "="^70, "\nPART A -- regional feature matrix\n", "="^70)

# --- POP020300reg : 6 natural-movement rates ---------------------------------
df, meta_pop, url_pop = fetch_table("pop_natural_rates")
add_raion_code!(df, meta_pop, "Raioane/Regiuni", "Raioane/Regiuni")
pop_names = Dict(
    "Rata natalitatii"           => "birth_rate",
    "Rata mortalitatii"          => "death_rate",
    "Rata mortalitatii infantile" => "infant_mortality_rate",
    "Rata sporului natural"      => "natural_increase_rate",
    "Rata nuptialitatii"         => "marriage_rate",
    "Rata divortialitatii"       => "divorce_rate")
df.feature = [get(pop_names, String(x), String(x)) for x in df.Indicatori]
df.val = to_float.(df.value)
pop_w = unstack(select(df, :raion_code, :Ani => :year, :feature, :val),
                [:raion_code, :year], :feature, :val)
pop_w.year = parse_year(pop_w.year)
@info "POP020300reg" rows=nrow(df) wide_cols=names(pop_w)

# --- SAL010510reg : wages + gross payroll (already cached) -------------------
df, meta_sal, url_sal = fetch_table("regional_indicators")
add_raion_code!(df, meta_sal, "Raioane/Regiuni", "Raioane/Regiuni")
sal_act = Dict(
    "Activitati economice - total"                              => "total",
    "Agricultura, sivicultura si pescuit"                       => "agriculture",
    "Industrie si constructii"                                  => "industry",
    "Invatamint"                                                => "education",
    "Administratia publica si aparare; asigurari sociale obligatorii" => "public_admin")
WAGE = "Cistigul salarial mediu lunar brut, lei"
PAYROLL = "Sume brute calculate, milioane lei"
function sal_feature(activity, indicator)
    if indicator == WAGE
        a = get(sal_act, activity, nothing)
        return a === nothing ? missing : "avg_wage_" * a
    elseif indicator == PAYROLL
        return activity == "Activitati economice - total" ? "gross_payroll_total" : missing
    end
    return missing
end
df.feature = [sal_feature(String(a), String(i))
              for (a, i) in zip(df[:, "Activitati economice"], df.Indicatori)]
df.val = to_float.(df.value)
sal_df = filter(:feature => x -> x !== missing, df)
sal_w = unstack(select(sal_df, :raion_code, :Ani => :year, :feature, :val),
                [:raion_code, :year], :feature, :val)
sal_w.year = parse_year(sal_w.year)
@info "SAL010510reg" rows=nrow(df) wide_cols=names(sal_w)

# --- LOC010100reg : housing stock (Medii = Total) ----------------------------
df, meta_loc, url_loc = fetch_table("loc_housing")
add_raion_code!(df, meta_loc, "Raioane/Regiuni", "Raioane/Regiuni")
df = filter(:Medii => m -> String(m) == "Total", df)
loc_names = Dict(
    "Apartamente si case de locuit individuale, mii unitati" => "housing_units_thsd",
    "Suprafata totala, mii metri patrati"                    => "housing_total_area_thsd_m2",
    "Suprafata locuibila, mii metri patrati"                 => "housing_livable_area_thsd_m2")
df.feature = [get(loc_names, String(x), String(x)) for x in df.Indicatori]
df.val = to_float.(df.value)
loc_w = unstack(select(df, :raion_code, :Ani => :year, :feature, :val),
                [:raion_code, :year], :feature, :val)
loc_w.year = parse_year(loc_w.year)
@info "LOC010100reg" rows=nrow(df) wide_cols=names(loc_w)

# --- IND020200reg : industrial output value ----------------------------------
df, meta_ind, url_ind = fetch_table("ind_production")
add_raion_code!(df, meta_ind, "Regiuni/Raioane", "Regiuni/Raioane")
ind_names = Dict(
    "Milioane lei"               => "industrial_output_mil_lei",
    "In procente fata de total"  => "industrial_share_of_total_pct")
df.feature = [get(ind_names, String(x), String(x)) for x in df[:, "Unitatea de masura"]]
df.val = to_float.(df.value)
ind_w = unstack(select(df, :raion_code, :Ani => :year, :feature, :val),
                [:raion_code, :year], :feature, :val)
ind_w.year = parse_year(ind_w.year)
@info "IND020200reg" rows=nrow(df) wide_cols=names(ind_w)

# --- outerjoin everything on (raion_code, year) ------------------------------
wide = outerjoin(pop_w, sal_w, on=[:raion_code, :year])
wide = outerjoin(wide, loc_w, on=[:raion_code, :year])
wide = outerjoin(wide, ind_w, on=[:raion_code, :year])

# drop national total + development regions; attach canonical raion name
wide = filter(:raion_code => c -> !in(c, DROP_CODES), wide)
canon = canonical_raion_names(meta_pop)
wide.raion = [get(canon, c, c) for c in wide.raion_code]

# column order: keys, raion name, then indicators (alphabetic for stability)
ind_cols = sort([n for n in names(wide)
                 if n ∉ ("raion_code", "year", "raion")])
wide = wide[:, vcat(["raion_code", "raion", "year"], ind_cols)]
sort!(wide, [:raion_code, :year])

mkpath(OUTDIR)
CSV.write(joinpath(OUTDIR, "regional_indicators.csv"), wide)
write_meta_json("regional_indicators";
    n_rows=nrow(wide), columns=names(wide),
    sources="JOIN of POP020300reg + SAL010510reg + LOC010100reg + IND020200reg",
    note="Wide raion x year feature matrix; joined on raion code (labels differ across tables). National total + 3 development regions dropped.")

n_raioane = length(unique(wide.raion_code))
n_ind = length(ind_cols)
println("\n--- PART A report ---")
println("raioane (territorial units) : ", n_raioane)
println("year range                  : ", minimum(wide.year), " - ", maximum(wide.year))
println("indicator columns (", n_ind, ", MUST be >=15):")
for c in ind_cols; println("   - ", c); end
println("total rows                  : ", nrow(wide))
# missingness per indicator
miss = DataFrame(indicator=String[], missing_pct=Float64[], missing_n=Int[])
for c in ind_cols
    col = wide[:, c]
    nm = count(ismissing, col)
    push!(miss, (String(c), round(100.0 * nm / nrow(wide), digits=1), nm))
end
println("missingness per indicator (rows with missing value):")
foreach(r -> println("   ", rpad(r.indicator, 34), r.missing_pct, "%  (", r.missing_n, ")"),
       eachrow(miss))
n_ind >= 15 || error("PART A produced only $n_ind indicators (<15). Add another regional table.")

# ============================================================================
# PART B -- morbidity concatenation (4 SAN020* tables)
# ============================================================================
println("\n" * "="^70, "\nPART B -- morbidity stack\n", "="^70)

UNIFIED = [:domain, :cause, :sex, :age_group, :indicator, :year, :value]

# SAN020200rcl : disease classes x case-type (no sex/age)
df, _, _ = fetch_table("morbidity")
m200 = DataFrame(
    domain    = "SAN020200",
    cause     = String.(df[:, "Clase de boli"]),
    sex       = "Total",
    age_group = "Total",
    indicator = [String(a) * " | " * String(b)
                 for (a, b) in zip(df.Indicatori, df[:, "Persoane cu morbiditati"])],
    year      = parse_year(df.Ani),
    value     = to_float.(df.value))

# SAN020700rcl : tuberculosis x age x sex
df, _, _ = fetch_table("morb_tb")
m700 = DataFrame(
    domain    = "SAN020700",
    cause     = "Tuberculoza activa",
    sex       = String.(df.Sexe),
    age_group = String.(df[:, "Grupe de virsta"]),
    indicator = String.(df.Indicatori),
    year      = parse_year(df.Ani),
    value     = to_float.(df.value))

# SAN021000rcl : malignant tumors x localization x sex (no age)
df, _, _ = fetch_table("morb_tumors")
m1000 = DataFrame(
    domain    = "SAN021000",
    cause     = String.(df.Localizari),
    sex       = String.(df.Sexe),
    age_group = "Total",
    indicator = String.(df.Indicatori),
    year      = parse_year(df.Ani),
    value     = to_float.(df.value))

# SAN021200rcl : venereal diseases x age x sex x disease
df, _, _ = fetch_table("morb_venereal")
m1200 = DataFrame(
    domain    = "SAN021200",
    cause     = String.(df.Boli),
    sex       = String.(df.Sexe),
    age_group = String.(df[:, "Grupe de virsta"]),
    indicator = String.(df.Indicatori),
    year      = parse_year(df.Ani),
    value     = to_float.(df.value))

stacked = vcat(m200, m700, m1000, m1200; cols=:union)
stacked = stacked[:, UNIFIED]   # enforce column order
sort!(stacked, [:domain, :cause, :year, :sex, :age_group, :indicator])

CSV.write(joinpath(OUTDIR, "morbidity.csv"), stacked)
write_meta_json("morbidity";
    n_rows=nrow(stacked), columns=names(stacked),
    sources="VCAT of SAN020200rcl + SAN020700rcl + SAN021000rcl + SAN021200rcl",
    note="Long morbidity table; 4 domains harmonised to (domain, cause, sex, age_group, indicator, year, value).")

println("\n--- PART B report ---")
println("total rows : ", nrow(stacked), "  (target >= 2700)")
println("columns    : ", names(stacked))
println("domains    : ", unique(stacked.domain))
println("rows/domain:")
for d in unique(stacked.domain)
    println("   ", d, " => ", count(==(d), stacked.domain))
end
println("3-row sample:")
sample_rows = stacked[[1, div(nrow(stacked), 2), nrow(stacked)], :]
foreach(r -> println("   ", [getproperty(r, c) for c in UNIFIED]),
       eachrow(sample_rows))

println("\nDONE. Both CSVs overwritten in ", OUTDIR)
