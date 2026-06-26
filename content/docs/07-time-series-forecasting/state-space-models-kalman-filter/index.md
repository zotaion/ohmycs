---
title: State Space Models / Kalman Filter
weight: 80
type: algorithm
rank: 8
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Dynamic systems
description: Dynamic systems
fields:
  - Robotics
  - navigation
  - economics
---
> **Best for:** Dynamic systems

## How it works

$$x_t=F_t x_{t-1}+w_t,\quad y_t=H_t x_t+v_t$$

Represents the system as latent dynamics $x_t=F_t x_{t-1}+w_t$ and an
observation equation $y_t=H_t x_t+v_t$ with Gaussian process/measurement noise.
The Kalman filter alternates a predict step,
$\hat x_{t|t-1}=F_t\hat x_{t-1|t-1}$ with covariance
$P_{t|t-1}=F_tP_{t-1|t-1}F_t^\top+Q$, and an update step that folds in the new
observation via the Kalman gain $K_t=P_{t|t-1}H_t^\top(H_tP_{t|t-1}H_t^\top+R)^{-1}$.
This yields the minimum-variance linear estimate of the latent state and is
optimal when the model is linear-Gaussian.


## Common fields

Robotics · navigation · economics
