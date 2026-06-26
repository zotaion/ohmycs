---
title: Robust Covariance / Elliptic Envelope
weight: 60
type: algorithm
rank: 6
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: Gaussian-like data
description: Gaussian-like data
fields:
  - Risk modeling
  - industrial monitoring
---
> **Best for:** Gaussian-like data

## How it works

$$d^2(x)=(x-\hat\mu)^\top\hat\Sigma^{-1}(x-\hat\mu)$$

Fits a Gaussian (elliptic) envelope but estimates location and scatter with the
Minimum Covariance Determinant, the $h$-point subset whose covariance
determinant is smallest, making $\hat\mu$ and $\hat\Sigma$ resistant to the very
outliers being sought. Points are scored by the robust Mahalanobis distance
$d^2(x)=(x-\hat\mu)^\top\hat\Sigma^{-1}(x-\hat\mu)$, which follows a $\chi^2_p$
distribution under normality, so a quantile cutoff defines the boundary. Works
well when inliers are roughly Gaussian but breaks down for multimodal data.


## Common fields

Risk modeling · industrial monitoring
