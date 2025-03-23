# HOMEWORK 9 - BMMB852 

Setting Variables
```bash
GENOME_URL = GCF_000146045.2 
GENOME_FASTA = SC_R64.fa
R1 = HW_6/read/SRR7851676_1.fastq
R2 = HW_6/read/SRR7851676_2.fastq
SAM = aligned_reads.sam
BAM = aligned_reads.bam
```
Makefile settings
```bash
SHELL = bash
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
.PHONY: usage all genome simulate stats quality_control clean reads
```

Default target
```bash
all: genome index align_SRA filter alignment_stats 
```
Print the help message
```bash
usage:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  genome           - Download the genome"
	@echo "  index            - Index the reference genome"
	@echo "  align_SRA            - Align and sort the SRA reads into a bam file"
	@echo "  alignment_stats     -Generate stats for the alignment files"
	@echo "  filter              - Filtering the BAM file"
```

Download the refrence genome 
```bash
genome:
	@echo "Downloading genome in FASTA format..."
	bio fetch $(GENOME_URL) -format fasta > reads
	@echo "Genome downloaded and saved as 'reads'."
```

Index the genome 
```bash
index: genome
	@echo "Indexing SC genome"
	bwa index $(GENOME_FASTA) 
```

Align the SRA reads
```bash
align_SRA: index 
	@echo "Aligning the reads and sorting them into a BAM file"
	bwa mem $(GENOME_FASTA) $(R1) $(R2) > $(SAM)
	cat $(SAM) | samtools sort > $(BAM)
	samtools index $(BAM)
```

Filter BAM file
```bash
filter: 
	@echo "Filtering the BAM file"
	samtools view -b -f 2 -F 256 -F 2048 -q 10 $(BAM) > filtered.bam
```

Alignment stats
```bash
alignment_stats: index align_SRA
	samtools flagstats aligned_reads.bam
	samtools flagstats filtered.bam
```

### Questions

1.How many reads did not align with the reference genome?
```bash
samtools view -c -f 4 aligned_reads.bam
```
Answer-5289

2.How many primary, secondary, and supplementary alignments are in the BAM file?
```bash
samtools view -c -f 1 -f 2 -F 256 -F 2048 aligned_reads.bam  
```
Answer-13900 

```bash
samtools view -c -f 256 aligned_reads.bam
```
Answer-0

```bash
samtools view -c -f 2048 aligned_reads.bam
```
Answer-17


3.How many properly paired alignments on the reverse strand 
are formed by reads contained in the first pair (read1) file?
```bash
samtools view -c -f 2 -f 16 -f 64 aligned_reads.bam
```
Answer-3524

4.Make a new BAM file that contains only the
properly paired primary alignments with a mapping quality of over 10.
```bash
samtools view -b -f 2 -F 256 -F 2048 -q 10 aligned_reads.bam > filtered.bam
```
5.Compare the flagstats for your original and your filtered BAM file.

```bash
samtools flagstats aligned_reads.bam
samtools flagstats filtered.bam
```

#Filtered.bam
13112 + 0 in total (QC-passed reads + QC-failed reads)
13112 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
13112 + 0 mapped (100.00% : N/A)
13112 + 0 primary mapped (100.00% : N/A)
13112 + 0 paired in sequencing
6559 + 0 read1
6553 + 0 read2
13112 + 0 properly paired (100.00% : N/A)
13112 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)

#aligned_reads.bam
20017 + 0 in total (QC-passed reads + QC-failed reads)
20000 + 0 primary
0 + 0 secondary
17 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
14728 + 0 mapped (73.58% : N/A)
14711 + 0 primary mapped (73.55% : N/A)
20000 + 0 paired in sequencing
10000 + 0 read1
10000 + 0 read2
13900 + 0 properly paired (69.50% : N/A)
14354 + 0 with itself and mate mapped
357 + 0 singletons (1.79% : N/A)
394 + 0 with mate mapped to a different chr
330 + 0 with mate mapped to a different chr (mapQ>=5)

### Comment 
The filtered BAM file contains only high-quality reads, as improperly paired alignments and those with a mapping quality of 10 or lower were removed.All remaining reads are both properly paired and primary alignments. Filtering removed all the  singletons and chimeric reads, which were present in the original file (357 and 394, respectively). because of this mapped reads increase from 73.58% in the original dataset to 100% in the filtered bam file, unmapped reads were discarded. Filter bam file is higher quality alignment reads. 