---
title: Prophet-style additive models
weight: 30
type: algorithm
rank: 3
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Business forecasting with seasonality/holidays
description: Business forecasting with seasonality/holidays
fields:
  - Sales
  - marketing
  - web traffic
alt_names:
  - Prophet
  - Generalized Additive Model
tags:
  - forecasting
  - additive
---
> **Best for:** Business forecasting with seasonality/holidays
> **Aliases:** Prophet, Generalized Additive Model

## How it works

$$y(t)=g(t)+s(t)+h(t)+\varepsilon_t$$

Decomposes the series additively as $y(t)=g(t)+s(t)+h(t)+\varepsilon_t$, where
$g(t)$ is a piecewise-linear (or saturating logistic) trend with changepoints,
$s(t)$ models seasonality via a Fourier series, and $h(t)$ adds holiday/event
effects. The components are jointly fit by Bayesian (Stan) or L-BFGS regression,
with the number of Fourier terms and the changepoint prior controlling
flexibility. Forecasts come from extrapolating each fitted component forward,
giving interpretable, uncertainty-aware predictions robust to missing data.


## When to use

Business forecasting with multiple seasonalities, holidays, and regressors where ease and interpretability matter.

## Watch out

Often underperforms gradient boosting; defaults assume additive components; changepoint detection needs tuning.

## Common fields

Sales · marketing · web traffic
