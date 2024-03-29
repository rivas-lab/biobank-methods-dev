#!/bin/bash
set -beEuo pipefail

ml load plink2/20200409

for chr in $(seq 1 22) ; do

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train" || $15 == "val"){print $1, $2}' \
| plink2 \
--memory 60000 --threads 6 \
--keep /dev/stdin \
--chr ${chr} \
--maf 0.001 --geno 0.1 \
--pfile /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19 vzs \
--make-bed \
--out /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/bfile/ukb24983_cal_c${chr}_v2_hg19_train_val

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train"){print $1, $2}' \
| plink2 \
--memory 60000 --threads 6 \
--keep /dev/stdin \
--chr ${chr} \
--maf 0.001 --geno 0.1 \
--pfile /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19 vzs \
--make-bed \
--out /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/bfile/ukb24983_cal_c${chr}_v2_hg19_train

done
