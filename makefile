# Define build directory, executable, and module
BUILD_DIR = build
EXECUTABLE = optiCore
PYTHON_MODULE_DIR = $(BUILD_DIR)/lib
PYTHON_MODULE = optiCore_py

# Phony targets
.PHONY: all clean test run build-run refresh docs

# Build the project using CMake
all:
	@cmake -B$(BUILD_DIR) && cmake --build $(BUILD_DIR)

# Clean the build directory and generated files
clean:
	@rm -rf $(BUILD_DIR) compile_commands.json .cache .hypothesis .pytest_cache tests/__pycache__ 
	@echo "Cleaned build and cache directories."

# Build and run tests using CMake's run_tests target
test: all
	@$(MAKE) add_pythonpath
	@cmake --build $(BUILD_DIR) --target run_tests

test-full: clean all
	@$(MAKE) add_pythonpath
	@cmake --build $(BUILD_DIR) --target run_tests

# Build the project and run the executable
build-run: all
	@./$(BUILD_DIR)/bin/$(EXECUTABLE)

# Run the previously built executable
run:
	@./$(BUILD_DIR)/bin/$(EXECUTABLE)

# Refresh CMake to discover new or deleted files
refresh:
	@rm -rf $(BUILD_DIR)
	@cmake -B$(BUILD_DIR)
	@cmake --build $(BUILD_DIR)
	@echo "CMake refreshed. Project reconfigured."

# Add PYTHONPATH if the Python module is not already in it
add_pythonpath:
	@if ! echo $$PYTHONPATH | grep -q "$(PYTHON_MODULE_DIR)"; then \
		export PYTHONPATH=$(PYTHON_MODULE_DIR):$$PYTHONPATH; \
		echo "Added $(PYTHON_MODULE_DIR) to PYTHONPATH"; \
	else \
		echo "$(PYTHON_MODULE_DIR) is already in PYTHONPATH"; \
	fi

docs:
	@./scripts/generate_docs.sh
	@echo "Documentation generated in docs/api"

docs-clean:
	rm -rf docs/api/html docs/api/latex
