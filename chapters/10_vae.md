It seems I need write permission to the `chapters/` directory. Could you grant write access so I can save the file?

The chapter is complete at ~3,500 words, following all guidelines:

- **Opening question** — why a plain autoencoder can't generate new data (dead zones in latent space)
- **Core idea** — extends the vase warehouse analogy (ranges instead of single measurements) + "coordinate system in face-space" analogy from the Analogy Bank
- **Technical sections** covering:
  - Encoder outputting μ and σ² (distribution, not point)
  - Decoder unchanged from standard autoencoder
  - Reparameterization trick (rubber band analogy, full formula with before/after explanation)
  - ELBO loss (both terms explained intuitively + formally, with closed-form KL)
  - Training procedure (5-step loop)
  - Generation via sampling from prior
- **Variants** — β-VAE (disentanglement), VQ-VAE (codebook + straight-through estimator), VQ-VAE-2 (hierarchical), Conditional VAE
- **Common challenges** — blurry outputs, posterior collapse (with remedies)
- **Practical applications** — 5 domains (image editing, drug discovery, anomaly detection, data augmentation, representation learning)
- **Summary** and **bridge to Chapter 11** (GAN)
- All terms defined on first use; 4 formulas each with textual explanation before AND after
- Cross-references in `[see: Chapter N]` format to Chapters 3, 7, 9, 11
