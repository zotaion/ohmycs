---
title: 'Community Detection: Louvain, Leiden'
weight: 20
type: algorithm
rank: 2
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Finding groups
description: Finding groups
fields:
  - Social networks
  - biology
  - fraud rings
alt_names:
  - Louvain
  - Leiden
  - Modularity Maximization
tags:
  - community
  - unsupervised
---
> **Best for:** Finding groups
> **Aliases:** Louvain, Leiden, Modularity Maximization

## How it works

$$Q=\frac{1}{2m}\sum_{i,j}\Bigl(A_{ij}-\frac{k_i k_j}{2m}\Bigr)\delta(c_i,c_j)$$

Communities are found by greedy modularity maximisation. Modularity
$Q=\frac{1}{2m}\sum_{i,j}\Bigl(A_{ij}-\frac{k_i k_j}{2m}\Bigr)\delta(c_i,c_j)$
compares observed edge weight inside communities with a random null model,
where $k_i$ is the degree and $\delta(c_i,c_j)=1$ when $i,j$ share a
community. Louvain moves nodes to maximise local $\Delta Q$ then aggregates
communities into super-nodes; Leiden adds a refinement step that guarantees
connected, higher-quality communities.


## When to use

Discovering communities in large graphs via modularity optimization; fast and scalable.

## Watch out

Resolution limit misses small communities; randomized results — prefer Leiden for stability and quality.

## Common fields

Social networks · biology · fraud rings
