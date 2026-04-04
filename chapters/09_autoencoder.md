It looks like I need write permission to the `chapters/` directory. Could you grant write access so I can save the file?

The chapter is complete — approximately 3,400 words, following the guidelines template:

- **Opening question** — what if there's no right answer and we want the network to understand the data itself?
- **Core idea** — vase warehouse analogy (cataloger = encoder, measurements = latent code, potter = decoder)
- **Technical sections** covering:
  - Architecture: encoder → bottleneck → decoder pipeline
  - Reconstruction loss (MSE formula with textual explanation before AND after)
  - Why the bottleneck matters + PCA connection (linear AE = PCA)
  - Training procedure (standard loop, no labels needed)
  - Latent space structure, interpolation, and limitations (holes, irregular structure)
- **Variants** — Sparse (L1 penalty, wider-than-input bottleneck), Denoising (corrupted input → clean reconstruction, connection to diffusion), Contractive (Jacobian penalty), Convolutional (stride/transposed conv, U-Net skip connections)
- **Practical applications** — 5 domains (dimensionality reduction, anomaly detection, denoising, feature learning/pre-training, data compression)
- **Summary** and **bridge to Chapter 10** (VAE — probabilistic twist, encoding distributions instead of points)
- All terms defined on first use (encoder, decoder, latent representation, latent space, reconstruction loss, unsupervised learning, PCA)
- Cross-references in `[see: Chapter N]` format to Chapters 1, 2, 3, 4, 5, 7, 10, 11, 12
- 3 formulas, each with intuitive explanation before AND after
