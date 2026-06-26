---
title: 'Gradient Boosted Trees: XGBoost, LightGBM, CatBoost, GBM'
weight: 10
type: algorithm
rank: 1
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: High-performing tabular prediction
description: High-performing tabular prediction
fields:
  - Finance
  - insurance
  - fraud detection
  - pricing
  - marketing
  - medicine
  - churn prediction
alt_names:
  - XGBoost
  - LightGBM
  - CatBoost
  - GBM
tags:
  - tabular
  - boosting
  - ensembles
---
> **Best for:** High-performing tabular prediction
> **Aliases:** XGBoost, LightGBM, CatBoost, GBM

## How it works

$$F_m(x)=F_{m-1}(x)+\nu\,h_m(x)$$

Builds an additive model stage by stage: each new tree $h_m$ is fit to the
pseudo-residuals $r_i=-\left[\frac{\partial L(y_i,F)}{\partial F}\right]_{F=F_{m-1}}$,
i.e. the negative gradient of the loss evaluated at the current prediction.
With a learning rate $\nu$ (shrinkage), the $m$-th tree is chosen to minimise
$\sum_i L\bigl(y_i,F_{m-1}(x_i)+h_m(x_i)\bigr)$, typically by a least-squares fit
to the residuals followed by a line search for the optimal leaf weight.


## When to use

Tabular supervised tasks where predictive performance matters more than interpretability; the default winner on structured data.

## Watch out

Overfits without early stopping and regularization; slower to train than linear models; cannot extrapolate beyond the training range.

## Common fields

Finance · insurance · fraud detection · pricing · marketing · medicine · churn prediction
