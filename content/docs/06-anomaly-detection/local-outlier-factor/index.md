---
title: Local Outlier Factor
weight: 30
type: algorithm
rank: 3
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: Density-based outliers
description: Density-based outliers
fields:
  - Sensor data
  - geospatial data
  - fraud
alt_names:
  - LOF
tags:
  - anomaly
  - density
---
> **Best for:** Density-based outliers
> **Aliases:** LOF

## How it works

$$\text{LOF}_k(x)=\frac{1}{|N_k(x)|}\sum_{o\in N_k(x)}\frac{\text{lrd}(o)}{\text{lrd}(x)}$$

Compares the local density of a point to that of its $k$ neighbours via the
ratio $\text{LOF}_k(x)=\frac{1}{|N_k(x)|}\sum_{o\in N_k(x)}\frac{\text{lrd}(o)}{\text{lrd}(x)}$.
The local reachability density $\text{lrd}(x)$ is the inverse of the average
reachability distance $\text{reach-dist}_k(o,x)=\max(d_k(o),\|o-x\|)$ over the
neighbourhood, which uses the $k$-distance to dampen spikes. Points in sparse
regions have $\text{LOF}\gg 1$ and are outliers, while inliers sit at
$\text{LOF}\approx 1$.


## When to use

Local density-based outlier detection where anomalies are relative to their neighborhood.

## Watch out

Struggles with varying densities; n_neighbors tuning matters; default threshold can be unreliable.

## Common fields

Sensor data · geospatial data · fraud
