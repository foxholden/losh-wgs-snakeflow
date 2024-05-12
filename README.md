# Overview
Welcome to Holden's repository for processing Loggerhead Shrike (Lanius ludovicianus) Novoseq data and downstream population structure analysis :)

## Snakemake Pipeline
The snakemake pipeline is adapted from eriq's mega-non-model-wgs-snakeflow that has been tooled for specific use on BGP shrike data. Compare the two repositories right here: https://github.com/eriqande/mega-non-model-wgs-snakeflow/compare/main...foxholden:mega-non-model-wgs-snakeflow:LOSH-Apr-24

## Remove Related Individuals
Relatedness is measured using ngsRelate on Alpine using this [script](scripts/1.ngsRelate-vcf.sbatch)
## Filter SNPS and Missing Data
Post-vcf filtering is done with vcftools on Alpine using this [script](scripts/2.filtersnps-missing.sbatch)

## Population Structure
A genomic PCA is made using Plink v. 1.9
```
plink --vcf pass-maf-0.05-SNP-5miss.recode.vcf --out pass-maf-0.05-SNP-5miss --aec --pca 10 header tabs
```
The resulting .egienvec file can be read into R to create a PCA
