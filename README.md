# Fermata Lab LLaMA

A lightweight project scaffold for fine-tuning music-intelligence models with [LLaMA-Factory](https://github.com/hiyouga/LLaMA-Factory).

This repo is intentionally small: it stores project-specific datasets, configs, and scripts, while installing LLaMA-Factory from upstream instead of vendoring the full framework.

## What this is set up for

The first training target is supervised fine-tuning (SFT) on music QA and symbolic music reasoning examples, such as:

- music theory QA
- chord and harmony analysis
- ABC notation understanding
- score-derived question answering
- benchmark-style instruction examples

Do not train on held-out benchmark test sets if you want honest evaluation results.

## Quick Start

Create an environment with Python 3.11 or newer:

```bash
python3.11 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

For CUDA/QLoRA training, you may also need GPU-specific packages:

```bash
pip install -r requirements-gpu.txt
```

Confirm the CLI is available:

```bash
llamafactory-cli help
```

## Data

A small sample dataset lives at:

```text
data/music_theory_sft_sample.json
```

It is registered in:

```text
data/dataset_info.json
```

LLaMA-Factory expects custom datasets to be declared in `dataset_info.json`. The sample uses the `alpaca` SFT shape:

```json
{
  "instruction": "Analyze the cadence.",
  "input": "G7 - C in C major",
  "output": "This is an authentic cadence resolving dominant to tonic."
}
```

## Train

Edit the model path and hyperparameters in:

```text
configs/train/fermata_qwen3_lora_sft.yaml
```

Then run:

```bash
llamafactory-cli train configs/train/fermata_qwen3_lora_sft.yaml
```

## Chat With The Adapter

```bash
llamafactory-cli chat configs/inference/fermata_qwen3_lora_sft.yaml
```

## Export / Merge

```bash
llamafactory-cli export configs/export/fermata_qwen3_lora_sft.yaml
```

## LLaMA-Factory Web UI

```bash
llamafactory-cli webui
```

Use `data/dataset_info.json` as the dataset directory metadata when configuring runs.

## Suggested First Milestone

1. Replace the sample dataset with 200-500 clean music examples.
2. Keep a separate held-out evaluation file under `eval/`.
3. Train a small LoRA adapter.
4. Compare base-model and adapter outputs on the same prompts.
5. Only then scale data size or move into audio/multimodal training.
