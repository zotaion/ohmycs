---
title: Naive Bayes
weight: 40
type: algorithm
rank: 4
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Simple text classification
description: Simple text classification
fields:
  - Spam
  - sentiment
  - document labels
---
> **Best for:** Simple text classification

## How it works

$$\hat{y}=\arg\max_y\ P(y)\prod_i P(x_i\mid y)$$

For text, Multinomial Naive Bayes models word counts in a document of class
$y$ as draws from a multinomial with
$P(w_i\mid y)=\frac{N_{iy}+\alpha}{N_y+\alpha V}$, where $V$ is the vocabulary
size and $\alpha$ is Laplace smoothing. Prediction combines prior and
likelihood under the conditional-independence assumption,
$\hat{y}=\arg\max_y P(y)\prod_i P(x_i\mid y)$, computed in log-space to avoid
underflow. Despite its independence assumption it is fast, robust on small
datasets, and a long-standing spam/sentiment baseline.


## Common fields

Spam · sentiment · document labels
