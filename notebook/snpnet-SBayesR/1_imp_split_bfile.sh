#!/bin/bash
set -beEuo pipefail

ml load plink2/20200725

pfile="/scratch/groups/mrivas/ukbb24983/array_imp_combined/pgen_v2/ukb24983_cal_hla_cnv_imp"

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train" || $15 == "val"){print $1, $2}' \
| plink2 \
--memory 60000 --threads 6 \
--keep /dev/stdin \
--maf 0.001 --geno 0.1 \
--pfile ${pfile} vzs \
--make-bed \
--out /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/bfile/$(basename ${pfile})_train_val
