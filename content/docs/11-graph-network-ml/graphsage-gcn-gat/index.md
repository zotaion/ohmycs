---
title: GraphSAGE / GCN / GAT
weight: 50
type: algorithm
rank: 5
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Scalable graph representation learning
description: Scalable graph representation learning
fields:
  - Social networks
  - recommender systems
  - cybersecurity
---
> **Best for:** Scalable graph representation learning

## How it works

$$H^{(l+1)}=\sigma\bigl(\tilde D^{-1/2}\tilde A\tilde D^{-1/2}H^{(l)}W^{(l)}\bigr)$$

Concrete GNN variants. GCN propagates with the normalised adjacency
$\tilde A=A+I$:
$H^{(l+1)}=\sigma\bigl(\tilde D^{-1/2}\tilde A\tilde D^{-1/2}H^{(l)}W^{(l)}\bigr)$.
GraphSAGE samples a fixed neighbour set and concatenates,
$h_v=\sigma\bigl(W\cdot\text{CONCAT}(h_v,\text{AGG}(\{h_u:u\in N(v)\}))\bigr)$.
GAT replaces aggregation with learned attention
$\alpha_{ij}=\text{softmax}_j\bigl(\text{LeakyReLU}(a^\top[Wh_i\|Wh_j])\bigr)$,
weighting different neighbours differently.


## Common fields

Social networks · recommender systems · cybersecurity
