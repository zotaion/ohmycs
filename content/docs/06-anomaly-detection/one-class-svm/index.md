---
title: One-Class SVM
weight: 20
type: algorithm
rank: 2
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: Novelty detection on smaller datasets
description: Novelty detection on smaller datasets
fields:
  - Manufacturing
  - security
  - quality control
alt_names:
  - OC-SVM
tags:
  - anomaly
  - kernel
---
> **Best for:** Novelty detection on smaller datasets
> **Aliases:** OC-SVM

## How it works

$$\min_{w,\rho}\ \tfrac{1}{2}\|w\|^2-\rho+\frac{1}{\nu n}\sum_{i=1}^{n}\max(0,\,\rho-w^\top\phi(x_i))$$

Maps the data into a high-dimensional feature space via $\phi$ and separates it
from the origin by maximising the margin $\rho$ slackened by a hinge term,
$\min_{w,\rho}\tfrac{1}{2}\|w\|^2-\rho+\frac{1}{\nu n}\sum_i\max(0,\rho-w^\top\phi(x_i))$.
The hyperparameter $\nu\in(0,1]$ upper-bounds the training error fraction and
lower-bounds the support fraction, trading false alarms for misses. A point is
anomalous when $w^\top\phi(x)<\rho$, and the kernel trick makes the boundary
nonlinear.


## When to use

Novelty detection on smaller, well-behaved datasets where you can describe 'normal' as a tight region.

## Watch out

O(n^2+) training cost — doesn't scale; nu and kernel choice matter; sensitive to feature scaling.

## Common fields

Manufacturing · security · quality control
