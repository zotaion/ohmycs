---
title: Temporal CNN / TCN
weight: 60
type: algorithm
rank: 6
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Long sequence forecasting
description: Long sequence forecasting
fields:
  - Industrial IoT
  - signals
---
> **Best for:** Long sequence forecasting

## How it works

$$y_t=f(x_{t},x_{t-1},\dots,x_{t-k})\ \text{via dilated causal convolutions}$$

Applies stacks of 1-D causal convolutions so each output depends only on
present and past inputs, $y_t=f(x_t,x_{t-1},\dots,x_{t-k})$, with dilation rates
growing exponentially to give a large receptive field cheaply. Residual
connections and causal masking preserve the time order and stabilise deep
stacks, while parallel convolution makes training far faster than recurrent
alternatives. A TCN matches or beats LSTMs on many sequence benchmarks while
keeping a fixed, deterministic receptive field.


## Common fields

Industrial IoT · signals
