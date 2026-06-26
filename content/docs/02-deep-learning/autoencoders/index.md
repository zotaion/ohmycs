---
title: Autoencoders
weight: 40
type: algorithm
rank: 4
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Compression, denoising, anomaly detection
description: Compression, denoising, anomaly detection
fields:
  - Cybersecurity
  - manufacturing
  - medical imaging
---
> **Best for:** Compression, denoising, anomaly detection

## How it works

$$\min_{\theta,\phi}\ \frac{1}{n}\sum_{i=1}^{n}\|x_i-D_\phi(E_\theta(x_i))\|^2$$

An autoencoder compresses each input $x$ into a low-dimensional code
$z=E_\theta(x)$ through an encoder and reconstructs it as
$\hat x=D_\phi(z)$, training the bottleneck to minimise reconstruction error
$\|x-\hat x\|^2$. Forcing $z$ to be low-dimensional (or adding noise, as in a
denoising autoencoder) makes the code capture the data's dominant structure
rather than copy the input. Variational autoencoders regularise $z$ with a KL
term to a prior,
$\mathcal{L}=\mathbb{E}_{q(z|x)}[\log p(x|z)]-D_{\mathrm{KL}}(q(z|x)\,\|\,p(z))$,
enabling generative sampling.


## Common fields

Cybersecurity · manufacturing · medical imaging
