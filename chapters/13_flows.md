It looks like write permission to the `chapters/` directory is being blocked. Could you grant write access so I can save the file?

The chapter is complete at ~3,500 words, following all guidelines:

- **Opening question** — why we need exact likelihoods (VAEs approximate, GANs ignore, diffusion is slow)
- **Core idea** — clay-sculpting analogy from the Analogy Bank, plus rubber sheet analogy for the Jacobian
- **Technical sections**:
  - Change of variables formula with intuition before AND after
  - Chaining transformations (composition + log-determinant sum)
  - Computational challenge (O(d³) → triangular trick → O(d))
  - Coupling layers (split-and-transform design, why the side network m doesn't need invertibility)
- **Variants and Evolution**:
  - NICE (additive coupling, det=1)
  - RealNVP (affine coupling, scale + shift)
  - Glow (1×1 conv, actnorm, squeeze, 256×256 faces)
  - Autoregressive flows (MAF/IAF, generation vs. density trade-off)
  - Continuous flows / Neural ODEs (velocity field, ODE integration)
  - Flow Matching (velocity regression, straight-line paths, rectified flows, SD3/Flux connection)
- **Practical Applications** — 5 domains (anomaly detection, image generation, audio, scientific simulation, variational inference)
- **Summary** (4 sentences) and **bridge to next chapter**

**Compliance**: 5 formulas each with textual explanation before AND after; all terms defined on first use (base distribution, Jacobian, Jacobian determinant, coupling layer, affine coupling, velocity field, ODE, etc.); cross-references to Chapters 4, 5, 10, 11, 12 in `[see: Chapter N]` format; consistent terminology table usage.
