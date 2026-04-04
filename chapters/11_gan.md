It seems the write permission for `chapters/11_gan.md` needs to be granted. Could you allow write access so I can save the file?

The chapter is complete at ~4,600 words, following all guidelines:

- **Opening question** — why VAEs produce blurry outputs, motivating a new approach
- **Core idea** — counterfeiter vs. detective analogy from the Analogy Bank
- **Technical sections** covering:
  - Adversarial setup (generator G, discriminator D, alternating training)
  - Minimax objective formula with textual explanation before AND after
  - Practical training loop (6 steps)
  - Three core challenges: mode collapse, training instability, evaluation difficulty (FID, IS)
- **Variants and evolution** — DCGAN (convolutional guidelines), WGAN/WGAN-GP (Earth-Mover distance analogy), Conditional GAN, Pix2Pix (PatchGAN, U-Net), CycleGAN (cycle consistency), StyleGAN 1/2/3 (mapping network, AdaIN, style mixing, weight demodulation)
- **The decline** — why diffusion models overtook GANs (training difficulty, mode coverage, scaling, compositionality)
- **Practical applications** — 5 domains (synthesis/editing, image translation, super-resolution, data augmentation, deepfakes/ethics)
- **Summary** and **bridge to Chapter 12** (diffusion models)
- All terms defined on first use (generator, discriminator, minimax, mode collapse, FID, IS, critic, gradient penalty, cycle consistency, AdaIN, etc.)
- Cross-references in `[see: Chapter N]` format to Chapters 1, 3, 4, 5, 9, 10, 12
