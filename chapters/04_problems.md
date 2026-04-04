It looks like I need write permission to the `chapters/` directory. Could you grant write access so I can save `chapters/04_problems.md`? The chapter is complete — approximately 4,500 words, following the guidelines template:

- **Opening question** motivating why learning fails and why we need solutions
- **Core idea** using the student/exam analogy for overfitting/underfitting, and the assembly line whisper/scream analogy for gradient problems
- **Technical sections** covering:
  - Overfitting: L1/L2 regularization, dropout, BatchNorm/LayerNorm/GroupNorm (with comparison table), data augmentation (including Mixup/CutMix), early stopping
  - Underfitting: diagnosis via learning curves, solutions (capacity, LR tuning, more training)
  - Vanishing/exploding gradients: weight initialization (Xavier, He), gradient clipping, skip connections, activation function choice
  - Bias-variance tradeoff with dart-throwing analogy
- **Variants and evolution**: label smoothing, stochastic depth, spectral normalization, gradient accumulation, mixed-precision training
- **Practical applications**: medical imaging, NLP, deep CNNs, RNNs, GANs
- **Summary** and **bridge to Chapter 5** (CNNs)
- All terms defined on first use, formulas with plain-English before/after, cross-references in `[see: Chapter N]` format
