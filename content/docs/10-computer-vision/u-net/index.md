---
title: U-Net
weight: 50
type: algorithm
rank: 5
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Pixel-level segmentation
description: Pixel-level segmentation
fields:
  - Medical imaging
  - satellite imagery
---
> **Best for:** Pixel-level segmentation

## How it works

$$u^{(l)}=\text{Conv}\bigl(\text{Concat}(u^{(l-1)},\,\text{crop}(e^{(l)}))\bigr)$$

An encoder-decoder for dense segmentation. The contracting (encoder) path
downsamples with convolutions to capture context, caching features $e^{(l)}$
at each scale; the symmetric expanding (decoder) path upsamples and
concatenates the matching encoder features via skip connections,
$u^{(l)}=\text{Conv}\bigl(\text{Concat}(u^{(l-1)},\text{crop}(e^{(l)}))\bigr)$,
restoring spatial detail lost during downsampling. A final $1\times1$
convolution maps each pixel to class logits, giving accurate segmentation
even from modest training sets.


## Common fields

Medical imaging · satellite imagery
