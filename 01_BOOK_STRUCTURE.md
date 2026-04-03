# Deep Learning Book — Complete Structure & Taxonomy

## Title: "Deep Learning — The Logic of Learning Deeply"
### Subtitle: "From Fundamentals to Modern Architectures, Made Clear"

---

## PART I: FOUNDATIONS — "Why Does Any of This Work?"

### Chapter 1: The Neuron — The Smallest Thinking Unit
- What is an artificial neuron (perceptron)?
- Weights, bias, activation — anatomy of a decision
- Activation functions: sigmoid, tanh, ReLU and variants (Leaky ReLU, GELU, Swish)
- Why nonlinearity? (limitations of linear models)

### Chapter 2: Networks — When Neurons Cooperate
- Feedforward network (MLP) architecture
- Role of layers: input, hidden, output
- Universal approximation theorem — why can it learn "anything"?
- The "deep" question: why are many layers better than wide ones?

### Chapter 3: How Does a Network Learn?
- Loss functions: MSE, cross-entropy, and friends
- Backpropagation — flowing gradients backward (chain rule)
- Gradient descent (SGD) and variants: Momentum, RMSProp, Adam, AdamW
- Learning rate — speed and scheduling (schedulers)
- Mini-batch vs. batch vs. stochastic

### Chapter 4: Problems of Learning and Their Solutions
- Overfitting vs. underfitting — when does it learn "too well"?
- Regularization:
  - L1, L2 (weight decay)
  - Dropout — randomly disabling neurons
  - Batch normalization — normalizing layers
  - Layer normalization, Group normalization
  - Data augmentation
  - Early stopping
- Vanishing/exploding gradient problem
- Skip connections (the ResNet idea — preview)
- Initialization: Xavier, He, Kaiming

---

## PART II: ARCHITECTURES — "Which Network for Which Task?"

### Chapter 5: CNN — Convolutional Neural Networks (Spatial Patterns)
- Intuitive explanation of convolution (filters, feature maps)
- Pooling layers (max, average)
- Padding, stride — controlling dimensions
- Evolution of classic architectures:
  - LeNet → AlexNet → VGG → GoogLeNet/Inception → ResNet → DenseNet
  - EfficientNet, MobileNet (efficiency)
- Deconvolution and U-Net (segmentation)
- Use cases: image recognition, object detection, segmentation

### Chapter 6: RNN — Recurrent Neural Networks (Sequential Patterns)
- Why doesn't MLP work for text/time series?
- The RNN core idea: memory through feedback
- Vanishing gradient and the long-term dependency problem
- LSTM — Long Short-Term Memory:
  - Forget gate, input gate, output gate
  - The memory cell as a "conveyor belt"
- GRU — Gated Recurrent Unit (simplified LSTM)
- Bidirectional RNN — reading from both directions
- Seq2Seq and the encoder-decoder concept
- Use cases: text, speech, time series, music

### Chapter 7: Attention & Transformer — "Pay Attention to What Matters!"
- Origin of the attention mechanism (Bahdanau)
- Self-attention — why does every word attend to every other?
- Query, Key, Value — the math of attention (intuitively)
- Multi-head attention — parallel focus
- The Transformer architecture:
  - Encoder-decoder structure
  - Positional encoding — encoding order
  - Feed-forward blocks
  - Layer normalization and residual connections
- Why better than RNN? (parallelization, long-range dependencies)
- Transformer variants:
  - Encoder-only: BERT (bidirectional understanding)
  - Decoder-only: GPT family (generation)
  - Encoder-decoder: T5, BART
- Vision Transformer (ViT) — splitting images into patches
- Use cases: NLP, computer vision, multimodal AI, everything

### Chapter 8: Temporal Convolutional Networks (TCN)
- Applying CNNs to time series
- Dilated (expanded) convolutions
- Causal convolution — filtering without the future
- TCN vs. RNN/LSTM comparison
- Use cases: time series forecasting, audio, video

---

## PART III: GENERATIVE MODELS — "Machines That Create"

### Chapter 9: Autoencoder — Compression and Reconstruction
- Encoder-decoder core concept
- The latent space (bottleneck) idea
- Types:
  - Vanilla autoencoder
  - Sparse autoencoder
  - Denoising autoencoder
  - Contractive autoencoder
- Use cases: dimensionality reduction, anomaly detection, feature learning

### Chapter 10: VAE — Variational Autoencoder
- Probabilistic thinking: why isn't a plain autoencoder enough for generation?
- ELBO and the reparameterization trick (intuitively)
- Structuring the latent space — why does the VAE become "smoother"?
- VAE vs. autoencoder: generation vs. reconstruction
- VQ-VAE — discrete latent space
- Use cases: image generation, data generation, drug discovery

### Chapter 11: GAN — Generative Adversarial Networks
- The "counterfeiter vs. detective" game
- Generator and Discriminator
- Training dynamics and instability
- Mode collapse — when the generator gets "stuck"
- Key GAN variants:
  - DCGAN (convolutional)
  - WGAN (Wasserstein distance)
  - StyleGAN (style control)
  - Pix2Pix, CycleGAN (image-to-image translation)
  - Conditional GAN (conditional generation)
- Use cases: image generation, style transfer, super-resolution, data augmentation

### Chapter 12: Diffusion Models — "Creating Order from Noise"
- The core idea: adding noise then removing it
- Forward process (noising) and reverse process (denoising)
- DDPM — Denoising Diffusion Probabilistic Models
- Score matching and score-based models
- Latent diffusion (foundation of Stable Diffusion)
- Classifier-free guidance — text-based steering
- Why better than GAN? (stability, diversity)
- Use cases: image generation (DALL-E 2, Stable Diffusion, Midjourney), video, audio, 3D

### Chapter 13: Normalizing Flows — "Simple to Complex"
- The core idea: chain of invertible transformations
- Change-of-variables formula and the Jacobian determinant
- NICE, RealNVP, Glow
- Continuous Normalizing Flows (Neural ODE connection)
- Flow Matching — the latest approach
- Advantages: exact likelihood, invertibility
- Disadvantages: computational cost, same-dimensional latent space
- Use cases: density estimation, generation, anomaly detection

---

## PART IV: SPECIALIZED ARCHITECTURES & METHODS

### Chapter 14: Graph Neural Networks (GNN) — "Networks About Networks"
- Graph-structured data (molecules, social networks, knowledge graphs)
- Message passing — sending messages between neighbors
- GCN (Graph Convolutional Network)
- GAT (Graph Attention Network)
- GraphSAGE — sampling from large graphs
- Use cases: molecule design, recommender systems, community detection

### Chapter 15: State Space Models (SSM) & Mamba
- Mathematical basis of state space models
- Why does it scale better than Transformer?
- S4, S5, Mamba architecture
- Selective state space — dynamic filtering
- Mamba vs. Transformer — when to use which?
- Use cases: long sequences, efficient inference

### Chapter 16: Capsule Networks
- Hinton's critique of pooling
- Capsule = group of neurons encoding a "pose"
- Dynamic routing between capsules
- Why hasn't it caught on? (computational cost, scalability)

### Chapter 17: Kolmogorov-Arnold Networks (KAN)
- The core idea: learnable activation functions on edges
- KAN vs. MLP — structure and interpretability
- Use cases: scientific discovery, symbolic regression

---

## PART V: LEARNING PARADIGMS — "How Do We Teach?"

### Chapter 18: Transfer Learning & Fine-tuning
- Using pre-trained models
- Feature extraction vs. fine-tuning
- Domain adaptation
- The "foundation model" concept

### Chapter 19: Self-Supervised Learning
- Pretext tasks: contextual prediction, image rotation, etc.
- Contrastive learning (SimCLR, MoCo, CLIP)
- Masked modeling (BERT, MAE)
- Why it's revolutionary: learning without labeled data

### Chapter 20: Reinforcement Learning & Deep RL
- RL fundamentals (agent, environment, reward, policy)
- Deep Q-Network (DQN)
- Policy Gradient methods (REINFORCE, PPO)
- Actor-Critic architectures
- RLHF — learning from human feedback (LLM context)

### Chapter 21: Federated & Edge Learning
- Decentralized learning: data stays put, model moves
- Privacy preservation
- Edge AI — on-device inference

---

## PART VI: MODERN TRENDS & SUMMARY

### Chapter 22: Multimodal Models
- Image + text (CLIP, Flamingo, GPT-4V)
- Text → image (DALL-E, Stable Diffusion)
- Audio + text (Whisper)
- Toward the "everything model"

### Chapter 23: The Architecture Family Tree — Summary
- Visual taxonomy: what evolved from what
- Decision tree: which architecture for which task?
- The "no free lunch" principle — trade-offs everywhere

### Chapter 24: Where Is Deep Learning Headed?
- Scaling laws — size and performance
- Mixture of Experts (MoE)
- Neural Architecture Search (NAS)
- Neuromorphic computing
- Energy efficiency and sustainability
- Open questions

---

## APPENDICES
- A: Mathematical Summary (linear algebra, probability, calculus — minimal)
- B: Python/PyTorch Quick Reference Code Snippets
- C: Glossary
- D: Recommended Resources (books, courses, papers)
