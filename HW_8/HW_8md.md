# HOMEWORK 8 - BMMB852 

```bash
mkdir HW_8
cd HW_8
conda activate bioinfo
```
Set Variables
```
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

Set Default target
```bash
all: genome simulate quality_control stats clean reads index align_SRA align_simulated alignment_stats
```
Print the help message
```bash
usage:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  genome           - Download the genome"
	@echo "  simulate         - Simulate reads for the genome"
	@echo "  quality_control  - Perform quality control and trimming on downloaded reads"
	@echo "  stats            - Generate stats for simulated reads"
	@echo "  clean            - Clean up intermediate files"
```


Create directories and download genome
```bash
HW_DIR = HW_5
Lec_DIR = $(HW_DIR)/Lec_06
HW6_DIR = HW_6
READS_DIR = $(HW6_DIR)/read
# Setup
setup:
	mkdir -p $(Lec_DIR) $(READS_DIR)
```

Genome processing
```bash
genome: setup
	@echo "Downloading genome in FASTA format..."
	bio fetch $(GENOME_URL) -format fasta > $(Lec_DIR)/SC.fasta
	@echo "Genome downloaded."
	ln -sf $(Lec_DIR)/SC.fasta $(GENOME_FASTA)
```
	

Simulate paired-end reads
```bash
simulate: genome setup
	@echo "Simulating reads (10x coverage)..."
	wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N 610000 $(GENOME_FASTA) $(READS_DIR)/read1.fq $(READS_DIR)/read2.fq
```



Generate stats for simulated reads
```bash
stats:
	@echo "Generating stats for simulated reads..."
	seqkit stats $(READS_DIR)/read1.fq $(READS_DIR)/read2.fq
```

Clean up intermediate files
```bash
clean:
	@echo "Cleaning up intermediate files..."
	rm -f $(READS_DIR)/*.fq $(READS_DIR)/*.fastq $(READS_DIR)/*.zip *.html
```

Quality control for downloaded reads
```bash
reads: setup
	@echo "Downloading $(FASTQ_LIMIT) read pairs with fastq-dump..."
	fastq-dump -X $(FASTQ_LIMIT) -F --outdir $(READS_DIR) --split-files $(FASTQ_DUMP)
```

Quality control steps including trimming and cutting tail
```bash
quality_control: reads
	@echo "Performing quality control with FastQC..."
	fastqc $(R1) $(R2) -t $(THREADS)  # FastQC on raw reads
	@echo "Trimming reads with Fastp..."
	fastp --cut_tail -i $(R1) -I $(R2) -o $(R1_TRIM) -O $(R2_TRIM) -w $(THREADS)
	fastqc $(R1_TRIM) $(R2_TRIM) -t $(THREADS)  # FastQC after trimming
	@echo "Front trimming reads with Fastp..."
	fastp -i $(R1_TRIM) -I $(R2_TRIM) -o $(R1_TRIM_FRONT) -O $(R2_TRIM_FRONT) --trim_front1 9 --trim_front2 9 -w $(THREADS)
	fastqc $(R1_TRIM_FRONT) $(R2_TRIM_FRONT) -t $(THREADS)  # FastQC after front trimming
```

Index the genome 
```bash
index: genome
	@echo "Indexing SC genome"
	bwa index $(GENOME_FASTA) 
```

Align the SRA reads
```bash
align_SRA: index reads
	@echo "Aligning the reads and sorting them into a BAM file"
	bwa mem $(GENOME_FASTA) $(R1) $(R2) > $(SAM)
	cat $(SAM) | samtools sort > $(BAM)
	samtools index $(BAM)
```

Simulated reads
```bash
align_simulated: index simulate
	@echo "Aligning simulated reads and sorting into BAM file"
	bwa mem $(GENOME_FASTA) $(READS_DIR)/read1.fq $(READS_DIR)/read2.fq > simulated_reads.sam
	cat simulated_reads.sam | samtools sort > simulated_reads.bam
	samtools index simulated_reads.bam
```

Alignment stats
```bash
alignment_stats:align_simulated
	samtools flagstats aligned_reads.bam
	samtools flagstats simulated_reads.bam
```
### Comments
The simulated dataset, with 1.22 million reads generated at ~10x coverage, exhibits ideal behavior, with 100% mapping efficiency, no sequencing errors, and no unpaired reads. In contrast, the SRA dataset, with only 20,017 reads, shows real-world sequencing challenges, including 73.58% mapping efficiency, 69.5% properly paired reads, 17 supplementary reads, and 357 singletons, likely due to sequencing errors, adapters, contamination, and structural variations. Additionally, 394 SRA reads map to different chromosomes. 

