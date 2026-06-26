---
title: Neural Collaborative Filtering
weight: 80
type: algorithm
rank: 8
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Recommender systems
description: Recommender systems
fields:
  - E-commerce
  - streaming
  - ads
  - marketplaces
---
> **Best for:** Recommender systems

## How it works

$$\hat{r}_{ui}=\sigma\!\left(f_\theta(p_u,\ q_i)\right)$$

Replaces the fixed inner product of matrix factorisation with learned neural
layers: users and items get embedding vectors $p_u,q_i$ and a network $f_\theta$
combines them to predict the rating
$\hat r_{ui}=\sigma\bigl(f_\theta(p_u,q_i)\bigr)$. The generalised
matrix-factorisation variant uses an element-wise product with learnable
weights, $f_\theta(p_u,q_i)=h^\top(p_u\odot q_i)$, recovering classic MF as a
special case while stacked MLPs allow non-linear user-item interactions. It is
trained to minimise rating or relevance loss (MSE or BCE) over observed
interactions, typically combined with negative sampling.


## Common fields

E-commerce · streaming · ads · marketplaces
