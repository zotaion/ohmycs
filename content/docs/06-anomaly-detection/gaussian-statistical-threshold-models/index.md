---
title: Gaussian / Statistical Threshold Models
weight: 50
type: algorithm
rank: 5
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: Simple monitoring
description: Simple monitoring
fields:
  - DevOps
  - finance
  - process control
---
> **Best for:** Simple monitoring

## How it works

$$z=\frac{x-\mu}{\sigma}$$

Assumes normal observations follow a fixed distribution, classically a Gaussian
$\mathcal{N}(\mu,\sigma^2)$, and flags deviations exceeding a critical
threshold via the z-score $z=\frac{x-\mu}{\sigma}$ (typically $|z|>3$). The
multivariate generalisation uses the Mahalanobis distance
$d^2=(x-\mu)^\top\Sigma^{-1}(x-\mu)$, which accounts for correlations and
reduces to a $\chi^2$ test under normality. Cheap and interpretable, but fragile
when the data is non-Gaussian or non-stationary.


## Common fields

DevOps · finance · process control
