---
title: Support Vector Machine / SVR
weight: 60
type: algorithm
rank: 6
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Smaller datasets, high-dimensional data
description: Smaller datasets, high-dimensional data
fields:
  - Bioinformatics
  - text classification
  - image features
---
> **Best for:** Smaller datasets, high-dimensional data

## How it works

$$\min_{w,b}\ \tfrac{1}{2}\|w\|^2\quad\text{s.t.}\quad y_i(w^\top\phi(x_i)+b)\ge 1$$

Finds the maximum-margin separating hyperplane by minimising $\tfrac{1}{2}\|w\|^2$
subject to $y_i\bigl(w^\top\phi(x_i)+b\bigr)\ge 1$, with slack variables added for
non-separable data. Moving to the dual gives the objective
$\sum_i\alpha_i-\tfrac{1}{2}\sum_{i,j}\alpha_i\alpha_j y_i y_j K(x_i,x_j)$, where the
kernel $K(x_i,x_j)=\phi(x_i)^\top\phi(x_j)$ allows nonlinear boundaries and the
support vectors (nonzero $\alpha_i$) define the decision boundary. SVR replaces
the margin constraints with an $\epsilon$-insensitive loss that ignores errors
within $\epsilon$ of the target.


## Common fields

Bioinformatics · text classification · image features
