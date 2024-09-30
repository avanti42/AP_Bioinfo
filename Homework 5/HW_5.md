# BMMB892 Homework 5-Simulating FASTQ files

### Make and set directory
```bash
mkdir HW_5
cd HW_5
mkdir Lec_06
cd Lec_06
conda activate bioinfo
```
## Question 1


### Download the fasta file
```bash
bio fetch GCF_000146045.2 -format fasta > SC.fasta
```

### Size of the file
```bash
du -sh SC.fasta
```

### Find total size of the genome
```bash
grep -v "^>" SC.fasta | wc | awk '{print $3 - $1}'
```
### Total number of chromosmes
```bash
grep -c "^>" SC.fasta
```
### The name(id) and length of each chromosome in the genome
```bash
samtools faidx SC.fasta
cut -f1,2 SC.fasta.fai
```

## Print the following report
```
1. Size of file- 12 Mb
2. Total size of genome-12071326
3.The number of chromosomes in the genome- 16
4. The name (id) and length of each chromosome in the genome -  
BK006935.2      230218
BK006936.2      813184
BK006937.2      316620
BK006938.2      1531933
BK006939.2      576874
BK006940.2      270161
BK006941.2      1090940
BK006934.2      562643
BK006942.2      439888
BK006943.2      745751
BK006944.2      666816
BK006945.2      1078177
BK006946.2      924431
BK006947.3      784333
BK006948.2      1091291
BK006949.2      948066
```
## Question 2

### NCBI datasets 
```bash
micromamba update ncbi-datasets-cli jq
```
### Download genome
```bash 
datasets download genome accession GCF_000146045.2
```
### Unzip file
```bash
unzip -o ncbi_dataset.zip
```
### Make a link to a simpler name
```bash 
ln -sf ncbi_dataset/data/GCF_000146045.2/GCF_000146045.2_R64_genomic.fna SC_R64.fa
```
### Simulate reads with wgsim
```
wgsim
 ```

### Remove error/ mutations etc
``` bash 
wgsim -e 0 -r 0 -R 0 -N 1000 SC_R64.fa read1.fq read2.fq
```
### Stats
```bash 
seqkit stats read1.fq read2.fq
```bash 
### For 1x coverage
```bash
wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N 25000 SC_R64.fa read1.fq read2.fq
```
### For 10x Coverage 
```bash 
wgsim -e 0 -r 0 -R 0 -1 100 -2 100 -N 610000 SC_R64.fa read1.fq read2.fq

seqkit stats read1.fq read2.fq
```
### File size 
``` bash
du -sh read1.fq read2.fq
```
### Compress files
```bash 
gzip read1.fq read2.fq
```
### list the file to see changes
```bash
ls
```
### File size in human readable form
```bash
du -sh read1.fq.gz read2.fq.gz
```
## Print the following report

```
1. Number of reads generated-  61,000,000 each read file, total 122 Million
2. Average read length- 100 bp
3. FASTQ file size- 146 Mb
4. Space saved- compressed to 28 , 118 Mb saved
```

## Question 3

## Print the following report

```
Estimate of the size of the FASTA file that holds the genome-
Yeast- 726 Mb
Drosophila- 8.22 Gb
Human-192 Gb
The number of FASTQ reads needed for 30x-
Yeast- 2.42 million
Drosophila- 27.4 million
Human- 640 million
The size of the FASTQ files before and after compression- 
Yeast- 726 Mb to 35.2 Mb
Drosophila- 8.22 Gb to 1.644 Gb
Human- 192 Gb 38.4 Gb
```

