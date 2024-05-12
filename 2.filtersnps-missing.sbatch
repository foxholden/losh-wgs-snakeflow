#!/bin/bash
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling
#################
#set a job name
#SBATCH --job-name=snp-miss
#################
#a file for job output, you can check job progress
#SBATCH --output=snp-miss.%j.out
#################
# a file for errors from the job
#SBATCH --error=snp-miss.%j.err
#################
#time you think you need; default is one hour
#in minutes in this case
#SBATCH -t 8:00:00
#################
#quality of service; think of it as job priority
#SBATCH -p amilan
#################
#number of nodes
#SBATCH --nodes=1
#SBATCH --ntasks-per-node 3
#################
#SBATCH --mem=11G
#################
#get emailed about job BEGIN, END, and FAIL
#SBATCH --mail-type=END,FAIL
#################
#who to send email to; please change to your email
#SBATCH  --mail-user=foxhol@colostate.edu
#################
#now run normal batch commands
##################
#echo commands to stdout
set -x

source ~/.bashrc


FASTA="/scratch/alpine/foxhol@colostate.edu/LOSH/mega-non-model-wgs-snakeflow/resources/genome.fasta"

#unzip the vcf file
gunzip pass-maf-0.05.vcf.gz

module load gatk
#Select SNPs
gatk --java-options "-Xmx11g"  SelectVariants \
     -R $FASTA \
     -V pass-maf-0.05.vcf \
     -select-type SNP \
     --O pass-maf-0.05-SNP.vcf

conda activate bioinf
#VCFtools for filtering based on missingness, once you remove systematic errors. Play around with this to get the numbers you want and make sense
vcftools --vcf pass-maf-0.05-SNP.vcf --out pass-maf-0.05-SNP-8miss --max-missing 0.8 --recode
vcftools --vcf pass-maf-0.05-SNP.vcf --out pass-maf-0.05-SNP-5miss --max-missing 0.5 --recode