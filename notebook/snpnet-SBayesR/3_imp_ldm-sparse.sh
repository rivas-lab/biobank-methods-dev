#!/bin/bash
set -beEuo pipefail

ml load gctb/2.0.standard

batch_idx=${SLURM_ARRAY_TASK_ID:=1}
if [ $# -gt 0 ] ; then batch_idx=$1 ; fi
n_batch=1000

# bfile="/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/bfile/ukb24983_cal_hla_cnv_imp_train_val"
bfile="/scratch/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR-v2/bfile/ukb24983_cal_hla_cnv_imp_train_val"

pvar_n_vars=$(zstdcat ${bfile}.bim | egrep -v '^#' | wc -l)
batch_size=$(perl -e "print(  int((${pvar_n_vars}-1)/${n_batch}) + 1  )")
idx_s=$(perl -e "print(  ${batch_size} *  (${batch_idx} - 1) + 1  )")
idx_e=$(perl -e "print(  ${batch_size} *   ${batch_idx} )")

if [ "${batch_idx}" == "${n_batch}" ] ; then
    idx_e="${pvar_n_vars}"
fi

############

gctb \
--bfile ${bfile} \
--make-sparse-ldm \
--snp "${idx_s}-${idx_e}" \
--out /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR/ldm_train_val/ukb24983_cal_hla_cnv_imp_train_val
