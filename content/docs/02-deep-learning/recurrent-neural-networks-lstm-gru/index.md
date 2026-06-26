---
title: Recurrent Neural Networks / LSTM / GRU
weight: 30
type: algorithm
rank: 3
chapter: /docs/02-deep-learning/
chapter_key: 02-deep-learning
chapter_title: Deep Learning
icon: deep
best_for: Sequential data, older NLP/time-series systems
description: Sequential data, older NLP/time-series systems
fields:
  - Speech
  - time series
  - sensor data
  - finance
alt_names:
  - LSTM
  - GRU
  - Seq2Seq
tags:
  - sequence
  - legacy
---
> **Best for:** Sequential data, older NLP/time-series systems
> **Aliases:** LSTM, GRU, Seq2Seq

## How it works

$$h_t=\tanh(W_h h_{t-1}+W_x x_t+b)$$

A vanilla RNN folds the sequence into a hidden state updated at each step,
$h_t=\tanh(W_h h_{t-1}+W_x x_t+b)$, so $h_t$ summarises all past inputs and is
read out by a decoder. This recurrence suffers from vanishing/exploding
gradients on long sequences, which LSTMs and GRUs fix with learned gates: an
LSTM keeps a cell state $c_t=f_t\odot c_{t-1}+i_t\odot \tilde c_t$ with
$\tilde c_t=\tanh(W_c h_{t-1}+U_c x_t+b_c)$ and forget/input/output gates
$f_t,i_t,o_t\in(0,1)$, so gradients flow through the additive cell path. All
variants train by backpropagation-through-time.


## When to use

Low-latency sequential modeling where memory/state is needed and a Transformer isn't justified.

## Watch out

Vanishing/exploding gradients on long sequences; sequential computation limits parallelism; largely superseded by Transformers.

## Common fields

Speech · time series · sensor data · finance
