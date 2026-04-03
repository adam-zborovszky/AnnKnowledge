#!/usr/bin/env bash
set -euo pipefail

# ============================================================================
# Deep Learning Book — Orchestrator (Pure Bash)
# ============================================================================
#
# Usage:
#   ./orchestrator.sh                  # Full run from beginning
#   ./orchestrator.sh --phase 3        # Start from phase 3
#   ./orchestrator.sh --phase 4 --step 5  # Phase 4, step 5
#   ./orchestrator.sh --resume         # Resume from last checkpoint
#   ./orchestrator.sh --dry-run        # Only print what it would do
#
# Prerequisites:
#   - Claude Code CLI: npm install -g @anthropic-ai/claude-code
#   - 01_BOOK_STRUCTURE.md, 02_GUIDELINES.md in same directory
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Directories
RESEARCH_DIR="research_notes"
CONDENSED_DIR="condensed"
OUTLINE_DIR="outline"
CHAPTERS_DIR="chapters"
REVIEWED_DIR="chapters_reviewed"
OUTPUT_DIR="output"

LOG_FILE="orchestrator.log"
STATE_FILE="orchestrator_state.txt"

MAX_RETRIES=2
DRY_RUN=false
START_PHASE=1
START_STEP=1

# ============================================================================
# HELPERS
# ============================================================================

log() {
    local msg="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$msg"
    echo "$msg" >> "$LOG_FILE"
}

ensure_dirs() {
    mkdir -p "$RESEARCH_DIR" "$CONDENSED_DIR" "$OUTLINE_DIR" "$CHAPTERS_DIR" "$REVIEWED_DIR" "$OUTPUT_DIR"
}

save_state() {
    echo "${1}:${2}" > "$STATE_FILE"
}

load_state() {
    if [[ -f "$STATE_FILE" ]]; then
        cat "$STATE_FILE"
    else
        echo "1:1"
    fi
}

file_ok() {
    [[ -f "$1" ]] && [[ $(wc -c < "$1") -gt 100 ]]
}

# Core function: call Claude Code with context files and a prompt
# Usage: call_claude "output_file" "prompt_text" file1.md file2.md ...
call_claude() {
    local output_file="$1"
    local prompt="$2"
    shift 2
    local context_files=("$@")

    # Build the full prompt with context
    local full_prompt=""

    for cf in "${context_files[@]}"; do
        if [[ -f "$cf" ]]; then
            full_prompt+="--- FILE: $(basename "$cf") ---
$(cat "$cf")
--- END FILE ---

"
        else
            log "  WARNING: $cf not found, skipping"
        fi
    done

    full_prompt+="
--- TASK ---
${prompt}

Save the result to: ${output_file}
"

    local attempt=0
    local delays=(5 15 45)

    while [[ $attempt -le $MAX_RETRIES ]]; do
        log "  Claude call (attempt $((attempt+1))/$((MAX_RETRIES+1)))..."

        # Write prompt to temp file, pipe it to claude to avoid ARG_MAX limit
        local tmp_prompt
        tmp_prompt=$(mktemp)
        printf '%s' "$full_prompt" > "$tmp_prompt"

        local result=0
        cat "$tmp_prompt" | claude -p > "${output_file}.tmp" 2>"${output_file}.err" || result=$?

        rm -f "$tmp_prompt"

        if [[ $result -eq 0 ]]; then
            # Check if Claude wrote directly to output_file
            if file_ok "$output_file"; then
                log "  ✓ Success: $output_file"
                rm -f "${output_file}.tmp" "${output_file}.err"
                return 0
            # Otherwise use stdout capture
            elif [[ -f "${output_file}.tmp" ]] && [[ $(wc -c < "${output_file}.tmp") -gt 200 ]]; then
                mv "${output_file}.tmp" "$output_file"
                log "  ✓ Success (from stdout): $output_file"
                rm -f "${output_file}.err"
                return 0
            else
                log "  ✗ Output file empty or not created"
            fi
        else
            local errmsg=""
            [[ -f "${output_file}.err" ]] && errmsg=$(head -c 300 "${output_file}.err")
            log "  ✗ Error (exit code $result): $errmsg"
        fi

        rm -f "${output_file}.tmp" "${output_file}.err"
        attempt=$((attempt + 1))

        if [[ $attempt -le $MAX_RETRIES ]]; then
            local delay=${delays[$((attempt-1))]}
            log "  Waiting ${delay}s..."
            sleep "$delay"
        fi
    done

    log "  ✗✗✗ FAILED after $((MAX_RETRIES+1)) attempts: $output_file"
    return 1
}

# ============================================================================
# PHASE 1: RESEARCH
# ============================================================================

phase1_research() {
    local start_step=${1:-1}

    log "============================================================"
    log "PHASE 1: RESEARCH"
    log "============================================================"

    local -a task_ids=("01_foundations" "02_cnn_rnn" "03_transformer_tcn" "04_generative" "05_specialized" "06_trends")

    local -a task_topics=(
"PART I: FOUNDATIONS (Chapters 1-4)
- Artificial neuron, perceptron, activation functions (sigmoid, tanh, ReLU, GELU, Swish)
- Feedforward networks (MLP), layers, universal approximation
- Learning: loss functions, backpropagation, optimizers (SGD, Adam, AdamW)
- Regularization: dropout, batch norm, L1/L2, early stopping
- Vanishing/exploding gradient, skip connections, initialization
Create detailed, well-organized research notes. Use analogies and intuitive explanations."

"PART II / Chapters 5-6: CNN and RNN
CNN: Convolution, pooling, padding, stride. Architecture evolution: LeNet, AlexNet, VGG, GoogLeNet, ResNet, DenseNet, EfficientNet, MobileNet. Deconvolution, U-Net. Applications: image recognition, object detection, segmentation.
RNN: RNN core idea, vanishing gradient problem. LSTM (gates in detail), GRU. Bidirectional RNN, Seq2Seq. Applications: NLP, time series, speech.
Create detailed research notes with intuitive explanations."

"PART II / Chapters 7-8: Transformer and TCN
Transformer: Attention mechanism origin (Bahdanau). Self-attention, Q/K/V, multi-head attention. Full Transformer architecture: encoder-decoder, positional encoding, layer norm, residual. Variants: BERT, GPT, T5. Vision Transformer (ViT).
TCN: Temporal convolutional networks. Dilated convolutions, causal convolution. TCN vs RNN comparison.
Create detailed research notes, with special emphasis on intuitive attention explanation."

"PART III: GENERATIVE MODELS (Chapters 9-13)
Autoencoder: vanilla, sparse, denoising, contractive, latent space. VAE: ELBO, reparameterization, VQ-VAE, comparison with AE. GAN: generator/discriminator, training, mode collapse, DCGAN, WGAN, StyleGAN, Pix2Pix, CycleGAN. Diffusion models: DDPM, score matching, latent diffusion, classifier-free guidance. Normalizing Flows: invertible transforms, Jacobian determinant, NICE, RealNVP, Glow, flow matching.
Create detailed research notes, especially focusing on differences between generative models."

"PARTS IV-V: SPECIALIZED ARCHITECTURES and LEARNING PARADIGMS (Chapters 14-21)
Specialized: GNN (message passing, GCN, GAT, GraphSAGE). State Space Models (S4, Mamba, selective SSM). Capsule Networks (Hinton, dynamic routing). KAN (Kolmogorov-Arnold Networks).
Paradigms: Transfer learning, fine-tuning, foundation models. Self-supervised learning: contrastive (SimCLR, CLIP), masked (BERT, MAE). Deep RL: DQN, policy gradient, PPO, actor-critic, RLHF. Federated learning, edge AI.
Create detailed research notes."

"PART VI: MODERN TRENDS (Chapters 22-24)
Multimodal models: CLIP, GPT-4V, Flamingo, DALL-E, Stable Diffusion, Whisper. Scaling laws, Mixture of Experts (MoE). Neural Architecture Search (NAS). Neuromorphic computing. Energy efficiency. Deep learning architecture family tree (summary, decision tree).
Create detailed research notes, especially focusing on future directions."
    )

    for i in "${!task_ids[@]}"; do
        local step=$((i + 1))
        [[ $step -lt $start_step ]] && continue

        local id="${task_ids[$i]}"
        local output="${RESEARCH_DIR}/${id}.md"

        if file_ok "$output"; then
            log "  Step 1.${step}: ALREADY DONE ($output)"
            continue
        fi

        log "  Step 1.${step}: $id"

        local prompt="Task: Create a deep learning research note in English.

The full book structure and style guidelines are provided as context.

Topics and detailed instructions:
${task_topics[$i]}

IMPORTANT:
- Write in English
- Use analogies and everyday examples
- Follow the GUIDELINES terminology table
- This is raw material gathering, do NOT write a finished chapter
- More is better than less — condensation happens later
- For every concept: what is it, why does it matter, how does it work, what is it used for"

        if ! call_claude "$output" "$prompt" "02_GUIDELINES.md" "01_BOOK_STRUCTURE.md"; then
            log "  !!! Phase 1 stuck at step $step. Re-run: --phase 1 --step $step"
            return 1
        fi

        save_state 1 $((step + 1))
    done

    log "PHASE 1 DONE ✓"
}

# ============================================================================
# PHASE 2: CONDENSATION
# ============================================================================

phase2_condense() {
    local start_step=${1:-1}

    log "============================================================"
    log "PHASE 2: CONDENSATION"
    log "============================================================"

    local step=0
    for rf in "$RESEARCH_DIR"/*.md; do
        [[ ! -f "$rf" ]] && continue
        step=$((step + 1))
        [[ $step -lt $start_step ]] && continue

        local basename
        basename=$(basename "$rf" .md)
        local output="${CONDENSED_DIR}/${basename}_condensed.md"

        if file_ok "$output"; then
            log "  Step 2.${step}: ALREADY DONE ($output)"
            continue
        fi

        log "  Step 2.${step}: Condensing: $(basename "$rf")"

        local prompt="Task: Condense a research note.

Create a concise extract from the provided research note:
- Only the most important facts, definitions, relationships
- Keep analogy suggestions
- Remove redundancy
- Target: ~30% of original length, but ~90% of the information
- Do NOT lose essential technical detail
- Keep the structure (chapter breakdown)

This is condensation, not rewriting. The essence stays, the verbosity goes."

        if ! call_claude "$output" "$prompt" "02_GUIDELINES.md" "$rf"; then
            return 1
        fi

        save_state 2 $((step + 1))
    done

    log "PHASE 2 DONE ✓"
}

# ============================================================================
# PHASE 3: OUTLINE
# ============================================================================

phase3_outline() {
    log "============================================================"
    log "PHASE 3: OUTLINE CREATION"
    log "============================================================"

    local output="${OUTLINE_DIR}/book_outline.md"

    if file_ok "$output"; then
        log "  ALREADY DONE"
        return 0
    fi

    local context_files=("02_GUIDELINES.md" "01_BOOK_STRUCTURE.md")
    for cf in "$CONDENSED_DIR"/*.md; do
        [[ -f "$cf" ]] && context_files+=("$cf")
    done

    local prompt="Task: Create a detailed book outline in English.

All condensed research notes and the book structure are available.

Create a DETAILED chapter-level outline:

For each chapter:
1. Opening question/hook (1 sentence)
2. Subsections with short descriptions (2-3 sentences per subsection)
3. Recommended analogy/analogies from the Analogy Bank
4. Cross-references: [see: Chapter N, concept]
5. Estimated word count
6. Bridge sentence to the next chapter

IMPORTANT:
- The outline must be detailed enough for another agent to write the chapter independently
- Mark inter-chapter dependencies
- Ensure no circular references (no reference to concepts not yet introduced)
- Difficulty should increase gradually"

    if ! call_claude "$output" "$prompt" "${context_files[@]}"; then
        return 1
    fi

    save_state 3 2
    log "PHASE 3 DONE ✓"
}

# ============================================================================
# PHASE 4: WRITING
# ============================================================================

phase4_write() {
    local start_step=${1:-1}

    log "============================================================"
    log "PHASE 4: WRITING CHAPTERS"
    log "============================================================"

    local outline="${OUTLINE_DIR}/book_outline.md"

    # Arrays: output_file | chapter_desc | research_file | word_target
    local -a tasks=(
        "01_neuron.md|Chapter 1: The Neuron|01_foundations.md|3000-4000"
        "02_networks.md|Chapter 2: Networks|01_foundations.md|3000-4000"
        "03_learning.md|Chapter 3: How Does a Network Learn?|01_foundations.md|4000-5000"
        "04_problems.md|Chapter 4: Problems of Learning and Their Solutions|01_foundations.md|4000-5000"
        "05_cnn.md|Chapter 5: CNN|02_cnn_rnn.md|4000-5000"
        "06_rnn.md|Chapter 6: RNN|02_cnn_rnn.md|4000-5000"
        "07_transformer.md|Chapter 7: Attention and Transformer|03_transformer_tcn.md|5000-6000"
        "08_tcn.md|Chapter 8: TCN|03_transformer_tcn.md|2000-3000"
        "09_autoencoder.md|Chapter 9: Autoencoder|04_generative.md|3000-4000"
        "10_vae.md|Chapter 10: VAE|04_generative.md|3000-4000"
        "11_gan.md|Chapter 11: GAN|04_generative.md|4000-5000"
        "12_diffusion.md|Chapter 12: Diffusion Models|04_generative.md|4000-5000"
        "13_flows.md|Chapter 13: Normalizing Flows|04_generative.md|3000-4000"
        "14_17_specialized.md|Chapters 14-17: GNN, SSM/Mamba, Capsule Networks, KAN|05_specialized.md|6000-8000"
        "18_21_paradigms.md|Chapters 18-21: Transfer Learning, Self-Supervised, Deep RL, Federated|05_specialized.md|6000-8000"
        "22_24_trends.md|Chapters 22-24: Multimodal, Family Tree, Future + Appendices|06_trends.md|6000-8000"
    )

    local step=0
    for task in "${tasks[@]}"; do
        step=$((step + 1))
        [[ $step -lt $start_step ]] && continue

        IFS='|' read -r out_file ch_desc res_file word_target <<< "$task"

        local output="${CHAPTERS_DIR}/${out_file}"
        local research="${RESEARCH_DIR}/${res_file}"

        if file_ok "$output"; then
            log "  Step 4.${step}: ALREADY DONE ($output)"
            continue
        fi

        log "  Step 4.${step}: Writing: $ch_desc"

        local prompt="Task: Write a book chapter in English.

Write: ${ch_desc}

Requirements:
- FOLLOW the GUIDELINES chapter template (opening question, intuitive, technical, variants, practical, summary, bridge)
- USE the terminology table consistently
- Cross-references in [see: Chapter N] format
- Target length: ${word_target} words
- Use analogies from the Analogy Bank
- The reader is intelligent but unfamiliar with the topic
- For EVERY new concept: intuition first, then technical details
- Define every term on first occurrence

CONTEXT:
- The detailed research notes and the book outline are attached
- Earlier chapters have already been written — build on previously introduced concepts"

        if ! call_claude "$output" "$prompt" "02_GUIDELINES.md" "$outline" "$research"; then
            return 1
        fi

        save_state 4 $((step + 1))
    done

    log "PHASE 4 DONE ✓"
}

# ============================================================================
# PHASE 5: REVIEW & ASSEMBLY
# ============================================================================

phase5_review() {
    local start_step=${1:-1}

    log "============================================================"
    log "PHASE 5: REVIEW & ASSEMBLY"
    log "============================================================"

    local outline="${OUTLINE_DIR}/book_outline.md"

    # Review tasks: output | chapter files (space-separated)
    local -a reviews=(
        "part1.md|01_neuron.md 02_networks.md 03_learning.md 04_problems.md"
        "part2.md|05_cnn.md 06_rnn.md 07_transformer.md 08_tcn.md"
        "part3.md|09_autoencoder.md 10_vae.md 11_gan.md 12_diffusion.md 13_flows.md"
        "part4.md|14_17_specialized.md 18_21_paradigms.md"
        "part5.md|22_24_trends.md"
    )

    local step=0
    for review in "${reviews[@]}"; do
        step=$((step + 1))
        [[ $step -lt $start_step ]] && continue

        IFS='|' read -r out_file ch_files <<< "$review"

        local output="${REVIEWED_DIR}/${out_file}"

        if file_ok "$output"; then
            log "  Step 5.${step}: ALREADY DONE ($output)"
            continue
        fi

        log "  Step 5.${step}: Review: $out_file"

        local context_files=("02_GUIDELINES.md" "$outline")
        for cf in $ch_files; do
            context_files+=("${CHAPTERS_DIR}/${cf}")
        done

        local prompt="Task: Review and fix a book section.

Check and fix the provided chapters:

1. TERMINOLOGY: Consistent with the terminology table?
2. CROSS-REFERENCES: Correct chapter numbers? Existing concepts?
3. BRIDGES: Logical transitions between chapters?
4. FORWARD REFERENCES: No reference to concepts not yet introduced?
5. TONE: Consistent style?
6. REDUNDANCY: Unnecessary repetition across chapters?
7. GAPS: Anything missing per the outline?

The fixed chapters should go into a SINGLE output, preserving the original structure."

        if ! call_claude "$output" "$prompt" "${context_files[@]}"; then
            return 1
        fi

        save_state 5 $((step + 1))
    done

    # Final assembly
    local final_step=$((${#reviews[@]} + 1))
    if [[ $start_step -le $final_step ]]; then
        log "  Final assembly..."

        local final_output="${OUTPUT_DIR}/deep_learning_book.md"

        if file_ok "$final_output"; then
            log "  ALREADY DONE (final)"
        else
            local context_files=("02_GUIDELINES.md")
            for rf in "$REVIEWED_DIR"/*.md; do
                [[ -f "$rf" ]] && context_files+=("$rf")
            done

            local prompt="Task: Final book assembly.

All reviewed book sections are available.

Create the final book:
1. Generate a table of contents
2. Concatenate sections in the correct order
3. Write a preface (2-3 paragraphs — why this book, who it is for)
4. Finalize chapter numbering
5. Verify cross-references against final numbering

The result should be a coherent, unified markdown document."

            if ! call_claude "$final_output" "$prompt" "${context_files[@]}"; then
                # Fallback: simple concatenation
                log "  Fallback: simple concatenation..."
                echo "# Deep Learning — The Logic of Learning Deeply" > "$final_output"
                echo "" >> "$final_output"
                for rf in "$REVIEWED_DIR"/*.md; do
                    [[ -f "$rf" ]] && cat "$rf" >> "$final_output" && echo -e "\n\n---\n" >> "$final_output"
                done
            fi
        fi
    fi

    log "PHASE 5 DONE ✓"
}

# ============================================================================
# ARGUMENT PARSING
# ============================================================================

while [[ $# -gt 0 ]]; do
    case "$1" in
        --phase)   START_PHASE="$2"; shift 2 ;;
        --step)    START_STEP="$2"; shift 2 ;;
        --dry-run) DRY_RUN=true; shift ;;
        --resume)
            IFS=':' read -r START_PHASE START_STEP <<< "$(load_state)"
            log "Resuming: Phase $START_PHASE, Step $START_STEP"
            shift ;;
        -h|--help)
            echo "Usage: $0 [--phase N] [--step N] [--resume] [--dry-run]"
            exit 0 ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
done

# ============================================================================
# MAIN
# ============================================================================

ensure_dirs

# Check claude is available
if ! command -v claude &>/dev/null; then
    echo "ERROR: 'claude' command not found."
    echo "Install: npm install -g @anthropic-ai/claude-code"
    exit 1
fi

if $DRY_RUN; then
    log "DRY RUN — printing planned steps:"
    log ""
    log "Phase 1: RESEARCH (6 calls)"
    for id in 01_foundations 02_cnn_rnn 03_transformer_tcn 04_generative 05_specialized 06_trends; do
        log "  Research: $id"
    done
    log ""
    log "Phase 2: CONDENSE (6 calls)"
    log "  Condense each research note to ~30%"
    log ""
    log "Phase 3: OUTLINE (1 call)"
    log "  Create detailed book outline"
    log ""
    log "Phase 4: WRITE (16 calls)"
    log "  Write all 24 chapters"
    log ""
    log "Phase 5: REVIEW + ASSEMBLE (6 calls)"
    log "  Review 5 parts + final assembly"
    exit 0
fi

log "============================================================"
log "DEEP LEARNING BOOK — GENERATION STARTING"
log "Start phase: $START_PHASE, Start step: $START_STEP"
log "============================================================"

for phase in $(seq "$START_PHASE" 5); do
    step=1
    [[ $phase -eq $START_PHASE ]] && step=$START_STEP

    case $phase in
        1) phase1_research "$step" ;;
        2) phase2_condense "$step" ;;
        3) phase3_outline ;;
        4) phase4_write "$step" ;;
        5) phase5_review "$step" ;;
    esac

    if [[ $? -ne 0 ]]; then
        log ""
        log "!!! STOPPED at Phase $phase"
        log "Resume: ./orchestrator.sh --resume"
        exit 1
    fi

    log ""
    log "--- CONTEXT CLEAR (Phase $phase → $((phase+1))) ---"
    log ""
done

log "============================================================"
log "BOOK GENERATION COMPLETE ✓"
log "Result: ${OUTPUT_DIR}/deep_learning_book.md"
log "============================================================"
