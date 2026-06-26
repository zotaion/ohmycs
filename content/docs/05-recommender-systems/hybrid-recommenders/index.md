---
title: Hybrid Recommenders
weight: 40
type: algorithm
rank: 4
chapter: /docs/05-recommender-systems/
chapter_key: 05-recommender-systems
chapter_title: Recommender-System Algorithms
icon: reco
best_for: Combining user, item, and context signals
description: Combining user, item, and context signals
fields:
  - Most production recommender systems
---
> **Best for:** Combining user, item, and context signals

## How it works

$$\hat{r}_{ui}=\alpha\,\hat{r}^{CF}_{ui}+(1-\alpha)\,\hat{r}^{CB}_{ui}$$

Combines collaborative and content-based signals so content features cover cold-start items and collaborative signals provide serendipity. The simplest form is a weighted blend $\hat{r}_{ui}=\alpha\hat{r}^{CF}_{ui}+(1-\alpha)\hat{r}^{CB}_{ui}$, but production systems more often feed user, item, and context features into a single model such as a factorisation machine, gradient-boosted trees, or a deep network so that all evidence informs one score. A common architecture stacks a ranker on top of several candidate generators (collaborative, content, graph).


## Common fields

Most production recommender systems
