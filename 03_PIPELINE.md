# PIPELINE PLAN — Deep Learning Book Generation with Claude Code

## OVERVIEW

The book is generated in 5 phases using a sub-agent pattern.
Each phase has a clear objective, and context is cleared between phases.

```
┌─────────────────────────────────────────────────────────────┐
│                   ORCHESTRATOR (orchestrator.py)             │
│                                                             │
│  Phase 1: RESEARCH ──→ research_notes/{topic}.md            │
│     │                                                       │
│  Phase 2: CONDENSE ──→ condensed/{topic}_condensed.md       │
│     │                                                       │
│  Phase 3: OUTLINE ──→ outline/book_outline.md               │
│     │                                                       │
│  Phase 4: WRITE ──→ chapters/{chapter}.md                   │
│     │                                                       │
│  Phase 5: REVIEW + ASSEMBLE ──→ book_final.md               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## CONTEXT MANAGEMENT PRINCIPLE

### The Problem
Claude's context window is finite (~200k tokens). Researching, structuring,
and writing an entire book does not fit in a single context.

### The Solution: "File as Memory"
- Every intermediate result is written to a file
- Every sub-agent call reads ONLY the files it needs
- Context is "cleared" between every sub-agent call (separate API call = clean context)
- The guidelines file is included in EVERY call (ensures consistency)

### Context Clear Points
```
[CONTEXT CLEAR] = new API call with only the necessary files

Phase 1 Research:
  Call 1.1: [GUIDELINES + STRUCTURE + "Research: Part I foundations"]  → research_notes/01_foundations.md
  Call 1.2: [GUIDELINES + STRUCTURE + "Research: CNN, RNN"]           → research_notes/02_cnn_rnn.md
  Call 1.3: [GUIDELINES + STRUCTURE + "Research: Transformer, TCN"]   → research_notes/03_transformer_tcn.md
  Call 1.4: [GUIDELINES + STRUCTURE + "Research: Generative models"]  → research_notes/04_generative.md
  Call 1.5: [GUIDELINES + STRUCTURE + "Research: Specialized + paradigms"] → research_notes/05_specialized.md
  Call 1.6: [GUIDELINES + STRUCTURE + "Research: Modern trends"]      → research_notes/06_trends.md

  [CONTEXT CLEAR]

Phase 2 Condensation:
  Call 2.1: [GUIDELINES + research_notes/01_foundations.md] → condensed/01_foundations_condensed.md
  Call 2.2: [GUIDELINES + research_notes/02_cnn_rnn.md]     → condensed/02_cnn_rnn_condensed.md
  ... (for each research note)

  [CONTEXT CLEAR]

Phase 3 Outline:
  Call 3.1: [GUIDELINES + STRUCTURE + ALL condensed/*.md] → outline/book_outline.md
  (A unified outline ensuring cross-chapter coherence)

  [CONTEXT CLEAR]

Phase 4 Writing (per chapter):
  Call 4.1:  [GUIDELINES + outline + research/01_foundations.md + "Write: Ch 1"]  → chapters/01_neuron.md
  Call 4.2:  [GUIDELINES + outline + research/01_foundations.md + "Write: Ch 2"]  → chapters/02_networks.md
  Call 4.3:  [GUIDELINES + outline + research/01_foundations.md + "Write: Ch 3"]  → chapters/03_learning.md
  Call 4.4:  [GUIDELINES + outline + research/01_foundations.md + "Write: Ch 4"]  → chapters/04_problems.md
  Call 4.5:  [GUIDELINES + outline + research/02_cnn_rnn.md + "Write: Ch 5"]     → chapters/05_cnn.md
  Call 4.6:  [GUIDELINES + outline + research/02_cnn_rnn.md + "Write: Ch 6"]     → chapters/06_rnn.md
  Call 4.7:  [GUIDELINES + outline + research/03_transformer_tcn.md + "Write: Ch 7"]  → chapters/07_transformer.md
  Call 4.8:  [GUIDELINES + outline + research/03_transformer_tcn.md + "Write: Ch 8"]  → chapters/08_tcn.md
  Call 4.9:  [GUIDELINES + outline + research/04_generative.md + "Write: Ch 9"]   → chapters/09_autoencoder.md
  Call 4.10: [GUIDELINES + outline + research/04_generative.md + "Write: Ch 10"]  → chapters/10_vae.md
  Call 4.11: [GUIDELINES + outline + research/04_generative.md + "Write: Ch 11"]  → chapters/11_gan.md
  Call 4.12: [GUIDELINES + outline + research/04_generative.md + "Write: Ch 12"]  → chapters/12_diffusion.md
  Call 4.13: [GUIDELINES + outline + research/04_generative.md + "Write: Ch 13"]  → chapters/13_flows.md
  Call 4.14: [GUIDELINES + outline + research/05_specialized.md + "Write: Ch 14-17"] → chapters/14_17_specialized.md
  Call 4.15: [GUIDELINES + outline + research/05_specialized.md + "Write: Ch 18-21"] → chapters/18_21_paradigms.md
  Call 4.16: [GUIDELINES + outline + research/06_trends.md + "Write: Ch 22-24 + appendices"] → chapters/22_24_trends.md

  [CONTEXT CLEAR]

Phase 5 Review & Assembly:
  Call 5.1: [GUIDELINES + outline + chapters/01-04] → chapters_reviewed/part1.md
  Call 5.2: [GUIDELINES + outline + chapters/05-08] → chapters_reviewed/part2.md
  Call 5.3: [GUIDELINES + outline + chapters/09-13] → chapters_reviewed/part3.md
  Call 5.4: [GUIDELINES + outline + chapters/14-21] → chapters_reviewed/part4.md
  Call 5.5: [GUIDELINES + outline + chapters/22-24] → chapters_reviewed/part5.md

  [CONTEXT CLEAR]

  Call 5.6: [All reviewed parts → concatenate + generate TOC] → book_final.md
```

---

## PHASE DETAILS

### Phase 1: RESEARCH
**Goal**: Collect raw knowledge for every topic
**Input**: GUIDELINES + STRUCTURE + topic description
**Output**: Detailed research notes as markdown files
**Sub-agent prompt template**:
```
Task: Create a deep learning research note.

Read:
- 02_GUIDELINES.md (style and terminology)
- 01_BOOK_STRUCTURE.md (full book structure)

Create a detailed research note on the following topics: [TOPIC LIST]

The note should include:
- Simple definition of every concept
- Historical context (who, when, why)
- Operating principle (intuitive + technical)
- Key variants
- Typical applications
- Connections to other book topics

Do NOT write a finished chapter — this is raw material gathering.
Save to: research_notes/[FILENAME].md
```

### Phase 2: CONDENSATION
**Goal**: Extract the essence into context-efficient form
**Input**: GUIDELINES + one research_notes file
**Output**: Condensed version (max 30% of original)

### Phase 3: OUTLINE
**Goal**: Detailed chapter-level outline from all condensed material
**Input**: GUIDELINES + STRUCTURE + ALL condensed files
**Output**: Chapter-level outline with paragraph-level precision

### Phase 4: WRITING
**Goal**: Write complete chapters
**Input**: GUIDELINES + outline + relevant research notes
**Output**: Finished chapter in markdown

### Phase 5: REVIEW + ASSEMBLY
**Goal**: Consistency check and finalization
**Input**: GUIDELINES + outline + written chapters (in parts)
**Output**: Reviewed chapters, then the final book

---

## FILE STRUCTURE

```
deep_learning_book/
├── 01_BOOK_STRUCTURE.md           # Full book structure and taxonomy
├── 02_GUIDELINES.md               # Style, terminology, templates
├── 03_PIPELINE.md                 # This document
├── orchestrator.py                # Orchestrator script
├── research_notes/                # Phase 1 output
│   ├── 01_foundations.md
│   ├── 02_cnn_rnn.md
│   ├── 03_transformer_tcn.md
│   ├── 04_generative.md
│   ├── 05_specialized.md
│   └── 06_trends.md
├── condensed/                     # Phase 2 output
├── outline/                       # Phase 3 output
│   └── book_outline.md
├── chapters/                      # Phase 4 output
├── chapters_reviewed/             # Phase 5 output
└── output/
    └── book_final.md              # Final book
```

---

## ERROR HANDLING

- If a sub-agent call returns no result → retry up to 2x
- If a chapter is too short (< 1500 words) → regenerate with "expand" instruction
- If terminology inconsistency → the review phase fixes it
- If API rate limit → exponential backoff (5s, 15s, 45s)

---

## ESTIMATES

- Total API calls: ~30-35
- Estimated token usage: ~500k-700k (input+output)
- Runtime: ~60-90 minutes (with API response times)
- Expected book length: ~60,000-80,000 words (~200-250 pages)
