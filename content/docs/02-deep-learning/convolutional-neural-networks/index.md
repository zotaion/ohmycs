---
title: Convolutional Neural Networks
weight: 20
type: algorithm
rank: 2
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Images, spatial data
description: Images, spatial data
fields:
  - Computer vision
  - medical imaging
  - defect detection
  - satellite imagery
alt_names:
  - CNN
  - ConvNet
  - ResNet
tags:
  - vision
  - spatial
---
> **Best for:** Images, spatial data
> **Aliases:** CNN, ConvNet, ResNet

## How it works

$$Y(i,j)=b+\sum_m\sum_n W(m,n)\,X(i-m,j-n)$$

Each convolutional layer computes a stack of feature maps via local filters,
$Y(i,j)=b+\sum_m\sum_n W(m,n)\,X(i-m,j-n)$ (cross-correlation), sharing weights
across spatial positions to gain translation equivariance. Stacking
convolutions with nonlinearities (ReLU) and pooling builds a hierarchy from
edges to object parts, with a large receptive field at low parameter cost.
Modern variants like ResNet add skip connections $y=F(x)+x$ to ease gradient
flow in very deep stacks, and the whole network trains end-to-end by
backpropagation on the task loss.


## When to use

Spatial data with local, translation-invariant patterns — classic image classification, detection, and feature extraction.

## Watch out

Lose global context vs. transformers on long ranges; need strong augmentation; large models overfit small datasets.

## Common fields

Computer vision · medical imaging · defect detection · satellite imagery
