---
title: Autoencoders
weight: 40
type: algorithm
rank: 4
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: Complex high-dimensional anomalies
description: Complex high-dimensional anomalies
fields:
  - Images
  - network traffic
  - medical scans
---
> **Best for:** Complex high-dimensional anomalies

## How it works

$$\mathcal{R}(x)=\|x-\hat{x}\|^2=\|x-D(E(x))\|^2$$

Trains an encoder $E$ to compress each input into a low-dimensional code and a
decoder $D$ to reconstruct it, $\hat{x}=D(E(x))$, so the model learns the
manifold of normal data. At inference the reconstruction error
$\mathcal{R}(x)=\|x-\hat{x}\|^2$ is large for inputs unlike anything seen in
training, because the bottleneck cannot reproduce them faithfully. A threshold
$\tau$ on $\mathcal{R}$, often a high quantile of validation errors, separates
anomalous from normal observations.


## Common fields

Images · network traffic · medical scans
