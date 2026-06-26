---
title: Mean Shift
weight: 60
type: algorithm
rank: 6
chapter: /docs/03-unsupervised-clustering/
chapter_key: 03-unsupervised-clustering
chapter_title: 'Unsupervised Learning: Clustering'
icon: cluster
best_for: Mode/peak discovery
description: Mode/peak discovery
fields:
  - Computer vision
  - spatial clustering
---
> **Best for:** Mode/peak discovery

## How it works

$$\mu^{(t+1)}=\frac{\sum_i x_i\,g\!\left(\left\|\frac{x_i-\mu^{(t)}}{h}\right\|^2\right)}{\sum_i g\!\left(\left\|\frac{x_i-\mu^{(t)}}{h}\right\|^2\right)}$$

A non-parametric, mode-seeking procedure that slides each point uphill on a
kernel-density estimate toward the nearest local maximum (mode) of the
density. Each iteration moves a point to the kernel-weighted mean of its
neighbours,
$\mu^{(t+1)}=\frac{\sum_i x_i\,g(\|(x_i-\mu^{(t)})/h\|^2)}{\sum_i g(\|(x_i-\mu^{(t)})/h\|^2)}$,
where $g=-K'$ is the profile of a kernel $K$ (typically Gaussian) of bandwidth
$h$. Points converging to the same mode form a cluster, so the number of
clusters is determined automatically by the density modes of the data.


## Common fields

Computer vision · spatial clustering
