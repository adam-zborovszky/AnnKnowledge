# GUIDELINES — Deep Learning Book Style & Conventions

## GOAL
An accessible deep learning textbook that:
- Builds knowledge in a logical order (every chapter builds on the previous)
- Avoids unnecessary academic jargon
- Uses analogies and everyday examples
- Maintains consistent terminology throughout

---

## STYLE RULES

### Tone
- **Friendly but not childish** — as if an experienced colleague is explaining
- **Not condescending** — the reader is intelligent, just unfamiliar with the topic
- **Active, not passive** — "The network learns..." not "It is learned by the network..."
- **Question-driven** — every chapter opens with a question or problem

### Structure (per chapter)
1. **Opening question/problem** — why do we need this? (1-2 paragraphs)
2. **Intuitive explanation** — with analogy, everyday example (2-3 paragraphs)
3. **Technical description** — the actual mechanics, explained clearly (the chapter's core)
4. **Variants/evolution** — how the idea developed further
5. **Practical applications** — concrete use cases
6. **Summary** — the essence in 3-5 sentences
7. **Bridge to next chapter** — transitional paragraph

### Mathematics
- **Minimal but nonzero** — include where needed, but always with intuition
- BEFORE every formula: textual explanation of what it computes
- AFTER every formula: plain-English restatement of what it means
- Notation: consistent throughout the entire book (see Notation Table)

### Terminology Rules
- Technical terms should be used consistently throughout
- On FIRST occurrence of a term, provide a clear, concise definition
- Use standard ML/DL English terminology (no invented synonyms)
- Abbreviations: spell out on first use, then abbreviation only

### Core Terminology Table (mandatory, consistent throughout)

| Term | Abbreviation | First-Use Definition Required |
|---|---|---|
| network | — | yes |
| layer | — | yes |
| neuron / unit | — | yes |
| weight | — | yes |
| bias | — | yes |
| loss function | — | yes |
| gradient | — | yes |
| learning rate | LR | yes |
| backpropagation | backprop | yes |
| overfitting | — | yes |
| underfitting | — | yes |
| regularization | — | yes |
| batch size | — | yes |
| epoch | — | yes |
| convolution | conv | yes |
| filter / kernel | — | yes |
| pooling | — | yes |
| attention | — | yes |
| latent space | — | yes |
| generator | — | yes (in GAN context) |
| discriminator | — | yes (in GAN context) |
| encoder | — | yes |
| decoder | — | yes |
| feature map | — | yes |
| embedding | — | yes |
| fine-tuning | — | yes |
| pre-training | — | yes |
| token | — | yes |
| inference | — | yes |
| forward pass | — | yes |
| backward pass | — | yes |

### Notation Table (mathematical symbols)

| Symbol | Meaning |
|---|---|
| x | input vector |
| y | target value |
| ŷ | prediction (estimated output) |
| w | weights |
| b | bias |
| σ | activation function (general) |
| L | loss |
| η (eta) | learning rate |
| θ | all model parameters |
| ∇ | gradient operator |
| W | weight matrix |
| h | hidden state |
| z | latent variable |
| T | number of time steps |
| N | number of samples / batch size (context-dependent) |
| d | dimensionality |

---

## ANALOGY BANK (recommended analogies for consistent use)

- **Neuron** → "voter" who makes a yes/no decision based on weighted inputs
- **Layers** → "chain of filters" — early ones see simple patterns, deeper ones see complex ones
- **Backpropagation** → "tracing the error backward" — like finding which station on an assembly line introduced a defect
- **CNN filters** → "a small window sliding across the image" — like a flashlight beam scanning a wall
- **RNN memory** → "a note you keep passing around" — you write on it and hand it to the next step
- **LSTM** → "a smart note" that can decide what to remember and what to forget
- **Attention** → "a highlighter" — like highlighting the important words in a text
- **Transformer** → "everyone sees everyone at once" vs. RNN "reads one word at a time"
- **GAN** → "counterfeiter (generator) vs. detective (discriminator)"
- **VAE latent space** → "a coordinate system in face-space" — sliders: smile, hair color, age, etc.
- **Diffusion** → "a photo dissolving into static noise, then learning to un-dissolve it"
- **Normalizing flow** → "clay sculpting" — simple shape gradually transformed into a complex one through reversible steps

---

## CHAPTER TEMPLATE

```markdown
# Chapter [N]: [Chapter Title]

> **One-sentence summary**: [What is this and why does it matter?]

## Why Do We Need This?
[Motivation, problem statement — 1-2 paragraphs]

## The Core Idea
[Intuitive explanation with analogy — 2-3 paragraphs]

## How Does It Work?
[Technical description — the chapter's core, with subsections]

### [Subsection 1]
### [Subsection 2]

## Variants and Evolution
[How the idea evolved — relevant variations]

## Practical Applications
[Concrete use cases — 3-5 examples briefly]

## Summary
[3-5 sentences — the chapter's essence]

---
*In the next chapter, we'll explore [bridge]...*
```

---

## QUALITY CHECKLIST (per chapter)

- [ ] Has an opening question/motivation?
- [ ] Contains at least one analogy?
- [ ] Terminology is consistent with the table?
- [ ] Every term is defined on first occurrence?
- [ ] Mathematical formulas have textual explanation before AND after?
- [ ] References relevant parts of previous chapters?
- [ ] Has a bridge to the next chapter?
- [ ] Does not use undefined terms without explanation?
- [ ] Tone is friendly but not childish?
- [ ] Has a "Practical Applications" section?
- [ ] Code examples (if any) use PyTorch and are minimal/clear?
