---
title: 'Classical CV + ML: SIFT, HOG, SVM'
weight: 70
type: algorithm
rank: 7
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Smaller/legacy vision systems
description: Smaller/legacy vision systems
fields:
  - Industrial inspection
  - embedded systems
---
> **Best for:** Smaller/legacy vision systems

## How it works

$$f=\text{hist}\bigl(\nabla x\bigr)$$

Hand-crafted descriptors encode local appearance before deep features existed.
HOG computes image gradients and accumulates their orientations into
histograms over spatial cells; SIFT locates scale-space extrema and builds
orientation histograms around keypoints, giving a gradient-based descriptor
$f=\text{hist}(\nabla x)$. These features feed a classical classifier such as
an SVM ($\min\tfrac12\|w\|^2$ s.t. $y_i(w^\top\phi(x_i)+b)\ge 1$). Effective
for small or legacy vision systems where data or compute is limited.


## Common fields

Industrial inspection · embedded systems
