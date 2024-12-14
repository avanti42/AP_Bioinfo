# Variables
GENOME_URL = GCF_000146045.2 
GENOME_FASTA = SC_R64.fa
R1 = HW_6/read/SRR7851676_1.fastq
R2 = HW_6/read/SRR7851676_2.fastq
R1_TRIM = HW_6/read/SRR7851676_1.trim.fastq
R2_TRIM = HW_6/read/SRR7851676_2.trim.fastq
R1_TRIM_FRONT = HW_6/read/SRR7851676_1.trim.front.fastq
R2_TRIM_FRONT = HW_6/read/SRR7851676_2.trim.front.fastq
FASTQ_DUMP = SRR7851676
FASTQ_LIMIT = 10000
THREADS = 4

SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all genome simulate stats quality_control clean reads

# Default target
all: genome simulate quality_control stats

# Print the help message
usage:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  genome           - Download the genome"
	@echo "  simulate         - Simulate reads for the genome"
	@echo "  quality_control  - Perform quality control and trimming on downloaded reads"
	@echo "  stats            - Generate stats for simulated reads"
	@echo "  clean            - Clean up intermediate files"



# Create directories and download genome
HW_DIR = HW_5
Lec_DIR = $(HW_DIR)/Lec_06
HW6_DIR = HW_6
READS_DIR = $(HW6_DIR)/read
# Setup
setup:
	mkdir -p $(Lec_DIR) $(READS_DIR)

# Genome processing
genome: setup
	@echo "Downloading genome in FASTA format..."
	bio fetch $(GENOME_URL) -format fasta > $(Lec_DIR)/SC.fasta
	@echo "Genome downloaded."
	ln -sf $(Lec_DIR)/SC.fasta $(GENOME_FASTA)
	

# Simulate paired-end reads
simulate: genome setup
	@echo "Simulating reads (10x coverage)..."
	wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N 610000 $(GENOME_FASTA) $(READS_DIR)/read1.fq $(READS_DIR)/read2.fq



# Generate stats for simulated reads
stats:
	@echo "Generating stats for simulated reads..."
	seqkit stats $(READS_DIR)/read1.fq $(READS_DIR)/read2.fq

# Clean up intermediate files
clean:
	@echo "Cleaning up intermediate files..."
	rm -f $(READS_DIR)/*.fq $(READS_DIR)/*.fastq $(READS_DIR)/*.zip *.html

# Quality control for downloaded reads
reads: setup
	@echo "Downloading $(FASTQ_LIMIT) read pairs with fastq-dump..."
	fastq-dump -X $(FASTQ_LIMIT) -F --outdir $(READS_DIR) --split-files $(FASTQ_DUMP)

# Quality control steps including trimming
quality_control: reads
	@echo "Performing quality control with FastQC..."
	fastqc $(R1) $(R2) -t $(THREADS)  # FastQC on raw reads
	@echo "Trimming reads with Fastp..."
	fastp --cut_tail -i $(R1) -I $(R2) -o $(R1_TRIM) -O $(R2_TRIM) -w $(THREADS)
	fastqc $(R1_TRIM) $(R2_TRIM) -t $(THREADS)  # FastQC after trimming
	@echo "Front trimming reads with Fastp..."
	fastp -i $(R1_TRIM) -I $(R2_TRIM) -o $(R1_TRIM_FRONT) -O $(R2_TRIM_FRONT) --trim_front1 9 --trim_front2 9 -w $(THREADS)
	fastqc $(R1_TRIM_FRONT) $(R2_TRIM_FRONT) -t $(THREADS)  # FastQC after front trimming

	