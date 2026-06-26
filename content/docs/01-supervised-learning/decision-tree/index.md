---
title: Decision Tree
weight: 50
type: algorithm
rank: 5
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Simple interpretable rules
description: Simple interpretable rules
fields:
  - Business rules
  - education
  - healthcare triage
  - explainable ML
---
> **Best for:** Simple interpretable rules

## How it works

$$\Delta = I(\text{parent})-\sum_j \frac{N_j}{N}\,I(\text{child}_j)$$

Recursively partitions feature space by choosing, at each node, the split that
maximises the impurity reduction
$\Delta=I(\text{parent})-\sum_j\frac{N_j}{N}I(\text{child}_j)$. Common impurity
measures are the Gini index $I=1-\sum_k p_k^2$ and the entropy
$I=-\sum_k p_k\log p_k$; both reward splits that make child nodes purer. Leaves
store the local majority class (classification) or mean response (regression),
and recursion stops at depth, sample-count, or purity thresholds.


## Common fields

Business rules · education · healthcare triage · explainable ML
