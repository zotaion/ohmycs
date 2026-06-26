---
title: Collaborative Filtering
weight: 10
type: algorithm
rank: 1
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: User-item recommendations
description: User-item recommendations
fields:
  - E-commerce
  - streaming
  - news feeds
alt_names:
  - CF
  - User-Based CF
  - Item-Based CF
  - KNN CF
tags:
  - recommender
  - collaborative
---
> **Best for:** User-item recommendations
> **Aliases:** CF, User-Based CF, Item-Based CF, KNN CF

## How it works

$$\hat{r}_{ui}=\bar{r}_u+\frac{\sum_{v\in N(u)}\mathrm{sim}(u,v)(r_{vi}-\bar{r}_v)}{\sum_{v\in N(u)}|\mathrm{sim}(u,v)|}$$

User-based CF predicts a rating as a mean-centred weighted average over neighbour users $N(u)$, using similarity $\mathrm{sim}(u,v)$ such as cosine $\frac{r_u\cdot r_v}{\|r_u\|\|r_v\|}$ or Pearson correlation on co-rated items. Item-based CF reverses the roles and aggregates over items most similar to the target. Memory-based KNN variants are simple and interpretable but scale poorly, and similarities shrink towards zero when few ratings are shared, motivating shrinkage or regularised estimates.


## When to use

Recommending from user-item interaction matrices when you have enough ratings/interactions per user.

## Watch out

Cold-start for new users and items; sparse data hurts; naive KNN scales poorly to large catalogs.

## Common fields

E-commerce · streaming · news feeds
