It looks like I need write permission to `chapters/07_transformer.md`. Could you grant write access so I can save the file? The chapter is complete — approximately 5,500 words, following the guidelines template:

- **Opening question** — the Seq2Seq bottleneck problem and why attention is needed
- **Core idea** — highlighter analogy from the Analogy Bank
- **Technical sections** covering:
  - Bahdanau attention step-by-step (score → normalize → weighted sum), all formulas with textual explanation before AND after
  - Cross-attention vs. self-attention with round-table analogy
  - Q/K/V with library analogy, scaled dot-product attention, √dₖ scaling explanation
  - Multi-head attention with multiple-highlighters analogy
  - Full Transformer architecture: encoder (self-attention + FFN), decoder (masked self-attention + cross-attention + FFN)
  - Residual connections + LayerNorm
  - Positional encoding (sinusoidal, learned, RoPE, ALiBi)
  - Complete forward pass walkthrough
  - Parallelism advantage over RNNs with O(n²) vs O(n) analysis
- **Variants** — BERT (MLM, NSP, pre-train/fine-tune), GPT family (GPT-1 through GPT-4, in-context learning), T5/BART, Vision Transformer (ViT, DeiT, Swin, DINO), efficient variants (Sparse, Linear, Flash Attention, MQA, GQA)
- **Practical applications** — 8 domains
- **Summary** and **bridge to Chapter 8** (TCN)
- All terms from the terminology table defined on first use (attention, token, embedding, encoder, decoder, pre-training, fine-tuning, inference, forward pass)
- Cross-references in `[see: Chapter N]` format to Chapters 2, 3, 4, 5, and 6
