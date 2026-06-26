---
title: Multi-Armed Bandits
weight: 70
type: algorithm
rank: 7
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Exploration vs exploitation
description: Exploration vs exploitation
fields:
  - Ads
  - recommendations
  - pricing
  - clinical trials
---
> **Best for:** Exploration vs exploitation

## How it works

$$a_t=\arg\max_a\ \hat\mu_a+\sqrt{\tfrac{2\ln t}{N_a}}$$

Bandits compress RL to the exploration-exploitation trade-off: pick the arm
$a_t$ that maximises expected reward while still gathering information. The
UCB1 rule $a_t=\arg\max_a\hat\mu_a+\sqrt{2\ln t/N_a}$ adds an optimism bonus
that shrinks as the arm is pulled $N_a$ times, yielding $O(\sqrt{T\ln T})$
regret. Thompson sampling instead draws $\theta_a\sim\text{Beta}(\alpha_a,\beta_a)$
per arm and acts greedily on the draw, which is Bayesian-optimal for the
Bernoulli reward case.


## Common fields

Ads · recommendations · pricing · clinical trials
