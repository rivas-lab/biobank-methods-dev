#!/bin/bash
set -beEuo pipefail

GBE_ID=$1

data_dir="/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/SBayesR-exclude-mhc"

betas="${data_dir}/${GBE_ID}.snpRes.plink.tsv"

ml load plink2/20200409

cat ${betas} \
| awk -v FS='\t' '(NR>1){print $3}' \
| plink2 --threads 6 --memory 40000 \
--pfile /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19 vzs \
--extract /dev/stdin \
--out ${data_dir}/${GBE_ID} \
--score ${betas} 3 5 6 header zs \
cols=maybefid,maybesid,phenos,dosagesum,scoreavgs,denom,scoresums
