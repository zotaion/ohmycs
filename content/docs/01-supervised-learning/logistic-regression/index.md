---
title: Logistic Regression
weight: 30
type: algorithm
rank: 3
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Binary/multiclass classification, interpretable baseline
description: Binary/multiclass classification, interpretable baseline
fields:
  - Credit scoring
  - medical risk
  - marketing response
  - A/B testing
alt_names:
  - Logit
  - MaxEnt
tags:
  - classification
  - interpretable
  - baseline
---
> **Best for:** Binary/multiclass classification, interpretable baseline
> **Aliases:** Logit, MaxEnt

## How it works

$$\sigma(\beta^\top x)=\frac{1}{1+e^{-\beta^\top x}}$$

Models the class probability through a linear logit,
$\log\frac{p}{1-p}=\beta^\top x$, so $p=\sigma(\beta^\top x)=\frac{1}{1+e^{-\beta^\top x}}$.
Coefficients are fit by maximising the log-likelihood
$\sum_i\bigl[y_i\log p_i+(1-y_i)\log(1-p_i)\bigr]$, equivalently minimising the
cross-entropy loss. The objective is convex and is solved by gradient descent
or by Newton/IRWLS; $\ell_1$/$\ell_2$ regularisation extends it to Lasso/Ridge logits.


## When to use

Binary/multiclass classification where you need a fast, interpretable, well-calibrated probabilistic baseline.

## Watch out

Assumes linear log-odds; needs careful feature scaling and encoding; underfits complex nonlinear relationships.

## Common fields

Credit scoring · medical risk · marketing response · A/B testing
