---
title: Matrix Factorization / SVD / ALS
weight: 20
type: algorithm
rank: 2
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Sparse rating or interaction data
description: Sparse rating or interaction data
fields:
  - Movies
  - products
  - music
  - marketplaces
alt_names:
  - SVD
  - ALS
  - Latent Factor Model
tags:
  - recommender
  - latent
---
> **Best for:** Sparse rating or interaction data
> **Aliases:** SVD, ALS, Latent Factor Model

## How it works

$$\min_{P,Q}\ \sum_{(u,i)\in\Omega}(r_{ui}-p_u^\top q_i)^2+\lambda(\|p_u\|^2+\|q_i\|^2)$$

Factorises the ratings matrix as $R\approx PQ^\top$ using rank-$k$ user vectors $p_u$ and item vectors $q_i$, learned by minimising the regularised squared error over observed entries $\Omega$. SGD updates each pair with the residual error $e_{ui}=r_{ui}-p_u^\top q_i$; ALS instead alternately solves each side as a regularised least-squares problem with the other fixed, which parallelises well and suits implicit feedback. Adding biases $b_u+b_i+\mu$ and confidence weights on unobserved entries extends the model to sparse implicit-feedback data.


## When to use

Sparse rating or interaction data at scale; classic Netflix-prize-style latent-factor recommenders.

## Watch out

Cold-start still applies; rank and regularization matter; implicit-feedback needs special variants.

## Common fields

Movies · products · music · marketplaces
