---
title: CNNs
weight: 10
type: algorithm
rank: 1
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Image classification and feature extraction
description: Image classification and feature extraction
fields:
  - Medical imaging
  - manufacturing
  - retail
alt_names:
  - ConvNet
  - ResNet
  - EfficientNet
tags:
  - vision
  - spatial
---
> **Best for:** Image classification and feature extraction
> **Aliases:** ConvNet, ResNet, EfficientNet

## How it works

$$y(i,j)=\sum_{m,n}w(m,n)\,x(i-m,j-n)+b$$

A conv layer slides learnable kernels across the input computing the
cross-correlation $y(i,j)=\sum_{m,n}w(m,n)\,x(i-m,j-n)+b$ followed by a
nonlinearity (ReLU). Stacking convolutions with pooling (e.g. max over local
windows) shrinks spatial size and builds a hierarchy from edges up to object
parts, while translation-invariant weight sharing keeps parameter counts low.
Very deep variants (ResNet, EfficientNet) add skip connections
$h^{(l+1)}=\mathcal F(h^{(l)})+h^{(l)}$ so gradients flow through, letting
hundreds of layers train. A final fully-connected head maps pooled features
to class logits trained with cross-entropy.


## When to use

Image classification and feature extraction where inductive biases of locality and translation invariance help.

## Watch out

Need strong augmentation; data-hungry at scale; ViTs outperform on very large datasets.

## Common fields

Medical imaging · manufacturing · retail
