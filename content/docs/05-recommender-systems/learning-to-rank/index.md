---
title: Learning-to-Rank
weight: 50
type: algorithm
rank: 5
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Ranking search/recommendation results
description: Ranking search/recommendation results
fields:
  - Search engines
  - ads
  - marketplaces
---
> **Best for:** Ranking search/recommendation results

## How it works

$$L=\sum_{i\succ j}\log\!\bigl(1+\exp(s_j-s_i)\bigr)$$

Treats ranking as supervised learning over query-document features using pointwise, pairwise, or listwise losses. Pairwise losses (RankNet) apply logistic loss to score differences for a preferred pair $i\succ j$, $L=\log(1+\exp(s_j-s_i))$, while listwise methods such as LambdaMART or ListMLE weight gradients by ranking-quality gains like NDCG. The score $s=f_\theta(x)$ is typically produced by a gradient-boosted tree or neural ranker trained on millions of judged query-document pairs.


## Common fields

Search engines · ads · marketplaces
