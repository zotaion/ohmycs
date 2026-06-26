---
title: DDPG / TD3 / SAC
weight: 60
type: algorithm
rank: 6
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Continuous control
description: Continuous control
fields:
  - Robotics
  - autonomous driving
  - industrial control
---
> **Best for:** Continuous control

## How it works

$$\nabla_\theta J=\mathbb{E}\bigl[\nabla_a Q_w(s,a)\big|_{a=\mu_\theta(s)}\,\nabla_\theta\mu_\theta(s)\bigr]$$

Deterministic Policy Gradient methods extend Q-learning to continuous
actions by learning a deterministic actor $\mu_\theta(s)$ and a critic
$Q_w(s,a)$ off-policy. The deterministic policy gradient theorem gives
$\nabla_\theta J=\mathbb{E}\bigl[\nabla_a Q_w(s,a)\big|_{a=\mu_\theta(s)}\nabla_\theta\mu_\theta(s)\bigr]$,
while the critic is fit to the Bellman target
$r+\gamma Q_{w^-}(s',\mu_{\theta^-}(s'))$. TD3 fixes DDPG's overestimation
with clipped double-Q critics and delayed actor updates, and SAC replaces
determinism with a maximum-entropy objective $Q(s,a)-\alpha\log\pi(a\mid s)$.


## Common fields

Robotics · autonomous driving · industrial control
