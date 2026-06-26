---
title: Graph Neural Networks
weight: 60
type: algorithm
rank: 6
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Graph-structured data
description: Graph-structured data
fields:
  - Drug discovery
  - social networks
  - fraud rings
  - recommendations
---
> **Best for:** Graph-structured data

## How it works

$$h_v^{(k)}=\phi\!\left(W h_v^{(k-1)},\ \square_{u\in\mathcal{N}(v)} \psi(h_u^{(k-1)})\right)$$

A GNN updates each node's feature vector by combining its own previous state
with an aggregation of its neighbours,
$h_v^{(k)}=\phi\bigl(W h_v^{(k-1)},\,\square_{u\in\mathcal{N}(v)}\psi(h_u^{(k-1)})\bigr)$,
where $\square$ is a permutation-invariant aggregator (sum, mean or max).
A Graph Convolutional Network uses the specific spectral update
$H^{(k)}=\sigma(\tilde D^{-1/2}\tilde A\tilde D^{-1/2}H^{(k-1)}W)$ with the
normalised adjacency, while GAT learns attention weights over neighbours.
Stacking $K$ layers propagates information across $K$-hop neighbourhoods, and
node- or graph-level readouts produce the final predictions.


## Common fields

Drug discovery · social networks · fraud rings · recommendations
