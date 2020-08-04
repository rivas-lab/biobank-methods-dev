#!/bin/bash
set -beEuo pipefail

ml load gctb/2.02.standard

# We installed GCTB (a tool for Genome-wide Complex Trait Bayesian analysis) software as a software module in our HPC system.
# This `ml load gctb/2.0.standard` updates the PATHs so that we can execute gctb software.

idx=${SLURM_ARRAY_TASK_ID:=1}

# idx=$1
tbl='3_ldm-sparse.batch.tsv'

batch_size=5000

out_d=/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR-v2/shrunk_ldm_train_val

chr=$(cat ${tbl} | awk 'NR>1' | awk -v idx=${idx} -v FS='\t' '($4 <= idx && idx <= $5){print $1}')
n_snps=$(cat ${tbl} | awk -v chr=${chr} -v FS='\t' '($1 == chr){print $2}')
chr_idx_s=$(cat ${tbl} | awk -v chr=${chr} -v FS='\t' '($1 == chr){print $4}')
chr_idx_e=$(cat ${tbl} | awk -v chr=${chr} -v FS='\t' '($1 == chr){print $5}')
chr_idx=$(perl -e "print(${idx} - ${chr_idx_s} + 1)")
snp_s=$(perl -e "print(${batch_size} * (${chr_idx} - 1) + 1)")
if [ "${idx}" == "${chr_idx_e}" ] ; then
    snp_e=${n_snps}
else
    snp_e=$(perl -e "print(${batch_size} * ${chr_idx})")
fi

echo "$chr ${snp_s}-${snp_e}"

if [ ! -d ${out_d} ] ; then mkdir -p ${out_d} ; fi

gctb \
--bfile /scratch/groups/mrivas/projects/biobank-methods-dev/snpnet-SBayesR-v1/bfile/ukb24983_cal_c${chr}_v2_hg19_train_val \
--make-shrunk-ldm \
--snp "${snp_s}-${snp_e}" \
--out ${out_d}/ukb24983_cal_chr${chr} 2>&1 \
| tee ${out_d}/ukb24983_cal_chr${chr}.snp${snp_s}-${snp_e}.gctb.ldm.shrunk.log
