---
title: Exponential Smoothing / ETS / Holt-Winters
weight: 20
type: algorithm
rank: 2
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Trend and seasonality
description: Trend and seasonality
fields:
  - Retail
  - inventory
  - operations
alt_names:
  - ETS
  - Holt-Winters
tags:
  - classical
  - seasonality
---
> **Best for:** Trend and seasonality
> **Aliases:** ETS, Holt-Winters

## How it works

$$\hat y_{t+h|t}=l_t+h\,b_t+s_{t+h-m(k+1)}$$

Decomposes the series into level $l_t$, trend $b_t$, and seasonal $s_t$
components updated by exponentially weighted recursions, e.g.
$l_t=\alpha(y_t-s_{t-m})+(1-\alpha)(l_{t-1}+b_{t-1})$ and
$b_t=\beta(l_t-l_{t-1})+(1-\beta)b_{t-1}$. The $h$-step forecast is
$\hat y_{t+h|t}=l_t+hb_t+s_{t+h-m(k+1)}$, where $m$ is the season length and
$k=\lfloor(h-1)/m\rfloor$. Smoothing parameters $\alpha,\beta,\gamma$ control how
fast each component adapts; additive or multiplicative variants handle constant
vs. growing seasonal amplitude.


## When to use

Business forecasting with trend and seasonality where you want a robust, interpretable baseline fast.

## Watch out

Mostly univariate; assumes a stable seasonal pattern; can lag through regime shifts.

## Common fields

Retail · inventory · operations
