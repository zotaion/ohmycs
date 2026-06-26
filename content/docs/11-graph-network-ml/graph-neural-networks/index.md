---
title: Graph Neural Networks
weight: 40
type: algorithm
rank: 4
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Learning from graph structure
description: Learning from graph structure
fields:
  - Molecules
  - fraud
  - knowledge graphs
---
> **Best for:** Learning from graph structure

## How it works

$$h_v^{(l+1)}=\sigma\bigl(W^{(l)}\cdot\text{AGG}(\{h_u^{(l)}:u\in N(v)\})+b\bigr)$$

GNNs learn node representations by neighbourhood message passing. Each layer
updates a node by aggregating its neighbours' features,
$h_v^{(l+1)}=\sigma\bigl(W^{(l)}\cdot\text{AGG}(\{h_u^{(l)}:u\in N(v)\})+b\bigr)$,
where AGG is a permutation-invariant function (sum, mean, max, or attention).
After $L$ layers the embedding $h_v^{(L)}$ encodes the $L$-hop neighbourhood,
supporting node classification, link prediction, and graph-level prediction
via pooling.


## Common fields

Molecules · fraud · knowledge graphs
