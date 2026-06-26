---
title: Deep Recommenders / Two-Tower Models
weight: 60
type: algorithm
rank: 6
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Large-scale retrieval and ranking
description: Large-scale retrieval and ranking
fields:
  - YouTube-style feeds
  - ads
  - social platforms
---
> **Best for:** Large-scale retrieval and ranking

## How it works

$$s(u,i)=E_u(u)^\top E_i(i),\quad L=-\log\frac{\exp(s(u,i)/\tau)}{\sum_{j}\exp(s(u,j)/\tau)}$$

Encodes users and items into $d$-dimensional embeddings through separate towers $E_u$ and $E_i$, scored by dot product $s(u,i)=E_u(u)^\top E_i(i)$ so that serving reduces to fast maximum-inner-product search. Training uses a sampled-softmax (infoNCE) contrastive loss $L=-\log\frac{\exp(s(u,i)/\tau)}{\sum_j\exp(s(u,j)/\tau)}$ over the positive interaction and a sample of negatives. A heavier cross-attention or GBDT ranker (DCN, DIN) then re-ranks the retrieved candidates using richer side features.


## Common fields

YouTube-style feeds · ads · social platforms
