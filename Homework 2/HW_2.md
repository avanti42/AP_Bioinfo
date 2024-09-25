# BMMB852 Homework 2 Markdown file
```bash
mkdir HW_2
cd HW_2
```
Downloading the GFF3 file
```bash
wget https://ftp.ensembl.org/pub/current_gff3/homo_sapiens/Homo_sapiens.GRCh38.112.gff3.gz
```
Unzipping the file
```bash
gunzip Homo_sapiens.GRCh38.112.gff3.gz
```
How many feature types
```bash
grep -v '^#' Homo_sapiens.GRCh38.112.gff3 | wc -l
```
Unique sequence regions
```bash
 grep -v '^#' Homo_sapiens.GRCh38.112.gff3 | awk '{print $1}' | sort | uniq | wc -l
 ```
 Unique sequence regions with more filters
 ```bash
 grep -v '^#' Homo_sapiens.GRCh38.112.gff3 | awk '{print $1}' | grep -v 'scaffold\|contig' | sort | uniq | wc -l
 ```
Number of genes
 ```bash
 grep -v '^#' Homo_sapiens.GRCh38.112.gff3 | awk '$3 == "gene"' | wc -l
 ```
 Top 10 annonated features
 ```bash
grep -v '^#' Homo_sapiens.GRCh38.112.gff3 | awk '{print $3}' | sort | uniq -c | sort -nr | head -n 10
```
Print the following
```
1. Homo sapiens ( Human) are highly complex organisms with a genome containing approximately 3.2 billion base pairs. The human genome is widely researched in genomics, with several versions being thoroughly annotated.
2. Number of features -3456533
3. Unique sequence regions - 194
4. Number of genes - 21571
5. Top 10 annotated feature types - 
 1. exon
 2. CDS
 3. three_prime_UTR
 4. biological_region
 5. five_prime_UTR
 6. mRNA
 7. lnc_RNA
 8. transcript
 9. ncRNA_gene
 10.  gene
```

Observations
```
The File includes essential feature types like exon, gene, etc so it looks fairly comprehensive. One thing I noted was that I was getting 194 for chromosomes which doesn't seem right so I used more filters to remove unique sequence regions that are non chromosomal entities like scaffold names or contig and any non-chromosomal patterns but that did not change the output. Hence, I am not sure about the code/ specific annotation to use in this case.
```