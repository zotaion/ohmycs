---
title: LSTM / GRU
weight: 50
type: algorithm
rank: 5
chapter: /docs/07-time-series-forecasting/
chapter_key: 07-time-series-forecasting
chapter_title: Time-Series Forecasting
icon: forecast
best_for: Sequence-heavy forecasting
description: Sequence-heavy forecasting
fields:
  - Sensors
  - energy
  - finance
---
> **Best for:** Sequence-heavy forecasting

## How it works

$$c_t=f_t\odot c_{t-1}+i_t\odot \tilde{c}_t$$

Uses recurrent cells with gated state updates — an LSTM's memory evolves as
$c_t=f_t\odot c_{t-1}+i_t\odot\tilde{c}_t$, with forget $f_t$, input $i_t$, and
output gates $o_t=\sigma(W[\cdot])$ controlling information flow. The gates let
gradients propagate over long horizons, so the network captures long-range
temporal dependencies that vanilla RNNs cannot. Trained end-to-end on sequence
windows with MSE or quantile loss, LSTMs/GRUs forecast by unrolling the
recurrence and reading a prediction off the hidden state at each step.


## Common fields

Sensors · energy · finance
