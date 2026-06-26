---
title: Generalized Linear Models
weight: 90
type: algorithm
rank: 9
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Structured statistical modeling
description: Structured statistical modeling
fields:
  - Biostatistics
  - actuarial science
  - econometrics
---
> **Best for:** Structured statistical modeling

## How it works

$$g(\mu)=\beta^\top x$$

Extends linear regression to any exponential-family response via a link function
$g$ relating the mean to a linear predictor, $g(\mu)=\beta^\top x$, so
$\mu=g^{-1}(\beta^\top x)$. Standard choices are the identity link (Gaussian/linear
regression), the logit link (Binomial/logistic) and the log link (Poisson counts).
Coefficients are estimated by maximum likelihood via IRWLS, reweighting
observations by the variance function at each iteration.


## Common fields

Biostatistics · actuarial science · econometrics
