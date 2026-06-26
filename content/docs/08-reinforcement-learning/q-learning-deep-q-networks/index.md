---
title: Q-Learning / Deep Q-Networks
weight: 10
type: algorithm
rank: 1
chapter: /docs/08-reinforcement-learning/
chapter_key: 08-reinforcement-learning
chapter_title: Reinforcement Learning
icon: rl
best_for: Discrete action problems
description: Discrete action problems
fields:
  - Games
  - robotics simulation
  - optimization
alt_names:
  - DQN
  - Tabular Q-Learning
tags:
  - value-based
  - off-policy
---
> **Best for:** Discrete action problems
> **Aliases:** DQN, Tabular Q-Learning

## How it works

$$Q(s,a)\leftarrow Q(s,a)+\alpha\,[r+\gamma\max_{a'}Q(s',a')-Q(s,a)]$$

Tabular Q-Learning is an off-policy temporal-difference method that bootstraps
the action-value $Q(s,a)$ toward the Bellman optimality target
$r+\gamma\max_{a'}Q(s',a')$, while the on-policy variant SARSA uses
$r+\gamma Q(s',a')$ instead. The Deep Q-Network (DQN) replaces the table with
a network $Q_\theta$ and minimises the squared TD error
$\bigl(r+\gamma\max_{a'}Q_{\theta^-}(s',a')-Q_\theta(s,a)\bigr)^2$ over samples
drawn from a replay buffer, with a slowly tracked target network $\theta^-$.
Double DQN further decouples action selection from evaluation to curb the
overestimation bias of the $\max$ operator.


## When to use

Discrete action spaces where you want an off-policy, value-based method that reuses experience well.

## Watch out

Value overestimation (use Double DQN); unstable without replay buffers and target networks; not for continuous actions.

## Common fields

Games · robotics simulation · optimization
