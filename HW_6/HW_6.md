# Homework Assignment 6

## Setting Directory
```bash
pwd
mkdir HW_6
cd HW_6 
conda activate bioinfo
```

## Download SRA details for a Saccharomycese cerevisiae illumina sequencing project from ncbi
```bash
bio search PRJNA396809
```

## Randomly choose different SRR numbers to try the following steps

## 1)Download 10000 read pairs with fastq-dump into the reads directory
```bash
fastq-dump -X 10000 -F --outdir read --split-files SRR7851676
cd read
ls
```

## 2)Get the quality control report
```bash
fastqc SRR7851676_1.fastq 
fastqc SRR7851676_2.fastq
```
```
After checking different SRR numbers fastqc reports I found SRR7851676 to be of bad enough quality to work on. According to the QC report the parameters 
Per base sequence content and per sequence GC content failed the qc.
```
```
Since the report showed that the per base sequence quality for tail sequence reads were lower so I cut the tail 
```
```bash
fastp --cut_tail -i SRR7851676_1.fastq -I SRR7851676_2.fastq -o SRR7851676_1.trim.fastq -O SRR7851676_2.trim.fastq 
```
# Quality check
```bash 
fastqc SRR7851676_1.trim.fastq 
fastqc SRR7851676_2.trim.fastq
```

``` 
After cutting the tail I trimmed the front 9 bases as they showed the most variation in the per base sequence content
```

```bash
fastp -i SRR7851676_1.trim.fastq -I SRR7851676_2.trim.fastq \
      -o SRR7851676_1.trim.front.fastq -O SRR7851676_2.trim.front.fastq \
      --trim_front1 9 --trim_front2 9
```
## Revaluate    
```bash
fastqc SRR7851676_1.trim.front.fastq  
fastqc SRR7851676_2.trim.front.fastq
```

## I Also tried filtering to fix the per sequence GC content but it did not work

## Comments
```
After triming the 9 nucelotides in the front the per base sequence content was fixed but per GC content was still an issue and an additional flag was the sequence length distribution which could not be improved on my end. The GC content for Saccharomyeces cerevoisae is 38% but in the improved reads its at 31%.
localized variability in GC comntent is common and might not have an affected on downstream analysis and biological conclusions. 
```




      


