---
title: Diffusion Models
weight: 60
type: algorithm
rank: 6
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Image generation/editing
description: Image generation/editing
fields:
  - Design
  - media
  - advertising
---
> **Best for:** Image generation/editing

## How it works

$$L=\mathbb{E}_{t,x_0,\epsilon}\bigl\|\epsilon-\epsilon_\theta(x_t,t)\bigr\|^2$$

Generative models trained to reverse a noising process. Forward diffusion
adds Gaussian noise on a variance schedule,
$x_t=\sqrt{\bar\alpha_t}\,x_0+\sqrt{1-\bar\alpha_t}\,\epsilon$ over $T$ steps,
and a (usually U-Net) network learns to predict the added noise
$\epsilon_\theta(x_t,t)$. Training minimises the denoising objective
$L=\mathbb{E}_{t,x_0,\epsilon}\bigl\|\epsilon-\epsilon_\theta(x_t,t)\bigr\|^2$.
Sampling starts from $x_T\sim\mathcal N(0,I)$ and iteratively denoises back to
a clean image, optionally guided by text or other conditions.


## Common fields

Design · media · advertising
