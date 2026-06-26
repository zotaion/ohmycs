---
title: Hierarchical Clustering
weight: 20
type: algorithm
rank: 2
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Cluster trees/dendrograms
description: Cluster trees/dendrograms
fields:
  - Biology
  - market research
  - document grouping
alt_names:
  - Agglomerative
  - Divisive
  - Dendrogram
tags:
  - clustering
  - dendrogram
---
> **Best for:** Cluster trees/dendrograms
> **Aliases:** Agglomerative, Divisive, Dendrogram

## How it works

$$d(C_i,C_j)=\min_{x\in C_i,\,y\in C_j}\|x-y\|$$

Agglomerative clustering starts with every point as its own cluster and
repeatedly merges the two "closest" clusters, producing a dendrogram that can
be cut at any height for a different $k$. The linkage function defines that
cluster distance: single linkage uses the minimum pairwise distance
$d(C_i,C_j)=\min_{x\in C_i,y\in C_j}\|x-y\|$, complete linkage the maximum,
and average/Ward linkage the mean or variance-minimising merge. The resulting
tree structure is determined entirely by the chosen linkage and distance
metric; divisive variants build the tree top-down instead.


## When to use

When you want a cluster tree to inspect multiple granularities, or when pairwise distance is the natural metric.

## Watch out

O(n^2) or worse in distance computation; linkage choice heavily shapes results; does not scale to large n.

## Common fields

Biology · market research · document grouping
