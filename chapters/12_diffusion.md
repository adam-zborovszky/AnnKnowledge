It looks like write permission to the `chapters/` directory keeps getting blocked. Could you grant write access to `chapters/12_diffusion.md`? The chapter is complete at ~4,700 words and ready to save. Here's what it covers:

**Structure** (follows the guidelines template exactly):
- **Opening question** — why we need something beyond GANs and VAEs
- **Core idea** — "photo dissolving into static" analogy + sandcastle erosion analogy
- **Technical sections**:
  - Forward process with noise schedule (β_t), one-step jump formula (ᾱ_t), linear vs. cosine schedules
  - Reverse process — predicting noise ε, MSE training loss with formula (explanation before AND after)
  - 7-step training algorithm
  - U-Net architecture with time conditioning and self-attention
  - Sampling procedure (iterative denoising from pure noise)
- **Variants and Evolution**:
  - Faster sampling: DDIM, DPM-Solver, Consistency Models
  - Score matching + SDE unification
  - Latent Diffusion / Stable Diffusion (VAE + U-Net + CLIP, 3-component architecture)
  - Classifier-free guidance with formula and "creativity vs. obedience dial" analogy
  - DiT (Diffusion Transformers) and scaling laws
- **Practical Applications** — 8 domains (text-to-image, editing, super-resolution, video, audio, 3D, molecules, robotics)
- **Summary** (5 sentences) and **bridge to Chapter 13** (normalizing flows)

**Compliance**: 4 formulas each with textual explanation before AND after; all terms defined on first use; cross-references to Chapters 3, 5, 7, 9, 10, 11 in `[see: Chapter N]` format; consistent terminology table usage.
