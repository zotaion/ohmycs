---
title: Transformer Models / LLMs
weight: 10
type: algorithm
rank: 1
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Most modern NLP tasks
description: Most modern NLP tasks
fields:
  - Chatbots
  - search
  - summarization
  - translation
  - coding
alt_names:
  - LLM
  - BERT
  - GPT
  - T5
tags:
  - nlp
  - foundational
  - generative
---
> **Best for:** Most modern NLP tasks
> **Aliases:** LLM, BERT, GPT, T5

## How it works

$$\text{Attention}(Q,K,V)=\text{softmax}\!\left(\frac{QK^\top}{\sqrt{d_k}}\right)V$$

A Transformer encodes tokens into vectors and mixes them with self-attention,
$\text{softmax}(QK^\top/\sqrt{d_k})V$, where $Q=XW_Q$, $K=XW_K$, $V=XW_V$ are
linear projections and $\sqrt{d_k}$ rescales the dot products to keep
gradients well-conditioned. Multi-head attention runs many such attentions in
parallel and concatenates them, while positional encodings inject sequence
order. Stacked with residual connections and layer norm, this backbone
underlies BERT (encoder, masked-language modelling) and GPT/T5 (decoder or
encoder-decoder, autoregressive generation).


## When to use

Most modern NLP tasks — classification, generation, retrieval, translation — where quality justifies compute.

## Watch out

Hallucination in generative use; serving cost and latency; data leakage and bias concerns; needs careful evaluation.

## Common fields

Chatbots · search · summarization · translation · coding
