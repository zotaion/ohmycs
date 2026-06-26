# Oh My Computer Science

> Personal notes for learning machine learning — a ranked, math-annotated field
> guide to the algorithms working engineers actually reach for, with worked
> examples on real data.

This is a **personal study notebook**, not a textbook or a product. It's how I
make sense of ML: one page per algorithm — the intuition, the math, when to use
it, and a small worked example. Organized into 11 families: supervised,
deep learning, unsupervised, dimensionality reduction, recommenders, anomaly
detection, time series, reinforcement learning, NLP, computer vision, and
graphs.

## What's inside

- **11 chapters / 78 algorithms** — a ranked table per chapter and a detail
  page per algorithm.
- **The math** — every algorithm carries a core formula and a short derivation,
  rendered with [KaTeX](https://katex.org).
- **Search** ([Pagefind](https://pagefind.app)), a home-page category filter,
  a sidebar tree, and an "on this page" outline.
- **Worked examples** (in progress) on real statistical data, with Julia
  implementations and analysis plots.

## Data sources

Example datasets are sourced from the
**[Moldova StatBank](https://statbank.statistica.md/)** — the open-data portal
of the National Bureau of Statistics of the Republic of Moldova.

For now this is the only place the data source is referenced on the site.
Per-dataset provenance (source table, query, fetch date) is kept **internally**
under `data-sources/statbank/provenance/` (not published); the fetcher itself
is internal tooling under `data-sources/statbank/`.

## Tech

- [Hugo](https://gohugo.io) static site (custom theme, melange palette).
- [Julia](https://julialang.org) for data fetching & manipulation.
- KaTeX for math, Pagefind for search.

## Run

```sh
make dev      # local server with live reload + working search
make build    # production build: Hugo + Pagefind index -> public/
```

## Layout

```
content/docs/         the notes — chapters and algorithm pages
assets/               css, js
layouts/              templates and shortcodes
static/data/statbank/ example datasets (CSV) + provenance sidecars
data-sources/statbank/ Julia PxWeb fetcher (internal tooling)
```

---

Personal notes. Accuracy is aspirational — verify before relying on anything
here.
