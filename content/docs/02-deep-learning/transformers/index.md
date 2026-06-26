---
title: Transformers
weight: 10
type: algorithm
rank: 1
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Language, vision-language, sequence modeling
description: Language, vision-language, sequence modeling
fields:
  - NLP
  - LLMs
  - search
  - chatbots
  - code
  - document AI
alt_names:
  - Self-Attention
  - BERT
  - GPT
  - ViT
tags:
  - attention
  - nlp
  - foundational
---
> **Best for:** Language, vision-language, sequence modeling
> **Aliases:** Self-Attention, BERT, GPT, ViT

## How it works

$$\text{Attention}(Q,K,V)=\text{softmax}\!\left(\frac{QK^\top}{\sqrt{d_k}}\right)V$$

Tokens are embedded and mixed by self-attention, where queries $Q$, keys $K$
and values $V$ produce
$\text{Attention}(Q,K,V)=\text{softmax}(QK^\top/\sqrt{d_k})V$, with the
$\sqrt{d_k}$ factor keeping dot-product variances stable under the softmax.
Multi-head attention runs $h$ such operations in parallel and concatenates
them, letting the model attend to different relations at once. A Transformer
stacks these attention blocks with residual connections, layer-norm and
position-wise feed-forward layers, trained by next-token (decoder) or
masked-token (encoder) cross-entropy.


## When to use

Sequence, language, and multimodal learning where long-range context and representation quality matter most.

## Watch out

Data- and compute-hungry; attention cost grows quadratically with sequence length; generative variants hallucinate.

## Common fields

NLP · LLMs · search · chatbots · code · document AI
