# Variables
GENOME_URL = GCF_000146045.2 
GENOME_FASTA = SC_R64.fa
R1 = HW_6/read/SRR7851676_1.fastq
R2 = HW_6/read/SRR7851676_2.fastq
SAM = aligned_reads.sam
BAM = aligned_reads.bam


SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all genome simulate stats quality_control clean reads

# Default target
all: genome index align_SRA filter alignment_stats 

# Print the help message
usage:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  genome           - Download the genome"
	@echo "  index            - Index the reference genome"
	@echo "  align_SRA            - Align and sort the SRA reads into a bam file"
	@echo "  alignment_stats     -Generate stats for the alignment files"
	@echo "  filter              - Filtering the BAM file"
# Create directories and download genome
# Genome processing
genome:
	@echo "Downloading genome in FASTA format..."
	bio fetch $(GENOME_URL) -format fasta > reads
	@echo "Genome downloaded and saved as 'reads'."

# Index the genome 
index: genome
	@echo "Indexing SC genome"
	bwa index $(GENOME_FASTA) 

# Align the SRA reads
align_SRA: index 
	@echo "Aligning the reads and sorting them into a BAM file"
	bwa mem $(GENOME_FASTA) $(R1) $(R2) > $(SAM)
	cat $(SAM) | samtools sort > $(BAM)
	samtools index $(BAM)

# Filter BAM file
filter: 
	@echo "Filtering the BAM file"
	samtools view -b -f 2 -F 256 -F 2048 -q 10 $(BAM) > filtered.bam

# Alignment stats
alignment_stats: index align_SRA
	samtools flagstats aligned_reads.bam
	samtools flagstats filtered.bam


