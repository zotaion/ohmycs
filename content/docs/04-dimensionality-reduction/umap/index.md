---
title: UMAP
weight: 30
type: algorithm
rank: 3
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: Fast nonlinear visualization/embedding
description: Fast nonlinear visualization/embedding
fields:
  - Single-cell biology
  - text embeddings
  - image embeddings
alt_names:
  - Uniform Manifold Approximation and Projection
tags:
  - visualization
  - manifold
  - fast
---
> **Best for:** Fast nonlinear visualization/embedding
> **Aliases:** Uniform Manifold Approximation and Projection

## How it works

$$C=\sum_{i\ne j}\Big[w_{ij}\log\tfrac{w_{ij}}{v_{ij}}+(1-w_{ij})\log\tfrac{1-w_{ij}}{1-v_{ij}}\Big]$$

Builds a fuzzy $k$-nearest-neighbour graph in the input space with weights $w_{ij}=\exp\!\bigl(-(d(x_i,x_j)-\rho_i)/\sigma_i\bigr)$, where $\rho_i$ is the distance to the nearest neighbour and $\sigma_i$ normalises to a fixed local radius. A second fuzzy graph $v_{ij}$ is defined on the low-dimensional points via a smooth kernel $1+a\|y_i-y_j\|^{2b}$. The layout is optimised by minimising the cross-entropy $C=\sum_{i\ne j}\bigl[w_{ij}\log\frac{w_{ij}}{v_{ij}}+(1-w_{ij})\log\frac{1-w_{ij}}{1-v_{ij}}\bigr]$ with force-directed gradient descent, which preserves both local and broader topological structure and scales far better than t-SNE.


## When to use

Fast nonlinear embedding for visualization and as a general-purpose feature reducer at scale.

## Watch out

Cluster sizes and distances are not directly meaningful; parameter-sensitive; easy to over-interpret.

## Common fields

Single-cell biology · text embeddings · image embeddings
