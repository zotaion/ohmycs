---
title: Linear Regression / Ridge / Lasso / Elastic Net
weight: 40
type: algorithm
rank: 4
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Numeric prediction, interpretable models
description: Numeric prediction, interpretable models
fields:
  - Economics
  - real estate
  - sales forecasting
  - demand forecasting
---
> **Best for:** Numeric prediction, interpretable models

## How it works

$$\hat{\beta}=(X^\top X+\lambda I)^{-1}X^\top y$$

OLS minimises $\|y-X\beta\|^2$ giving the closed form
$\hat{\beta}=(X^\top X)^{-1}X^\top y$. Ridge adds an $\ell_2$ penalty,
$\hat{\beta}=(X^\top X+\lambda I)^{-1}X^\top y$, shrinking coefficients and
stabilising collinear or singular designs. Lasso uses an $\ell_1$ penalty,
$\|y-X\beta\|^2+\lambda\|\beta\|_1$, yielding sparse coefficients; Elastic Net
combines both via $\|y-X\beta\|^2+\lambda\bigl(\alpha\|\beta\|_1+(1-\alpha)\|\beta\|_2^2\bigr)$.


## Common fields

Economics · real estate · sales forecasting · demand forecasting
