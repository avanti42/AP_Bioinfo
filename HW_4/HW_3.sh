#HOMEWORK 3 BBMB 892

#Make directory and activate bioinfo environment
mkdir HW_3
cd HW_3
conda activate bioinfo

#Explore datasets command
datasets
datasets summary
datasets summary genome

#set variables                                                  
accession="GCF_000146045.2"
genomic="ncbi_dataset/data/${accession}/genomic.gff"
gene="ncbi_dataset/data/${accession}/gene.gff"
CDS="ncbi_dataset/data/${accession}/cds.gff"

#Read Download the Saccharomyces cerevisae genome from ncbi
datasets summary genome accession $accession | jq
datasets download genome accession $accession | jq
ls

#unzip the genome file 
unzip ncbi_dataset.zip             
fasta_file="ncbi_dataset/data/${accession}/${accession}_R64_genomic.fna"

#Check what is inside the fasta file
cat "$fasta_file" | head

#download fasta files that include gff3, cds, protein, rna and genome information respectively
datasets download genome accession "$accession" --include gff3,cds,protein,rna,genome


#unzip the files
unzip ncbi_dataset
# seperate features get an overview of the genomic file
cat $genomic | head 

# seperate gene feature into individual file
cat ${genomic} | awk '$3=="gene" {print $0 }'> $gene
 
# seperate coding sequence (CDS) into individual file
cat ${genomic} | awk '$3=="CDS" {print $0 }'> $CDS
 
#create a demo gff file
code demo.gff