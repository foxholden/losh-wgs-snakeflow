# Overview
Welcome to Holden's repository for processing Loggerhead Shrike (Lanius ludovicianus) Novoseq data and downstream population structure analysis :)

## Snakemake Pipeline
The snakemake pipeline is adapted from eriq's mega-non-model-wgs-snakeflow that has been tooled for specific use on BGP shrike data. Compare the two repositories right here: https://github.com/eriqande/mega-non-model-wgs-snakeflow/compare/main...foxholden:mega-non-model-wgs-snakeflow:LOSH-Apr-24

## Remove Related Individuals

Convert bcf to vcf.
```
bcftools view pass-maf-0.05.bcf | bgzip > pass-maf-0.05.vcf.gz
```
Create an individual names file for ngsRelate.
```
bcftools view pass-0.05-maf.vcf.gz | grep "CHROM" | tr "\t" "\n" > inds
```
Make sure to remove the header in nano.

Relatedness is measured using ngsRelate on Alpine. Use this [script](scripts/1.ngsRelate-vcf.sbatch).

Read the output into R and sort J8 values from highest to lowest. Then remove one individual from pairs with J8 > 0.2.

## Filter SNPS and Missing Data
Post-vcf filtering is done with vcftools on Alpine using this [script](scripts/2.filtersnps-missing.sbatch).

## Population Structure
A genomic PCA is made using Plink v. 1.9. This commmand can be run on the login node or in acompile.
```
mamba activate bioinf
plink --vcf pass-maf-0.05-SNP-5miss.recode.vcf --out pass-maf-0.05-SNP-5miss --aec --pca 10 header tabs
```
The resulting .eigenvec file can be read into R to create a PCA.
