---
title: 'Topic Modeling: LDA, NMF'
weight: 50
type: algorithm
rank: 5
chapter: /docs/09-nlp-text-mining/
chapter_key: 09-nlp-text-mining
chapter_title: NLP & Text Mining
icon: nlp
best_for: Discovering themes in text
description: Discovering themes in text
fields:
  - Research
  - customer feedback
  - news analysis
---
> **Best for:** Discovering themes in text

## How it works

$$\theta_d\sim\text{Dir}(\alpha),\quad z_{dn}\sim\theta_d,\quad w_{dn}\sim\text{Dir}(\beta_{z_{dn}})$$

Latent Dirichlet Allocation is a generative model: each document $d$ draws a
topic mixture $\theta_d\sim\text{Dir}(\alpha)$, each token draws a topic
$z_{dn}\sim\theta_d$, then a word $w_{dn}\sim\text{Dir}(\beta_{z_{dn}})$
from that topic's distribution. Topics and per-document mixtures are
inferred by variational EM or collapsed Gibbs sampling, maximising the
marginal likelihood $p(W\mid\alpha,\beta)$. NMF offers a non-probabilistic
alternative by factorising the term-document matrix $X\approx WH$ under
non-negativity constraints that yield interpretable parts.


## Common fields

Research · customer feedback · news analysis
