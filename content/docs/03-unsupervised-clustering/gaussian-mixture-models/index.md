---
title: Gaussian Mixture Models
weight: 40
type: algorithm
rank: 4
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Soft probabilistic clusters
description: Soft probabilistic clusters
fields:
  - Finance
  - signal processing
  - customer behavior
---
> **Best for:** Soft probabilistic clusters

## How it works

$$p(x)=\sum_{k=1}^{K}\pi_k\,\mathcal{N}(x\mid\mu_k,\Sigma_k)$$

Models the data density as a weighted sum of Gaussians,
$p(x)=\sum_{k=1}^{K}\pi_k\mathcal{N}(x\mid\mu_k,\Sigma_k)$, so each cluster is
a soft, ellipsoidal component described by mean $\mu_k$, covariance $\Sigma_k$,
and mixing weight $\pi_k$. Parameters are fit by the EM algorithm, alternating
an E-step that computes responsibilities
$r_{ik}=\frac{\pi_k\mathcal{N}(x_i\mid\mu_k,\Sigma_k)}{\sum_j\pi_j\mathcal{N}(x_i\mid\mu_j,\Sigma_j)}$
with an M-step that updates $\pi_k,\mu_k,\Sigma_k$ from those soft assignments.
Each iteration monotonically increases the data log-likelihood and yields
probabilistic (soft) cluster membership.


## Common fields

Finance · signal processing · customer behavior
