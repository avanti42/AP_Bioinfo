
# Define environment and scripts
ENV = stats
SIMULATE_SCRIPT = src/r/simulate_counts.r
EDGER_SCRIPT = src/r/edger.r
COUNT_FILE = counts.csv
DESIGN_FILE = design.csv
TOUCH_FILE = code.r
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all simulate_counts edger touch_file


# Default target
all: simulate_counts edger touch_file

# Activate conda environment and simulate counts
simulate_counts:
	conda activate $(ENV) && Rscript $(SIMULATE_SCRIPT)

# Run edgeR analysis
edger:
	conda activate $(ENV) && Rscript $(EDGER_SCRIPT) -c $(COUNT_FILE) -d $(DESIGN_FILE)

# Touch code.r file
touch_file:
	touch $(TOUCH_FILE)



