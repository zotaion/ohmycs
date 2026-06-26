---
title: Random Forest
weight: 20
type: algorithm
rank: 2
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Strong baseline, robust tabular modeling
description: Strong baseline, robust tabular modeling
fields:
  - Healthcare
  - credit risk
  - customer analytics
  - ecology
  - operations
alt_names:
  - RF
  - Bagged Trees
tags:
  - tabular
  - ensembles
  - baseline
---
> **Best for:** Strong baseline, robust tabular modeling
> **Aliases:** RF, Bagged Trees

## How it works

$$\hat{f}(x)=\frac{1}{B}\sum_{b=1}^{B}T_b(x)$$

Grows $B$ decorrelated decision trees, each trained on a bootstrap sample of
the data and allowed to consider only a random subset of features at every
split (bagging plus feature subsampling). Prediction averages the trees for
regression, $\hat{f}(x)=\frac{1}{B}\sum_b T_b(x)$, or takes a majority vote
for classification. Averaging many de-correlated trees lowers variance without
raising bias, which is why it is a strong, low-tuning baseline.


## When to use

Strong out-of-the-box baseline for tabular data when you want robustness with minimal tuning and preprocessing.

## Watch out

Large memory footprint and slower prediction than boosting; cannot extrapolate beyond the training range.

## Common fields

Healthcare · credit risk · customer analytics · ecology · operations
