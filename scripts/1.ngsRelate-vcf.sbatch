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

module load htslib

NGSRELATE="/projects/foxhol@colostate.edu/ngsRelate"

#-n = numindv, -z =  your ind file with sample names, -T = PT or GT for phenotype or genotype likelihoods, -p = threads
$NGSRELATE/ngsRelate -h pass-maf-0.05.vcf.gz -n 239 -O pass-maf-0.05-vcf.res -T GT -p 10 -z inds

#-c 1
