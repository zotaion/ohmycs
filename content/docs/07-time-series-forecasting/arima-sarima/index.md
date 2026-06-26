---
title: ARIMA / SARIMA
weight: 10
type: algorithm
rank: 1
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Classical univariate forecasting
description: Classical univariate forecasting
fields:
  - Economics
  - demand
  - energy
  - finance
alt_names:
  - Box-Jenkins
  - SARIMAX
tags:
  - classical
  - univariate
---
> **Best for:** Classical univariate forecasting
> **Aliases:** Box-Jenkins, SARIMAX

## How it works

$$y_t=c+\sum_{i=1}^{p}\phi_i\,y_{t-i}+\sum_{j=1}^{q}\theta_j\,\varepsilon_{t-j}+\varepsilon_t$$

Models a (possibly differenced) series as a linear combination of its own lags
and past shocks, $y_t=c+\sum_{i=1}^{p}\phi_i y_{t-i}+\sum_{j=1}^{q}\theta_j\varepsilon_{t-j}+\varepsilon_t$,
where $\varepsilon_t$ is white noise. The order $(p,d,q)$ fixes the
autoregressive depth, the differencing needed for stationarity, and the
moving-average window; SARIMA adds seasonal $(P,D,Q)^s$ terms reflecting the
same structure at lag $s$. Coefficients are fit by maximum likelihood, and
orders are chosen by minimising AIC/BIC after checking stationarity and
inspecting the ACF/PACF.


## When to use

Univariate forecasting with strong autocorrelation/seasonality that differencing and AR/MA terms can capture.

## Watch out

Stationarity is required; manual order selection is finicky; poor for multivariate or multi-seasonal data.

## Common fields

Economics · demand · energy · finance
