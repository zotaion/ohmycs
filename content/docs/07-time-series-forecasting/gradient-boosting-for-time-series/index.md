---
title: Gradient Boosting for Time Series
weight: 40
type: algorithm
rank: 4
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Feature-based forecasting
description: Feature-based forecasting
fields:
  - Demand forecasting
  - pricing
  - operations
---
> **Best for:** Feature-based forecasting

## How it works

$$F_M(x_t)=\sum_{m=1}^{M}h_m(x_t),\quad x_t=[y_{t-1},y_{t-2},\dots,y_{t-l}]$$

Reframes forecasting as supervised regression: the series is embedded into
feature vectors $x_t=[y_{t-1},y_{t-2},\dots,y_{t-l}]$ of lagged values, rolling
statistics, calendar dummies, and exogenous variables, with target $y_{t+h}$. A
boosted ensemble $F_M(x_t)=\sum_{m=1}^{M}h_m(x_t)$ is then built stage-wise,
each tree fitting the gradient of the loss at the previous prediction. Powerful
for nonlinear interactions among engineered features, but it needs careful
lag/window engineering and leakage-free validation.


## Common fields

Demand forecasting · pricing · operations
