---
title: Autoencoders
weight: 60
type: algorithm
rank: 6
chapter: /docs/04-dimensionality-reduction/
chapter_key: 04-dimensionality-reduction
chapter_title: Dimensionality Reduction & Representation Learning
icon: reduce
best_for: Learned nonlinear embeddings
description: Learned nonlinear embeddings
fields:
  - Anomaly detection
  - compression
  - denoising
---
> **Best for:** Learned nonlinear embeddings

## How it works

$$\min_\theta\ \tfrac{1}{n}\sum_i\|x_i-D(E(x_i;\theta_e);\theta_d)\|^2$$

An encoder maps the input to a low-dimensional bottleneck code $z=E(x;\theta_e)$ and a decoder reconstructs it as $\hat{x}=D(z;\theta_d)$. Training minimises reconstruction loss $\sum_i\|x_i-\hat{x}_i\|^2$ (or cross-entropy), so the bottleneck must capture the data's essential structure. Important variants include denoising autoencoders (reconstruct a clean $x$ from a corrupted input), sparse autoencoders (with a sparsity penalty on $z$), and variational autoencoders (with a KL term $\mathrm{KL}(q(z|x)\|p(z))$ regularising a Gaussian latent).


## Common fields

Anomaly detection · compression · denoising
