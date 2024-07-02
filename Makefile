
ROOT_DIR = $(CURDIR)

.PHONY: all setup run help

all: help

setup:
	./setup.sh

run:
	python3 uvm_generator.py

help:
	@echo ""
	@echo "=================================================================="
	@echo ""
	@echo "---------------------------- Targets -----------------------------"
	@echo "  setup               : Create Python Environment"
	@echo "  run                 : Run uvm_generator.py"
	@echo "  help                : Display help message"
	@echo ""
	@echo "=================================================================="
	@echo ""
