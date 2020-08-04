#!/bin/bash
set -beEuo pipefail

ml load plink2/20200725

pfile="/scratch/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19"

out_d="/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-BayesR/bfile"

if [ ! -d ${out_d} ] ; then mkdir -p ${out_d} ; fi

cat /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe \
| awk '($15 == "train" || $15 == "val"){print $1, $2}' \
| plink2 \
--memory 60000 --threads 6 \
--keep /dev/stdin \
--maf 0.001 --geno 0.1 \
--pfile ${pfile} vzs \
--make-bed \
--out ${out_d}/$(basename ${pfile})_train_val
