# Deep Learning Book — Automated Generation

## What Is This?
A complete automated system for generating a deep learning textbook using
Claude Code with a sub-agent pattern.

## Files

| File | Description |
|------|-------------|
| `01_BOOK_STRUCTURE.md` | Full table of contents and taxonomy (24 chapters, 6 parts) |
| `02_GUIDELINES.md` | Style rules, terminology table, analogy bank, chapter template |
| `03_PIPELINE.md` | Detailed pipeline plan with context clear points |
| `orchestrator.py` | The orchestrator script that executes everything |
| `README.md` | This file |

## Quick Start

### 1. Prerequisites
```bash
# Install Claude Code (if not already installed)
npm install -g @anthropic-ai/claude-code
```

### 2. Copy Files
Copy all 5 files into an empty directory.

### 3. Run
```bash
# Full run (start to finish, ~60-90 min)
python orchestrator.py

# Dry run (only prints what it would do)
python orchestrator.py --dry-run

# Resume after interruption
python orchestrator.py --resume

# Start from a specific phase
python orchestrator.py --phase 3

# Start from a specific step within a phase
python orchestrator.py --phase 4 --step 5
```

### 4. Result
The finished book: `output/deep_learning_book.md`

## Pipeline Overview

```
Phase 1: RESEARCH (6 calls)
   → Detailed research notes per topic cluster
   
Phase 2: CONDENSE (6 calls)  
   → Research notes condensed to ~30%
   
Phase 3: OUTLINE (1 call)
   → Detailed chapter-level book outline
   
Phase 4: WRITE (16 calls)
   → Full chapters written
   
Phase 5: REVIEW + ASSEMBLE (6 calls)
   → Consistency check + final book
```

**Total: ~35 API calls, ~500-700k tokens**

## Context Management
The system handles the finite context window by:
- Every sub-agent call starts with a clean context
- Intermediate results are stored in files
- The guidelines file is included in EVERY call (consistency)
- Only necessary files are loaded into context

## Troubleshooting

**"claude command not found"**
→ `npm install -g @anthropic-ai/claude-code`

**Stuck at a phase**
→ `python orchestrator.py --resume` (continues from last checkpoint)

**A chapter is too short**
→ Delete the file from `chapters/` and re-run with `--resume`

**Rate limit**
→ The script automatically retries with exponential backoff

## Book Contents
- 24 chapters in 6 parts
- ~200-250 pages estimated
- From fundamentals (neuron, MLP) to modern trends (diffusion, Mamba, multimodal)
- Accessible style with analogies and everyday examples
- Consistent terminology throughout
