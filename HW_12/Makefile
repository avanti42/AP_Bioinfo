
# Variables
GENOME_URL = GCF_000146045.2
GENOME_FASTA = SC_R64.fa
THREADS = 4
VCF_DIR = $(HW6_DIR)/variants
DESIGN_FILE = design.csv
HW6_DIR = $(PWD)/HW_6          # Set the path explicitly
READS_DIR = $(HW6_DIR)/read     # Set the path explicitly

SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all genome simulate stats quality_control clean reads index align_SRA vcf parallel_vcf merge_vcf

# Default target
all: genome quality_control reads index align_SRA parallel_vcf merge_vcf

# Print the help message
usage:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  genome           - Download the genome"
	@echo "  simulate         - Simulate reads for the genome"
	@echo "  quality_control  - Perform quality control and trimming on downloaded reads"
	@echo "  stats            - Generate stats for simulated reads"
	@echo "  clean            - Clean up intermediate files"
	@echo "  index            - Index the reference genome"
	@echo "  align_SRA        - Align and sort the SRA reads into a bam file"
	@echo "  parallel_vcf     - Run the VCF generation in parallel"
	@echo "  merge_vcf        - Merge all VCF files into a single file"

# Create directories and download genome
setup:
	mkdir -p $(HW6_DIR) $(READS_DIR)

# Genome processing
genome: setup
	@echo "Downloading genome in FASTA format..."
	bio fetch $(GENOME_URL) -format fasta > $(HW6_DIR)/SC.fasta
	@echo "Genome downloaded."
	ln -sf $(HW6_DIR)/SC.fasta $(GENOME_FASTA)

# Quality control for downloaded reads
reads: setup
	@echo "Downloading reads with fastq-dump..."
	fastq-dump -X 10000 -F --outdir $(READS_DIR) --split-files $(FASTQ_DUMP)

# Index the genome
index: genome
	@echo "Indexing genome"
	bwa index $(GENOME_FASTA)

# Align the SRA reads
align_SRA: index reads
	@echo "Aligning the reads and sorting into BAM file"
	bwa mem $(GENOME_FASTA) $(R1) $(R2) > $(SAM)
	cat $(SAM) | samtools sort > $(BAM)
	samtools index $(BAM)

# Generate VCF files for all samples in parallel
vcf: $(foreach sample, $(shell awk -F, 'NR>1 {print $$1}' $(DESIGN_FILE)), $(VCF_DIR)/$(sample).vcf.gz)

$(VCF_DIR)/$(sample).vcf.gz: $(READS_DIR)/$(sample)_1.fastq $(READS_DIR)/$(sample)_2.fastq
	@echo "Generating VCF for sample $(sample)..."
	make -f src/run/bcftools.mk REF=$(GENOME_FASTA) BAM=$(VCF_DIR)/$(sample).bam VCF=$@ run

# Parallel VCF generation
parallel_vcf:
	@echo "Running VCF generation for all samples in parallel..."
	cat $(DESIGN_FILE) | tail -n +2 | awk -F, '{print $$1}' | parallel -j $(THREADS) 'make vcf SAMPLE={}'

# Merge VCF files into one
merge_vcf:
	@echo "Merging VCF files..."
	bcftools merge $(VCF_DIR)/*.vcf.gz -O z -o $(VCF_DIR)/merged.vcf.gz
