---
title: YOLO-style Detectors
weight: 30
type: algorithm
rank: 3
chapter: /docs/10-computer-vision/
chapter_key: 10-computer-vision
chapter_title: Computer Vision
icon: vision
best_for: Real-time object detection
description: Real-time object detection
fields:
  - Surveillance
  - robotics
  - retail
  - autonomous systems
alt_names:
  - YOLO
  - You Only Look Once
  - Single-Stage Detector
tags:
  - vision
  - detection
  - realtime
---
> **Best for:** Real-time object detection
> **Aliases:** YOLO, You Only Look Once, Single-Stage Detector

## How it works

$$\text{conf}=P(\text{obj})\cdot\text{IoU}(\text{pred},\text{gt})$$

A single fully-convolutional network divides the image into an $S\times S$
grid; each grid cell directly regresses $B$ bounding boxes with coordinates
$(x,y,w,h)$, an objectness score $\text{conf}=P(\text{obj})\cdot\text{IoU}$,
and class probabilities, all in one forward pass with no region-proposal
stage. Training minimises a multi-part loss over localization, confidence,
and classification, and non-max suppression removes duplicate boxes at
inference. The single-shot design is what enables real-time detection.


## When to use

Real-time object detection on edge or streaming devices where the speed-accuracy tradeoff matters.

## Watch out

Lower accuracy than two-stage detectors on small or dense objects; needs careful anchor and NMS tuning.

## Common fields

Surveillance · robotics · retail · autonomous systems
