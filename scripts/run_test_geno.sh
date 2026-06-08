#!/usr/bin/env bash
# Quick runner for the provided test_geno dataset
# Usage: bash scripts/run_test_geno.sh
set -euo pipefail

# Adjust PYTHON if you use a virtualenv or conda env
PYTHON=${PYTHON:-python}

DATA_DIR="test_geno"
RAW_FILE="$DATA_DIR/test_geno.raw"
OUTPUT_DIR="model_outputs/test_geno_quick"

# Quick settings for a fast smoke test. Increase epochs/batch_size for real runs.
EPOCHS=5
BATCH_SIZE=32
LATENT_DIM=32
LEARNING_RATE=0.001
TEST_SIZE=0.2

mkdir -p "$OUTPUT_DIR"

echo "Running RBAM dual task (Joint VAE + Classifier) on $RAW_FILE"
echo "Output -> $OUTPUT_DIR"

$PYTHON runner/rbam_dual_task.py \
  "$RAW_FILE" \
  --output_dir "$OUTPUT_DIR" \
  --epochs $EPOCHS \
  --batch_size $BATCH_SIZE \
  --latent_dim $LATENT_DIM \
  --learning_rate $LEARNING_RATE \
  --test_size $TEST_SIZE \
  --run_cv \
  --n_folds 3 \

echo "Done. Check results in $OUTPUT_DIR"

