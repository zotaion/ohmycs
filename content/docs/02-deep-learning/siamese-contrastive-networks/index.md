---
title: Siamese / Contrastive Networks
weight: 70
type: algorithm
rank: 7
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Similarity learning
description: Similarity learning
fields:
  - Face verification
  - product matching
  - semantic search
---
> **Best for:** Similarity learning

## How it works

$$\mathcal{L}_{ij}=-\log\frac{\exp(\mathrm{sim}(z_i,z_j)/\tau)}{\sum_{k} \exp(\mathrm{sim}(z_i,z_k)/\tau)}$$

Two or more identical encoder branches with tied weights map inputs to
embedding vectors $z=f_\theta(x)$ so that a similarity such as cosine or dot
product reflects semantic closeness. Training optimises a contrastive objective
that pulls embeddings of positive pairs together and pushes negatives apart,
e.g. the InfoNCE loss
$\mathcal{L}_{ij}=-\log\frac{\exp(\mathrm{sim}(z_i,z_j)/\tau)}{\sum_k\exp(\mathrm{sim}(z_i,z_k)/\tau)}$,
where $(i,j)$ is a positive pair and the $k$ index negatives. The result is a
metric space useful for verification, retrieval, or as a self-supervised
pre-trained backbone.


## Common fields

Face verification · product matching · semantic search
