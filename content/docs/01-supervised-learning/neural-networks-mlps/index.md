---
title: Neural Networks / MLPs
weight: 100
type: algorithm
rank: 10
chapter: /docs/01-supervised-learning/
chapter_key: 01-supervised
chapter_title: 'Supervised Learning: Regression & Classification'
icon: supervised
best_for: Nonlinear supervised learning
description: Nonlinear supervised learning
fields:
  - Tabular DL
  - forecasting
  - embeddings
  - scientific ML
---
> **Best for:** Nonlinear supervised learning

## How it works

$$a^{(l)}=\sigma\!\left(W^{(l)}a^{(l-1)}+b^{(l)}\right)$$

Stacks affine layers $z^{(l)}=W^{(l)}a^{(l-1)}+b^{(l)}$ followed by a nonlinear
activation $a^{(l)}=\sigma(z^{(l)})$, composing many such layers to approximate
complex functions. Training minimises a loss $L$ over the data by gradient
descent, with gradients computed by backpropagation — the chain rule applied
layer by layer: $\delta^{(l)}=(W^{(l+1)})^\top\delta^{(l+1)}\odot\sigma'(z^{(l)})$
and $\frac{\partial L}{\partial W^{(l)}}=\delta^{(l)}\bigl(a^{(l-1)}\bigr)^\top$.


## Common fields

Tabular DL · forecasting · embeddings · scientific ML
