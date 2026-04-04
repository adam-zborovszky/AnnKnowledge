It looks like I need write permission to `chapters/08_tcn.md`. Could you grant write access so I can save the file? The chapter is complete — approximately 2,500 words, following the guidelines template:

- **Opening question** — why use convolutions on sequences when we already have RNNs and Transformers?
- **Core idea** — hallway/magnifying glass analogy leading to the binoculars analogy for dilated convolutions
- **Technical sections** covering:
  - Causal convolution: what it is, left-padding implementation, receptive field limitation
  - Dilated convolutions: dilation factor, receptive field formulas (with textual explanation before AND after), exponential growth derivation, concrete 16-step numerical example, WaveNet connection
  - Full TCN architecture: residual blocks, weight normalization, ReLU, spatial dropout, 1×1 convolution for channel matching
  - TCN vs RNN/LSTM comparison table (7 properties)
  - When-to-choose decision guide (TCN vs RNN vs Transformer)
- **Variants** — Multi-Scale TCN, WaveNet, Temporal Fusion Transformer, State Space Models (S4, Mamba)
- **Practical applications** — 5 domains (time-series, audio, video, medical, NLP)
- **Summary** and **bridge to Part III** (generative models)
- All terms defined on first use, cross-references in `[see: Chapter N]` format to Chapters 1, 3, 4, 5, 6, and 7
