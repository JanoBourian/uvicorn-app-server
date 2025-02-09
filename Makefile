.PHONY: venv logs setup clean

OS := $(shell uname)
ifeq ($(OS), Windows_NT)
	ACTIVATE_CMD = .venv\Scripts\activate
else
	ACTIVATE_CMD = source .venv/bin/activate
endif

LOG_DIR = logs
RUFF_CACHE_DIR = .ruff_cache

delete-venv:
	@if [ -d ".venv" ]; then \
		echo "🗑️  Removing existing .venv directory..."; \
		rm -rf .venv; \
	else \
		echo "✅ No existing .venv found."; \
	fi

create-venv: delete-venv
	@echo "🐍 Creating virtual environment..."
	@python3 -m venv .venv
	@echo "✅ Virtual environment created!"

activate-venv:
	@echo "🔄 Activating virtual environment..."
	@$(ACTIVATE_CMD)
	@echo "✅ Virtual environment activated!"

install-requirements: create-venv
	@echo "📦 Installing dependencies from requirements.txt..."
	@.venv/bin/pip install --upgrade pip
	@.venv/bin/pip install -r requirements.txt
	@echo "✅ Dependencies installed!"

delete-logs:
	@if [ -d "$(LOG_DIR)" ]; then \
		echo "🗑️  Removing existing logs directory..."; \
		rm -rf $(LOG_DIR); \
	else \
		echo "✅ No existing logs folder found."; \
	fi

clean-pycache:
	@echo "🗑️  Removing all __pycache__ directories..."
	@find . -type d -name "__pycache__" -exec rm -rf {} +
	@echo "✅ All __pycache__ folders removed!"

create-logs: delete-logs
	@echo "📂 Creating logs directory..."
	@mkdir -p $(LOG_DIR)
	@echo "✅ Logs directory created!"

setup: install-requirements create-logs
	@echo "🚀 Project setup complete!"

clean: clean-pycache
	@echo "🗑️  Cleaning up project..."
	@rm -rf .venv $(LOG_DIR)
	@rm -rf .venv $(RUFF_CACHE_DIR)
	@echo "✅ Cleanup complete!"
