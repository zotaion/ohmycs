---
title: 'LDA: Linear Discriminant Analysis'
weight: 40
type: algorithm
rank: 4
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: Supervised projection/classification
description: Supervised projection/classification
fields:
  - Face recognition
  - medical classification
---
> **Best for:** Supervised projection/classification

## How it works

$$W=\arg\max_W\ \frac{\mathrm{tr}(W^\top S_B W)}{\mathrm{tr}(W^\top S_W W)}$$

Defines within-class scatter $S_W=\sum_c\sum_{i:y_i=c}(x_i-\mu_c)(x_i-\mu_c)^\top$ and between-class scatter $S_B=\sum_c n_c(\mu_c-\mu)(\mu_c-\mu)^\top$ from the class means $\mu_c$ and global mean $\mu$. Fisher's criterion maximises the ratio $\frac{\mathrm{tr}(W^\top S_B W)}{\mathrm{tr}(W^\top S_W W)}$, whose solution is the top eigenvectors of $S_W^{-1}S_B$. The projection $Z=XW$ yields at most $C-1$ discriminant directions for $C$ classes, chosen to pull same-class points together and push different-class means apart.


## Common fields

Face recognition · medical classification
