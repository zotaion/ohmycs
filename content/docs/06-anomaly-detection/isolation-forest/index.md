---
title: Isolation Forest
weight: 10
type: algorithm
rank: 1
chapter: /docs/06-anomaly-detection/
chapter_key: 06-anomaly-detection
chapter_title: Anomaly Detection
icon: anomaly
best_for: General anomaly detection
description: General anomaly detection
fields:
  - Fraud
  - cybersecurity
  - operations
  - IoT
alt_names:
  - iForest
tags:
  - anomaly
  - ensemble
  - unsupervised
---
> **Best for:** General anomaly detection
> **Aliases:** iForest

## How it works

$$s(x,n)=2^{-\,E[h(x)]\,/\,c(n)}$$

Builds an ensemble of random isolation trees, each splitting on a randomly
chosen feature at a random threshold until points are isolated. Anomalies,
being sparse and different, require fewer random partitions to separate and
thus have shorter path lengths $h(x)$. The anomaly score
$s(x,n)=2^{-E[h(x)]/c(n)}$ normalises the mean path length by the average
unsuccessful binary-search length $c(n)=2H(n-1)-2(n-1)/n$, so $s\to 1$ flags
clear anomalies and $s\approx 0.5$ is normal.


## When to use

General-purpose unsupervised anomaly detection across mixed tabular features at scale.

## Watch out

Contamination parameter drives the threshold; less reliable on low-dimensional or categorical-heavy data.

## Common fields

Fraud · cybersecurity · operations · IoT
