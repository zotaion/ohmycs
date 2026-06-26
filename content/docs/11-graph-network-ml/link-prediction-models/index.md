---
title: Link Prediction Models
weight: 60
type: algorithm
rank: 6
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Predicting relationships
description: Predicting relationships
fields:
  - Knowledge graphs
  - social networks
  - drug discovery
---
> **Best for:** Predicting relationships

## How it works

$$\hat{y}_{ij}=\sigma\bigl(f(z_i,z_j)\bigr)$$

Predicts whether an edge should exist between nodes $i$ and $j$. Heuristic
scores use neighbourhood overlap such as Adamic-Adar
$\sum_{k\in N(i)\cap N(j)}1/\log d_k$ or Jaccard similarity of neighbour
sets. Embedding-based approaches score a pair by
$\hat y_{ij}=\sigma\bigl(f(z_i,z_j)\bigr)$, e.g. the dot product of node2vec
or GNN embeddings, while GNN variants pool over $(z_i,z_j)$ and classify.
Trained on observed edges versus sampled negative edges.


## Common fields

Knowledge graphs · social networks · drug discovery
