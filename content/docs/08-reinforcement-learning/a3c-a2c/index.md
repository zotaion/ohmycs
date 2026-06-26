---
title: A3C / A2C
weight: 50
type: algorithm
rank: 5
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Parallel RL training
description: Parallel RL training
fields:
  - Simulation
  - games
---
> **Best for:** Parallel RL training

## How it works

$$\nabla_\theta J=\mathbb{E}\bigl[\nabla_\theta\log\pi_\theta(a_t\mid s_t)\,(R_t-V_w(s_t))\bigr]$$

Asynchronous Advantage Actor-Critic runs many parallel workers, each
gathering $n$-step returns
$R_t=\sum_{k=0}^{n-1}\gamma^k r_{t+k}+\gamma^n V_w(s_{t+n})$ and pushing
gradients into shared actor and critic parameters. The advantage
$A_t=R_t-V_w(s_t)$ centres the $n$-step return, and the actor update is
$\nabla_\theta\log\pi_\theta(a_t\mid s_t)\,A_t$ plus an entropy regulariser
$-\beta\nabla_\theta H(\pi_\theta)$. A2C is the synchronous, single-clock
equivalent that batches workers together and is typically faster on GPUs.


## Common fields

Simulation · games
