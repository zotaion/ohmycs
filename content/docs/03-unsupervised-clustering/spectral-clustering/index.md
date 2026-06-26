---
title: Spectral Clustering
weight: 50
type: algorithm
rank: 5
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Nonlinear cluster structures
description: Nonlinear cluster structures
fields:
  - Image segmentation
  - graph data
---
> **Best for:** Nonlinear cluster structures

## How it works

$$L=D-A,\quad \text{cluster on the bottom eigenvectors of }L$$

Builds a similarity graph from the data (e.g. $k$-nearest-neighbour or
$\varepsilon$-neighbour edges with affinities $A_{ij}$) and uses its graph
Laplacian $L=D-A$ (or the normalised
$L_{\mathrm{sym}}=I-D^{-1/2}AD^{-1/2}$), whose smallest eigenvectors embed
points so that graph cuts become linearly separable. Computing the first $k$
eigenvectors and running k-means on the resulting rows recovers clusters that
k-means on the raw features cannot find. This corresponds to a relaxed
minimisation of the normalised cut
$\sum_{C}\frac{\mathrm{cut}(C,\bar C)}{\mathrm{vol}(C)}$ over the graph.


## Common fields

Image segmentation · graph data
