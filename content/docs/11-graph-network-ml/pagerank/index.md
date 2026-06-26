---
title: PageRank
weight: 10
type: algorithm
rank: 1
chapter: /docs/11-graph-network-ml/
chapter_key: 11-graph-network-ml
chapter_title: Graph & Network ML
icon: graph
best_for: Node importance
description: Node importance
fields:
  - Search
  - citation networks
  - fraud signals
alt_names:
  - PR
tags:
  - centrality
  - classic
---
> **Best for:** Node importance
> **Aliases:** PR

## How it works

$$PR(p_i)=\frac{1-d}{N}+d\sum_{p_j\in M(p_i)}\frac{PR(p_j)}{L(p_j)}$$

Models a random surfer: with probability $d$ follow an outgoing link, with
probability $1-d$ teleport to any page uniformly at random. The PageRank of
$p_i$ is $PR(p_i)=\frac{1-d}{N}+d\sum_{p_j\in M(p_i)}\frac{PR(p_j)}{L(p_j)}$,
where $M(p_i)$ are pages linking to $p_i$ and $L(p_j)$ is the out-degree of
$p_j$. The score vector is computed by iterating to a fixed point,
equivalently the leading eigenvector of the Google matrix
$G=d\tilde A+\tfrac{1-d}{N}\mathbf 1\mathbf 1^\top$.


## When to use

Computing node importance from link structure alone; SEO, citation analysis, and seed selection.

## Watch out

Insensitive to node/edge features; biased toward high-degree nodes; dangling-node handling required.

## Common fields

Search · citation networks · fraud signals
