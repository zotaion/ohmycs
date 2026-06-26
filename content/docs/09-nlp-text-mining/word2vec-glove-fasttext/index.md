---
title: Word2Vec / GloVe / FastText
weight: 70
type: algorithm
rank: 7
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Static word embeddings
description: Static word embeddings
fields:
  - Legacy NLP
  - semantic similarity
---
> **Best for:** Static word embeddings

## How it works

$$\max_\theta\ \sum_{w_c,w_o}\log\frac{\exp(v_{w_o}^{\prime\top}v_{w_c})}{\sum_w\exp(v_w^{\prime\top}v_{w_c})}$$

Word2Vec's skip-gram learns embeddings by maximising, for each centre word
$w_c$ and context word $w_o$, the log-softmax
$\log\frac{\exp(v_{w_o}^{\prime\top}v_{w_c})}{\sum_w\exp(v_w^{\prime\top}v_{w_c})}$
over the vocabulary, in practice sped up by negative sampling. CBOW inverts
centre and context roles, while GloVe fits ratios of co-occurrence counts
via $\min\sum_{i,j}f(X_{ij})(v_i^\top v_j+b_i+\tilde b_j-\log X_{ij})^2$.
FastText enriches each vector with subword $n$-grams so it can represent
morphology and out-of-vocabulary terms.


## Common fields

Legacy NLP · semantic similarity
