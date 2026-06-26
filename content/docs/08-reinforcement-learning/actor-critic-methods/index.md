---
title: Actor-Critic Methods
weight: 30
type: algorithm
rank: 3
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Stable deep RL
description: Stable deep RL
fields:
  - Robotics
  - autonomous systems
alt_names:
  - A2C
  - A3C
  - SAC
  - TD3
tags:
  - actor-critic
  - modern
---
> **Best for:** Stable deep RL
> **Aliases:** A2C, A3C, SAC, TD3

## How it works

$$A_t^{\text{GAE}}=\sum_{l=0}^{\infty}(\gamma\lambda)^l\delta_{t+l},\quad \delta_t=r_t+\gamma V_w(s_{t+1})-V_w(s_t)$$

Combines a policy network (the actor $\pi_\theta$) with a value network (the
critic $V_w$); the critic turns the noisy return $G_t$ into a low-variance
advantage $A_t=r_t+\gamma V_w(s_{t+1})-V_w(s_t)$, the one-step TD error
$\delta_t$. The actor follows $\nabla_\theta\log\pi_\theta(a_t\mid s_t)\,A_t$
while the critic regresses toward $r_t+\gamma V_w(s_{t+1})$. Generalised
Advantage Estimation (GAE) blends Monte Carlo and TD($\lambda$) via
$A_t^{\text{GAE}}=\sum_l(\gamma\lambda)^l\delta_{t+l}$; SAC adds an entropy
bonus $-\alpha\log\pi_\theta$ to encourage exploration.


## When to use

Modern deep RL where you want stable learning combining value and policy networks.

## Watch out

Twin-critic and entropy tuning matter (SAC); sensitive to hyperparameters and reward shaping; sample efficiency varies.

## Common fields

Robotics · autonomous systems
