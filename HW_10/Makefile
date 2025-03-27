# Variables
GENOME_URL = GCF_000146045.2 
GENOME_FASTA = SC_R64.fa
R1 = HW_6/read/SRR7851676_1.fastq
R2 = HW_6/read/SRR7851676_2.fastq
SAM = aligned_reads.sam
BAM = aligned_reads.bam
ALIGNED_READS = aligned_reads
R1_TRIM = HW_6/read/SRR7851676_1.trim.fastq
R2_TRIM = HW_6/read/SRR7851676_2.trim.fastq
R1_TRIM_FRONT = HW_6/read/SRR7851676_1.trim.front.fastq
R2_TRIM_FRONT = HW_6/read/SRR7851676_2.trim.front.fastq
FASTQ_DUMP = SRR7851676
FASTQ_LIMIT = 10000
THREADS = 4
VCF = $(HW6_DIR)/variants/$(FASTQ_DUMP).vcf.gz

SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all genome simulate stats quality_control clean reads

# Default target
all: genome quality_control reads index align_SRA vcf

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
	@echo "  align_SRA            - Align and sort the SRA reads into a bam file"
	@echo "  align_simulated     -Align and sort simulated reads into a bam file"
	@echo "  alignment_stats     -Generate stats for the alignment files"

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

# Quality control for downloaded reads
reads: setup
	@echo "Downloading $(FASTQ_LIMIT) read pairs with fastq-dump..."
	fastq-dump -X $(FASTQ_LIMIT) -F --outdir $(READS_DIR) --split-files $(FASTQ_DUMP)


# Index the genome 
index: genome
	@echo "Indexing SC genome"
	bwa index $(GENOME_FASTA) 

# Align the SRA reads
align_SRA: index reads
	@echo "Aligning the reads and sorting them into a BAM file"
	bwa mem $(GENOME_FASTA) $(R1) $(R2) > $(SAM)
	cat $(SAM) | samtools sort > $(BAM)
	samtools index $(BAM)

# Filter BAM file
filter: align_SRA
	@echo "Filtering the BAM file"
	samtools view -b -f 2 -F 256 -F 2048 -q 10 $(BAM) > filtered.bam

# Generate VCF
vcf:
	make -f src/run/bcftools.mk REF=$(GENOME_FASTA) BAM=$(BAM) VCF=$(VCF) run


