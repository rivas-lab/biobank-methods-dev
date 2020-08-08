#!/bin/bash
set -beEuo pipefail

GBE_ID=$1
clump_p1=$2

ml load plink/1.90b6.17 plink2/20200725

# We installed PLINK1.9/2 software as software modules in our HPC system.
# This `ml load plink/1.90b6.17 plink2/20200725` updates the PATHs

clump_in_sumstats=$(ls /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-PRScs/sumstats_train_val/${GBE_ID}.*glm.*)
bfile='/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'
data_d="/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-clumping"
out_prefix="${data_d}/${GBE_ID}.p1_${clump_p1}"

# run plink

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train" || $15 == "val"){print $1, $2}' \
| plink \
--memory 60000 --threads 6 \
--maf 0.001 --geno 0.1 \
--keep /dev/stdin \
--bfile ${bfile} \
--clump-snp-field ID \
--clump ${clump_in_sumstats} \
--clump-p1 ${clump_p1} \
--out ${out_prefix}

mv ${out_prefix}.log ${out_prefix}.clumped.log
bgzip ${out_prefix}.clumped
