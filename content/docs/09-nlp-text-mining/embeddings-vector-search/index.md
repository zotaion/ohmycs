---
title: Embeddings + Vector Search
weight: 20
type: algorithm
rank: 2
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Semantic search and retrieval
description: Semantic search and retrieval
fields:
  - RAG
  - document search
  - recommendations
alt_names:
  - Dense Retrieval
  - Bi-Encoder
  - ANN
tags:
  - retrieval
  - embeddings
---
> **Best for:** Semantic search and retrieval
> **Aliases:** Dense Retrieval, Bi-Encoder, ANN

## How it works

$$\text{sim}(q,d)=\frac{e_q^\top e_d}{\|e_q\|\,\|e_d\|}$$

A bi-encoder (e.g. a sentence Transformer) maps each query and document into
a dense vector $e\in\mathbb{R}^d$, and ranking reduces to cosine similarity
$\text{sim}(q,d)=\frac{e_q^\top e_d}{\|e_q\|\|e_d\|}$ (or dot product) over an
approximate-nearest-neighbour index such as HNSW or IVF-PQ. Training uses a
contrastive InfoNCE loss
$-\log\frac{\exp(e_q^\top e_d^+/\tau)}{\sum_d\exp(e_q^\top e_d/\tau)}$ so that
related text lands nearby in the embedding space. A cross-encoder re-ranker
then refines the top-$k$ candidates for higher precision.


## When to use

Semantic search, RAG, deduplication, and recommendation over large document or item catalogs.

## Watch out

Embedding model choice dominates quality; re-ranking matters; index tuning (HNSW/IVF) drives latency.

## Common fields

RAG · document search · recommendations
