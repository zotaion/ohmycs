---
title: 'NMF: Non-negative Matrix Factorization'
weight: 50
type: algorithm
rank: 5
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: Parts-based decomposition
description: Parts-based decomposition
fields:
  - Topic modeling
  - image decomposition
  - recommender systems
---
> **Best for:** Parts-based decomposition

## How it works

$$\min_{W,H\ge 0}\ \|X-WH\|_F^2$$

Factorises a non-negative matrix $X\in\mathbb{R}_+^{m\times n}$ as $X\approx WH$ with $W,H\ge 0$ by minimising $\|X-WH\|_F^2$ (or a generalised KL divergence). The non-negativity constraints yield a parts-based, additive representation that is typically more interpretable than signed factorisations. Optimisation alternates multiplicative updates $H_{aj}\leftarrow H_{aj}\frac{(W^\top X)_{aj}}{(W^\top WH)_{aj}}$ and $W_{ia}\leftarrow W_{ia}\frac{(XH^\top)_{ia}}{(WHH^\top)_{ia}}$, which keep all entries non-negative, or block non-negative least squares.


## Common fields

Topic modeling · image decomposition · recommender systems
