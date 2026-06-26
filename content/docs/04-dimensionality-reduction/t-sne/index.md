---
title: t-SNE
weight: 20
type: algorithm
rank: 2
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: 2D/3D visualization
description: 2D/3D visualization
fields:
  - NLP embeddings
  - genomics
  - exploratory analysis
alt_names:
  - t-Distributed Stochastic Neighbor Embedding
tags:
  - visualization
  - nonlinear
---
> **Best for:** 2D/3D visualization
> **Aliases:** t-Distributed Stochastic Neighbor Embedding

## How it works

$$C=\mathrm{KL}(P\|Q)=\sum_{i\ne j}p_{ij}\log\frac{p_{ij}}{q_{ij}}$$

Defines high-dimensional affinities $p_{j|i}=\frac{\exp(-\|x_i-x_j\|^2/2\sigma_i^2)}{\sum_{k\ne i}\exp(-\|x_i-x_k\|^2/2\sigma_i^2)}$, symmetrised to $p_{ij}=\tfrac{1}{2n}(p_{j|i}+p_{i|j})$, with bandwidth $\sigma_i$ chosen so each conditional hits a target perplexity. Low-dimensional affinities use a heavy-tailed Student-t kernel, $q_{ij}=\frac{(1+\|y_i-y_j\|^2)^{-1}}{\sum_{k\ne l}(1+\|y_k-y_l\|^2)^{-1}}$, which relieves the crowding problem. The embedding $\{y_i\}$ is fit by gradient descent to minimise $C=\mathrm{KL}(P\|Q)=\sum_{i\ne j}p_{ij}\log\frac{p_{ij}}{q_{ij}}$, preserving local neighbourhoods rather than global geometry.


## When to use

Visualizing high-dimensional data in 2D/3D where preserving local neighborhood structure matters.

## Watch out

For visualization only — not for downstream modeling; costly on large n; distorts global structure; tune perplexity.

## Common fields

NLP embeddings · genomics · exploratory analysis
