---
title: DBSCAN / HDBSCAN
weight: 30
type: algorithm
rank: 3
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Arbitrary-shaped clusters, noise detection
description: Arbitrary-shaped clusters, noise detection
fields:
  - Geospatial data
  - anomaly detection
  - fraud
  - network analysis
alt_names:
  - Density-based Clustering
  - HDBSCAN
tags:
  - clustering
  - density
  - noise
---
> **Best for:** Arbitrary-shaped clusters, noise detection
> **Aliases:** Density-based Clustering, HDBSCAN

## How it works

$$\mathrm{core}(p)\iff |\{q:\mathrm{dist}(p,q)\le\varepsilon\}|\ge \mathrm{min\_pts}$$

DBSCAN defines clusters as maximal sets of density-reachable points: a point
is a core point when at least min_pts neighbours lie within radius
$\varepsilon$, points reachable through chains of core points join the same
cluster, and everything else is labelled noise. This yields arbitrary-shaped
clusters and automatic noise labels without specifying $k$. HDBSCAN extends
this to varying density via the mutual-reachability distance
$d_{\mathrm{mreach}}(a,b)=\max\{\mathrm{core}_k(a),\mathrm{core}_k(b),d(a,b)\}$,
building a hierarchy and extracting the most stable clusters across it.


## When to use

Arbitrary-shaped clusters with noise; cases where you don't want to pre-specify k; geospatial and anomaly work.

## Watch out

Struggles with varying cluster density (DBSCAN); eps and min_samples tuning matter; HDBSCAN is slower but more robust.

## Common fields

Geospatial data · anomaly detection · fraud · network analysis
