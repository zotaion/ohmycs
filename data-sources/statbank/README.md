# StatBank fetcher (Moldova PxWeb)

Small, **dry-run-by-default** Julia fetcher for the Moldova StatBank PxWeb API
(`https://statbank.statistica.md/PxWeb/api/v1/ro`).

## Hard rules

- **No automated network access.** Running any script with no flags does ZERO
  network I/O — it only prints the requests it *would* make.
- `--meta` and `--fetch` are opt-in flags you run **by hand, one table at a time**.
- Every real response is cached under `cache/raw/` (content-addressed by sha256 of
  method+url+body). Re-running `--fetch` hits the cache (no network). Delete the
  relevant cache file to force a refetch.
- Data response format is **CSV**; metadata (table variables) is **JSON**.

## Setup (one-time)

```sh
cd data-sources/statbank
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

This installs `JSON3`, `DataFrames`, `CSV` from the Julia General
registry — it does **not** touch StatBank. (Transport is plain `curl`; the
HTTP.jl dep was dropped in favour of a tiny `_escapeuri`.)

## Runbook

```sh
cd data-sources/statbank

# 1. browse top-level subjects (dry-run by default; --fetch does 1 cached GET)
julia --project=. scripts/00_discover.jl
julia --project=. scripts/00_discover.jl --fetch

# 2. environment table (MED020050) — query is already known in tables.toml
julia --project=. scripts/01_environment.jl          # dry-run: prints planned GET + POST
julia --project=. scripts/01_environment.jl --meta   # print variable codes/values (1 GET)
julia --project=. scripts/01_environment.jl --fetch  # fetch CSV -> out/environment.csv

# 3. morbidity table (SAN020080trim) — query must be discovered first
julia --project=. scripts/02_morbidity.jl --meta     # print variables (1 GET)
#    ...then edit tables.toml: add [[morbidity.query]] blocks...
julia --project=. scripts/02_morbidity.jl --fetch    # fetch CSV -> out/morbidity.csv

# 4. GENERIC fetcher (all other tables). <key> is a tables.toml section.
julia --project=. scripts/fetch.jl prices_cpi                  # dry-run
julia --project=. scripts/fetch.jl prices_cpi --meta           # variables (1 GET)
julia --project=. scripts/fetch.jl prices_cpi --fetch          # -> out/prices_cpi.csv
# discover folders (cached GET, returns dbid/text children):
julia --project=. scripts/fetch.jl --list "40 Statistica economica"
```

## Layout

```
Project.toml          deps (JSON3, DataFrames, CSV)
tables.toml           discovered table paths + queries
src/PxWebClient.jl    core module (URL build, cache, list_folder, get_meta,
                      post_data, long_dataframe, tidy_and_write!)
scripts/              00_discover.jl, 01_environment.jl, 02_morbidity.jl,
                      fetch.jl (generic: <key> | --list <segs...>)
cache/raw/            raw cached responses (.json / .csv) — gitignored
out/                  tidy CSVs + .meta.json sidecars (provenance) — gitignored
```

## Notes

- PxWeb CSV dialect (delimiter, preamble lines) is detected defensively in
  `long_dataframe` (modal field-count header detection + `;`/`,` fallback). It
  will be revisited after the first real fetch.
- `out/*.meta.json` records `source`, `query`, `fetched_at`, `n_rows`, `columns`
  so the derived CSVs can be regenerated/audited.
