---
title: Bandit Algorithms
weight: 70
type: algorithm
rank: 7
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Online recommendation optimization
description: Online recommendation optimization
fields:
  - Ads
  - personalization
  - experimentation
---
> **Best for:** Online recommendation optimization

## How it works

$$a_t=\arg\max_a\left[\hat{\mu}_a+\sqrt{\tfrac{2\ln t}{N_t(a)}}\right]$$

Frames recommendation as sequential decision-making that must balance exploiting the best-seen arm against exploring others, minimising cumulative regret over rounds. UCB chooses $a_t=\arg\max_a[\hat{\mu}_a+c\sqrt{\ln t/N_t(a)}]$, where the exploration bonus shrinks as the arm is sampled; Thompson sampling instead draws $\theta_a\sim\mathrm{Beta}(\alpha_a,\beta_a)$ per arm and plays $\arg\max_a\theta_a$, updating parameters from observed rewards. Both achieve $O(\log T)$ regret on suitable bandits and power online ad and content personalisation.


## Common fields

Ads · personalization · experimentation
