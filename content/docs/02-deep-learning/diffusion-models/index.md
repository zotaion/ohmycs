---
title: Diffusion Models
weight: 50
type: algorithm
rank: 5
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Generative images/audio/video
description: Generative images/audio/video
fields:
  - Image generation
  - design
  - media
  - simulation
---
> **Best for:** Generative images/audio/video

## How it works

$$p_\theta(x_{t-1}\mid x_t)=\mathcal{N}\!\left(\mu_\theta(x_t,t),\,\sigma_t^2 I\right)$$

Training corrupts data with a fixed forward Markov chain
$q(x_t\mid x_{t-1})=\mathcal{N}\bigl(x_t;\sqrt{1-\beta_t}\,x_{t-1},\beta_t I\bigr)$
that gradually adds Gaussian noise until $x_T$ is pure noise. A network is then
fit to reverse each step,
$p_\theta(x_{t-1}\mid x_t)=\mathcal{N}(\mu_\theta(x_t,t),\sigma_t^2 I)$, which
is equivalent to predicting the noise $\epsilon$ added at step $t$ via the
simplified loss $\mathbb{E}_{x_0,\epsilon,t}\bigl\|\epsilon-\epsilon_\theta(x_t,t)\bigr\|^2$.
Generation samples $x_T\sim\mathcal{N}(0,I)$ and applies the learned reverse
transitions to denoise back to $x_0$.


## Common fields

Image generation · design · media · simulation
