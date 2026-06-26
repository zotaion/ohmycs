---
title: Content-Based Filtering
weight: 30
type: algorithm
rank: 3
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Recommending similar items
description: Recommending similar items
fields:
  - Retail
  - jobs
  - real estate
  - articles
alt_names:
  - Content-Based
tags:
  - recommender
  - content
---
> **Best for:** Recommending similar items
> **Aliases:** Content-Based

## How it works

$$\hat{r}_{ui}=\cos(h_u,x_i),\quad h_u=\frac{1}{|I_u|}\sum_{i\in I_u}x_i$$

Builds a user profile $h_u$ by aggregating the feature vectors $x_i$ of items the user has liked, then scores new items by similarity to that profile, e.g. $\hat{r}_{ui}=\cos(h_u,x_i)$ or a learned scorer $f_\theta(x_i)^\top h_u$. Because it relies on item features (text, tags, attributes) rather than other users' ratings, it handles item cold-start well. The trade-off is over-specialisation: it rarely surfaces items outside the feature pattern the user already engaged with.


## When to use

Recommendation from item features when interaction data is thin; for cold-start of long-tail items.

## Watch out

Over-specializes to items similar to what the user already likes; quality is bounded by feature engineering.

## Common fields

Retail · jobs · real estate · articles
