---
title: PCA
weight: 10
type: algorithm
rank: 1
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: Compression, visualization, noise reduction
description: Compression, visualization, noise reduction
fields:
  - Finance
  - biology
  - image processing
  - preprocessing
alt_names:
  - Principal Component Analysis
  - Karhunen-Loève
tags:
  - linear
  - compression
  - visualization
---
> **Best for:** Compression, visualization, noise reduction
> **Aliases:** Principal Component Analysis, Karhunen-Loève

## How it works

$$Z=X_cW,\ \ \Sigma w_j=\lambda_j w_j\ (\lambda_1\ge\dots\ge\lambda_d)$$

Centers the data and computes the covariance $\Sigma=\tfrac{1}{n}X_c^\top X_c$, whose top eigenvectors $W=[w_1,\dots,w_k]$ span the directions of greatest variance. Projecting $Z=X_cW$ keeps the $k$ largest eigenvalues $\sum_{j\le k}\lambda_j$ of total variance, equivalent to minimising the reconstruction error $\|X_c-X_cWW^\top\|_F^2$ over orthonormal $W$. In practice $W$ is read from the SVD $X_c=U\Sigma V^\top$ as the first $k$ right singular vectors; components are uncorrelated but the model is strictly linear.


## When to use

Linear compression, denoising, decorrelation, and quick 2D/3D visualization as a first step.

## Watch out

Linear only; sensitive to feature scale and outliers; principal axes can be hard to interpret.

## Common fields

Finance · biology · image processing · preprocessing
