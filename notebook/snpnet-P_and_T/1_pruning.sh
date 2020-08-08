#!/bin/bash
set -beEuo pipefail

ml load plink2/20200725

# We installed PLINK2 software as a software module in our HPC system.
# This `ml load plink2/20200725` updates the PATHs

data_d='/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-P_and_T'
# pfile='/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'
pfile='/scratch/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'

out_prefix="${data_d}/ukb24983_cal_cALL_v2_hg19_train_val"

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train" || $15 == "val"){print $1, $2}' \
| plink2 \
--memory 60000 --threads 10 \
--keep /dev/stdin \
--maf 0.001 --geno 0.1 \
--pfile ${pfile} vzs \
--indep-pairwise 50 5 .5 \
--out ${out_prefix}

mv ${out_prefix}.log ${out_prefix}.prune.log
