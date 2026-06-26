---
title: k-Nearest Neighbors
weight: 70
type: algorithm
rank: 7
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Simple similarity-based prediction
description: Simple similarity-based prediction
fields:
  - Recommenders
  - anomaly detection
  - small classification tasks
---
> **Best for:** Simple similarity-based prediction

## How it works

$$\hat{y}(x)=\frac{1}{k}\sum_{i\in N_k(x)} y_i$$

A purely instance-based learner with no training phase: store the data, then at
query time find the $k$ closest points $N_k(x)$ under a chosen distance metric
(typically Euclidean). For regression it averages,
$\hat{y}(x)=\frac{1}{k}\sum_{i\in N_k(x)} y_i$; for classification it takes a
majority vote, optionally distance-weighted so nearer neighbours count more.
Performance depends heavily on $k$, the distance metric, and feature scaling.


## Common fields

Recommenders · anomaly detection · small classification tasks
