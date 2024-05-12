#!/bin/bash 
#
#all commands that start with SBATCH contain commands that are just used by SLURM for scheduling  
#################
#set a job name  
#SBATCH --job-name=ngsrel
#################  
#a file for job output, you can check job progress
#SBATCH --output=ngsrel.%j.out
#################
# a file for errors from the job
#SBATCH --error=ngsrel.%j.err
#################
#time you think you need; default is one hour
#in minutes in this case
#SBATCH -t 24:00:00
#################
#quality of service; think of it as job priority
#SBATCH -p amilan
#################
#number of nodes
#SBATCH --nodes=1
#SBATCH --ntasks-per-node 10
#################
#SBATCH --mem=37G
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
#conda activate bioinf

#module load jdk/18.0.1.1
#module load python/3.10.2
module load htslib

#FASTA="/scratch/alpine/foxhol@colostate.edu/LOSH/bash_scripts/resources/genomes/GCA_013397235.1_ASM1339723v1_genomic.fna"
#BAM1="/scratch/alpine/foxhol@colostate.edu/LOSH/raw_data/LOSH_Novoseq_Lane1_dateX/bwa_mem"
#COMMS="/scratch/alpine/foxhol@colostate.edu/LOSH/raw_data/LOSH_Novoseq_Lane1_dateX_bwa_mem/LOSH.4m.comm_lines.txt"
NGSRELATE="/projects/foxhol@colostate.edu/ngsRelate"

#-n = numindv, -z =  your ind file with sample names, -T = PT or GT for phenotype or genotype likelihoods, -p = threads
$NGSRELATE/ngsRelate -h pass-maf-0.05.vcf.gz -n 239 -O pass-maf-0.05-vcf.res -T GT -p 10 -z inds

#-c 1
