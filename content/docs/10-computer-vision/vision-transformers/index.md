---
title: Vision Transformers
weight: 20
type: algorithm
rank: 2
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Modern image classification and multimodal models
description: Modern image classification and multimodal models
fields:
  - Research
  - large-scale vision
  - document AI
alt_names:
  - ViT
  - Swin
  - CLIP
tags:
  - vision
  - attention
---
> **Best for:** Modern image classification and multimodal models
> **Aliases:** ViT, Swin, CLIP

## How it works

$$\text{softmax}(QK^\top/\sqrt{d_k})\,V$$

Splits the image into fixed patches, linearly embeds each patch, prepends a
[CLS] token, and adds positional embeddings. Patches then flow through a
transformer encoder where scaled dot-product self-attention
$\text{softmax}(QK^\top/\sqrt{d_k})\,V$ lets every patch attend to every other
patch, mixing global information per layer. The [CLS] output is classified;
CLIP trains the same backbone contrastively against text. Lacking locality
bias, ViTs need large-scale pretraining to outperform CNNs.


## When to use

Large-scale image classification and multimodal vision-language tasks with abundant data and compute.

## Watch out

Weak inductive bias — underperforms CNNs without large pretraining; patch size and data hunger are key.

## Common fields

Research · large-scale vision · document AI
