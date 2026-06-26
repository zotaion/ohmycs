---
title: Naive Bayes
weight: 80
type: algorithm
rank: 8
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Fast text classification
description: Fast text classification
fields:
  - Spam detection
  - sentiment analysis
  - document classification
---
> **Best for:** Fast text classification

## How it works

$$\hat{y}=\arg\max_y\ P(y)\prod_i P(x_i\mid y)$$

From Bayes' theorem, $P(y\mid x)\propto P(y)\prod_i P(x_i\mid y)$ under the
(strong) assumption that features are conditionally independent given the class.
Prediction is $\hat{y}=\arg\max_y P(y)\prod_i P(x_i\mid y)$. Gaussian NB models
each likelihood as $P(x_i\mid y)=\mathcal{N}(\mu_{iy},\sigma_{iy}^2)$, while
multinomial NB uses event counts (the classic text model). Despite the
unrealistic independence assumption it is fast, robust, and a strong baseline.


## Common fields

Spam detection · sentiment analysis · document classification
