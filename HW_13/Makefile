# Genome and annotation file paths
GENOME_URL = GCF_000146045.2
GENOME_FASTA = ncbi_dataset/data/$(GENOME_URL)/$(GENOME_URL)_R64_genomic.fna
GENOME_GFF = ncbi_dataset/data/$(GENOME_URL)/genomic.gff 

# Define SRR IDs
SRRS = SRR18902924 SRR18902915 SRR18903046 

# Directories
HW_DIR = HW_13
READS_DIR = $(HW_DIR)/reads
COUNTS_DIR = $(HW_DIR)/counts
GENOME_INDEX = $(HW_DIR)/genome_index

# Parameters
FASTQ_LIMIT = 10000
THREADS = 4
DESIGN_FILE = design.csv
COUNT_MATRIX = count_matrix.csv

# Default shell and flags
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: all setup genome reads index align count clean

# Default target
all: setup genome reads index align count

# Setup directories
setup:
	mkdir -p $(HW_DIR) $(READS_DIR) $(COUNTS_DIR)

# Download genome
genome: setup
	@echo "Downloading genome and annotation files..."
	datasets download genome accession $(GENOME_URL) --include genome,gff3 --filename $(HW_DIR)/ncbi_dataset.zip
	unzip -n $(HW_DIR)/ncbi_dataset.zip
	@echo "Genome and annotation files downloaded."

# Download reads for each SRR ID
reads: $(SRRS)
$(SRRS):
	@echo "Downloading reads for $@..."
	fastq-dump -X $(FASTQ_LIMIT) -F --outdir $(READS_DIR) --split-files $@

# Index the genome 
index: 
	@echo "Indexing SC genome using HISAT2"
	hisat2-build $(GENOME_FASTA) $(GENOME_INDEX)

# Align reads for each SRR ID
align: $(patsubst %, align_%, $(SRRS))
align_%:
	@echo "Aligning RNA-Seq reads for $* with HISAT2"
	hisat2 -p $(THREADS) --dta -x $(GENOME_INDEX) \
		-1 $(READS_DIR)/$*_1.fastq -2 $(READS_DIR)/$*_2.fastq \
		-S $(HW_DIR)/$*.sam
	# Convert SAM to BAM, sort, and index
	samtools view -Sb $(HW_DIR)/$*.sam | samtools sort -o $(HW_DIR)/$*.bam
	samtools index $(HW_DIR)/$*.bam

# Generate count matrix for all aligned BAM files
count: $(patsubst %, count_%, $(SRRS))
count_%:
	@echo "Counting reads for $*..."
	featureCounts -a $(GENOME_GFF) -o $(COUNTS_DIR)/counts_$*.txt -p -t gene -g ID $(HW_DIR)/$*.bam

