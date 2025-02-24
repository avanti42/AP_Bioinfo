# HOMEWORK 3 BBMB 852
``` bash
mkdir HW_3
cd HW_3
conda activate bioinfo
```

```bash
datasets
datasets summary
datasets summary genome
```

### Download the Saccharomyces cerevisae genome from ncbi
``` bash

datasets summary genome accession GCF_000146045.2 | jq

 
datasets download genome accession GCF_000146045.2 | jq
ls
ncbi_dataset.zip
 
unzip ncbi_dataset.zip             
 
cat ncbi_dataset/data/GCF_000146045.2/GCF_000146045.2_R64_genomic.fna | head

datasets download genome accession GCF_000146045.2 --include gff3,cds,protein,rna,genome

 
unzip ncbi_dataset.zip
            
replace ncbi_dataset/data/assembly_data_report.jsonl? [y]es, [n]o, [A]ll, [N]one, [r]ename: A
```bash

cat  ncbi_dataset/data/GCF_000146045.2/genomic.gff
```

### Separating features "gene" and "CDS" into individual gff files.

```bash
cat ncbi_dataset/data/GCF_000146045.2/genomic.gff | awk '$3=="gene" {print $0 }'>ncbi_dataset/data/GCF_000146045.2/gene.gff
 
cat ncbi_dataset/data/GCF_000146045.2/genomic.gff | awk '$3=="CDS" {print $0 }'>ncbi_dataset/data/GCF_000146045.2/cds.gff
```
### Findings
I picked the gene HOP1 on chromosome NC_001141.2. The cds and gene sequence match and the sequence is well annonated. The coding sequences starts with a start codon and end with a stop codon. 

### Generate a simple gff file
```bash
code demo.gff
```
