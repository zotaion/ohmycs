---
title: TF-IDF + Linear Models
weight: 30
type: algorithm
rank: 3
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Fast classical NLP baseline
description: Fast classical NLP baseline
fields:
  - Spam
  - legal search
  - support-ticket routing
alt_names:
  - Bag-of-Words SVM
  - TF-IDF Logistic
tags:
  - classical
  - interpretable
---
> **Best for:** Fast classical NLP baseline
> **Aliases:** Bag-of-Words SVM, TF-IDF Logistic

## How it works

$$\text{tfidf}(t,d)=\text{tf}(t,d)\cdot\log\frac{N}{\text{df}(t)}$$

Represents each document as a sparse bag-of-words vector weighted by TF-IDF,
$\text{tfidf}(t,d)=\text{tf}(t,d)\cdot\log\frac{N}{\text{df}(t)}$, which
up-weights terms frequent in a document but rare across the corpus of size
$N$. A linear classifier — Logistic Regression $\sigma(\beta^\top x)$ or a
linear SVM — is then trained on these vectors, giving $O(d)$ prediction and
interpretable per-term coefficients. Despite ignoring word order it remains a
strong, cheap, explainable baseline for text classification.


## When to use

Cheap, fast, explainable text classification when data or compute is limited.

## Watch out

Ignores word order and context; loses to transformers on semantic tasks; OOV handling matters.

## Common fields

Spam · legal search · support-ticket routing
