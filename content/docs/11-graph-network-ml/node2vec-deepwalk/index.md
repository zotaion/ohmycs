---
title: Node2Vec / DeepWalk
weight: 30
type: algorithm
rank: 3
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Graph embeddings
description: Graph embeddings
fields:
  - Recommendations
  - link prediction
alt_names:
  - DeepWalk
  - Node2Vec
  - Random-Walk Embeddings
tags:
  - embeddings
  - unsupervised
---
> **Best for:** Graph embeddings
> **Aliases:** DeepWalk, Node2Vec, Random-Walk Embeddings

## How it works

$$\max_\theta\sum_u\sum_{v\in N(u)}\log p(v\mid u;\theta)$$

Generates many random walks over the graph — in Node2Vec biased by parameters
$p,q$ that interpolate between BFS and DFS exploration — and feeds the walk
sequences to a skip-gram model. The objective maximises
$\sum_u\sum_{v\in N(u)}\log p(v\mid u;\theta)$ over learned node embeddings
$z_u\in\mathbb R^d$. The resulting low-dimensional vectors preserve
structural proximity and serve as features for downstream tasks such as
node classification and link prediction.


## When to use

Generating node embeddings for downstream ML when you need simple, scalable feature learning.

## Watch out

Random-walk parameters shape results; ignores edge/feature updates; superseded by GNNs for many tasks.

## Common fields

Recommendations · link prediction
