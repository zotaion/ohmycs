---
title: 'PPO: Proximal Policy Optimization'
weight: 40
type: algorithm
rank: 4
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Practical deep RL baseline
description: Practical deep RL baseline
fields:
  - Games
  - robotics
  - RLHF-style optimization
---
> **Best for:** Practical deep RL baseline

## How it works

$$L^{\text{CLIP}}(\theta)=\mathbb{E}\bigl[\min\bigl(r_t(\theta)\hat A_t,\ \text{clip}(r_t(\theta),1-\epsilon,1+\epsilon)\hat A_t\bigr)\bigr]$$

A trust-region-style on-policy actor-critic that caps each update so the new
behaviour stays close to the old. With the probability ratio
$r_t(\theta)=\frac{\pi_\theta(a_t\mid s_t)}{\pi_{\theta_{\text{old}}}(a_t\mid s_t)}$,
PPO maximises the clipped surrogate
$\mathbb{E}\bigl[\min\bigl(r_t(\theta)\hat A_t,\text{clip}(r_t(\theta),1-\epsilon,1+\epsilon)\hat A_t\bigr)\bigr]$,
a pessimistic lower bound on the true policy-gradient objective. Combined
with a value baseline and an entropy bonus, this clipping is what makes PPO
stable and broadly usable without second-order optimisation.


## Common fields

Games · robotics · RLHF-style optimization
