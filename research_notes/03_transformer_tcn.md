It seems the write permission hasn't been granted yet. Could you allow write access to `research_notes/03_transformer_tcn.md`? The content is fully prepared — comprehensive research notes covering:

**Chapter 7 (Transformer):**
- Seq2Seq bottleneck problem and why attention is needed
- Bahdanau attention step-by-step with highlighter analogy, all 4 scoring functions
- Self-attention vs. cross-attention with round-table analogy
- Q/K/V explained with library analogy, scaling factor √dₖ derivation, computational complexity O(n²)
- Multi-head attention: why multiple heads, how it works, typical values
- Full Transformer architecture: encoder stack (self-attention + FFN), decoder stack (masked self-attention + cross-attention + FFN), causal mask mechanics
- Positional encoding: sinusoidal, learned, relative (RoPE, ALiBi) with comparison table
- Residual connections + LayerNorm, Pre-Norm vs. Post-Norm
- Complete forward pass walkthrough, training details from original paper
- Variants: BERT (MLM, NSP, fine-tuning, successors), GPT family (GPT-1 through GPT-4, in-context learning), T5/BART encoder-decoder models with comparison table
- Vision Transformer (ViT): patches-as-tokens, ViT vs CNN comparison, DeiT/Swin/MAE/DINO variants
- Efficient Transformer variants: Sparse Attention, Linformer, Flash Attention, MQA, GQA
- 10 application domains

**Chapter 8 (TCN):**
- Motivation for using convolutions on sequences
- Causal convolution: what, why, implementation, receptive field problem
- Dilated convolutions with telescope/binoculars analogy, exponential receptive field growth, concrete numerical example, WaveNet insight
- Full TCN architecture: residual blocks, weight normalization, spatial dropout
- TCN vs RNN/LSTM detailed comparison table + when-to-use decision guide
- Bai et al. (2018) benchmark results
- Applications and extensions (Multi-Scale TCN, TFT, connection to SSMs)
- Bridge to Part III (generative models)
