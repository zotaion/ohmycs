---
title: R-CNN / Faster R-CNN / Mask R-CNN
weight: 40
type: algorithm
rank: 4
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Object detection and segmentation
description: Object detection and segmentation
fields:
  - Medical imaging
  - autonomous driving
---
> **Best for:** Object detection and segmentation

## How it works

$$\text{score}(r)=\text{softmax}\bigl(W\cdot\text{RoIPool}(\phi(x),r)\bigr)$$

Two-stage detectors. A Region Proposal Network (RPN) first proposes candidate
boxes $r$ from shared convolutional features $\phi(x)$; features inside each
box are cropped and resized by RoIPool/RoIAlign and passed to classification
and box-regression heads
$\text{score}(r)=\text{softmax}\bigl(W\cdot\text{RoIPool}(\phi(x),r)\bigr)$.
Mask R-CNN adds a small per-class segmentation head that predicts a pixel
mask for each detected instance. The two-stage design trades speed for
higher accuracy on small or dense objects.


## Common fields

Medical imaging · autonomous driving
