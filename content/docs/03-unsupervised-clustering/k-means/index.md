---
title: k-Means
weight: 10
type: algorithm
rank: 1
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Fast general clustering
description: Fast general clustering
fields:
  - Customer segmentation
  - vector clustering
  - compression
alt_names:
  - K-Means
  - Lloyd's Algorithm
tags:
  - clustering
  - fast
  - prototype
---
> **Best for:** Fast general clustering
> **Aliases:** K-Means, Lloyd's Algorithm

## How it works

$$J=\sum_{i=1}^{n}\|x_i-\mu_{c_i}\|^2$$

Minimises the within-cluster sum of squares
$J=\sum_{i=1}^{n}\|x_i-\mu_{c_i}\|^2$ over assignments $c_i\in\{1,\ldots,k\}$
and centroids $\mu_c$. Lloyd's algorithm alternates two steps until
convergence: assign each point to its nearest centroid,
$c_i=\arg\min_c\|x_i-\mu_c\|^2$, then set each centroid to the mean of its
members, $\mu_c=\frac{1}{|C_c|}\sum_{i\in C_c}x_i$. Each step strictly
decreases $J$, so it converges to a local optimum; k-means++ initialisation
and multiple restarts reduce the risk of poor local minima.


## When to use

Fast convex clustering at scale; vector quantization and pre-clustering for downstream pipelines.

## Watch out

You must pick k; assumes equal-variance spherical clusters; sensitive to outliers and feature scaling; no noise label.

## Common fields

Customer segmentation · vector clustering · compression
