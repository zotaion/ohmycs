---
title: Transformer Forecasting Models
weight: 70
type: algorithm
rank: 7
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Large-scale multivariate forecasting
description: Large-scale multivariate forecasting
fields:
  - Retail
  - logistics
  - cloud metrics
---
> **Best for:** Large-scale multivariate forecasting

## How it works

$$\text{Attn}(Q,K,V)=\text{softmax}\!\left(\frac{QK^\top}{\sqrt{d_k}}\right)V$$

Forecasts with stacks of self-attention layers where each query attends over
all past tokens via $\text{Attn}(Q,K,V)=\text{softmax}(QK^\top/\sqrt{d_k})V$,
giving every past step a learned weight regardless of distance. Causal masking
preserves the time order, while positional encodings inject time information
since the attention operator is permutation-equivariant. Variants like
Informer, Autoformer, and PatchTST add sparse attention, decomposition, or
patching to scale to very long multivariate series.


## Common fields

Retail · logistics · cloud metrics
