.PHONY: install install-gpu webui train chat export

install:
	python -m pip install --upgrade pip
	pip install -r requirements.txt

install-gpu:
	pip install -r requirements-gpu.txt

webui:
	llamafactory-cli webui

train:
	llamafactory-cli train configs/train/fermata_qwen3_lora_sft.yaml

chat:
	llamafactory-cli chat configs/inference/fermata_qwen3_lora_sft.yaml

export:
	llamafactory-cli export configs/export/fermata_qwen3_lora_sft.yaml
