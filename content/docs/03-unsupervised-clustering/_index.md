+++
title = "Unsupervised Learning: Clustering"
weight = 3
chapter_key = "03-unsupervised-clustering"
description = "Group unlabeled data by structure and similarity to discover segments."
icon = "cluster"
category = "Unsupervised"
defaults = ["Start with k-Means for fast general clustering.", "Use HDBSCAN when clusters have arbitrary shapes or you need noise detection."]

[[notes]]
text = "scikit-learn's clustering documentation includes common clustering algorithms such as k-Means and related methods, with k-Means framed around minimizing within-cluster variance."
+++

Clustering finds natural groups in data without labels, revealing segments, communities, and structure. The methods below range from fast centroid-based partitioning to density-based and hierarchical approaches that handle arbitrary shapes.
