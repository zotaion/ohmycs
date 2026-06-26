---
title: CRF / HMM
weight: 60
type: algorithm
rank: 6
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Sequence labeling, older NLP
description: Sequence labeling, older NLP
fields:
  - Named entity recognition
  - POS tagging
---
> **Best for:** Sequence labeling, older NLP

## How it works

$$p(y\mid x)\propto\exp\!\left(\sum_t w^\top f(y_{t-1},y_t,x,t)\right)$$

Hidden Markov Models treat tagging as a Markov chain over latent labels with
parameters $\lambda=(A,B,\pi)$ — transition matrix $A$, emission $B$, and
initial distribution $\pi$. The Viterbi algorithm returns the most likely
tag sequence $\arg\max_y P(y,x\mid\lambda)$, while the forward algorithm
computes $P(x\mid\lambda)$ for scoring. Conditional Random Fields replace
this joint model with a discriminative one,
$p(y\mid x)\propto\exp\sum_t w^\top f(y_{t-1},y_t,x,t)$, relaxing the HMM's
independence assumptions and allowing arbitrary overlapping input features.


## Common fields

Named entity recognition · POS tagging
