pwd
mkdir HW_6
cd HW_6 
conda activate bioinfo

bio search PRJNA396809


# Download 10000 read pairs with fastq-dump into the reads directory
fastq-dump -X 10000 -F --outdir read --split-files SRR7851676
cd read
ls


#Quality control
fastqc SRR7851676_1.fastq 
fastqc SRR7851676_2.fastq


fastp --cut_tail -i SRR7851676_1.fastq -I SRR7851676_2.fastq -o SRR7851676_1.trim.fastq -O SRR7851676_2.trim.fastq 
fastqc SRR7851676_1.trim.fastq 
fastqc SRR7851676_2.trim.fastq

fastp -i SRR7851676_1.trim.fastq -I SRR7851676_2.trim.fastq \
      -o SRR7851676_1.trim.front.fastq -O SRR7851676_2.trim.front.fastq \
      --trim_front1 9 --trim_front2 9

#Revaluate    
fastqc SRR7851676_1.trim.front.fastq  
fastqc SRR7851676_2.trim.front.fastq

#Also Tried
fastp -i SRR7851676_1.trim.front.fastq -I SRR7851676_2.trim.front.fastq \
      -o SRR7851676_1.trim.front.GC.fastq -O SRR7851676_2.trim.front.GC.fastq \
      --low_complexity_filter


      


