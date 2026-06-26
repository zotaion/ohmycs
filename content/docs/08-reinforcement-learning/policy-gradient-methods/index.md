---
title: Policy Gradient Methods
weight: 20
type: algorithm
rank: 2
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Direct policy optimization
description: Direct policy optimization
fields:
  - Robotics
  - control
  - games
alt_names:
  - REINFORCE
  - Vanilla PG
tags:
  - policy-based
  - on-policy
---
> **Best for:** Direct policy optimization
> **Aliases:** REINFORCE, Vanilla PG

## How it works

$$\nabla_\theta J(\theta)=\mathbb{E}\bigl[\nabla_\theta\log\pi_\theta(a\mid s)\,G_t\bigr]$$

Directly parameterises the policy $\pi_\theta(a\mid s)$ and raises expected
return $J(\theta)=\mathbb{E}\bigl[\sum_t\gamma^t r_t\bigr]$ by stochastic
gradient ascent. The score-function (likelihood-ratio) trick gives the
REINFORCE gradient $\nabla_\theta J=\mathbb{E}\bigl[\nabla_\theta\log\pi_\theta(a\mid s)\,G_t\bigr]$,
where $G_t=\sum_{k\ge 0}\gamma^k r_{t+k}$ is the Monte Carlo return.
Subtracting a state-dependent baseline $b(s)$ — typically the value
estimate $V_w(s)$ — yields $\nabla_\theta\log\pi_\theta(a\mid s)(G_t-b(s))$,
which is unbiased and dramatically lowers variance.


## When to use

When actions are continuous or stochastic and you want to directly optimize expected return.

## Watch out

High variance; needs baselines and many rollouts; slow and unstable without variance reduction.

## Common fields

Robotics · control · games
