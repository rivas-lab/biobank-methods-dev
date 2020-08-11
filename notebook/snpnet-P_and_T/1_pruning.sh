#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})
PROGNAME=$(basename $SRCNAME)
VERSION="0.0.1"
NUM_POS_ARGS="1"

############################################################
# args
############################################################

split_str=$1

ml load plink2/20200725

# We installed PLINK2 software as a software module in our HPC system.
# This `ml load plink2/20200725` updates the PATHs

data_d_root="/oak/stanford/groups/mrivas/projects/biobank-methods-dev"
data_d="${data_d_root}/$(basename ${SRCDIR})"
# pfile='/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'
pfile='/scratch/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'

out_prefix="${data_d}/ukb24983_cal_cALL_v2_hg19_${split_str}"

if   [ ${split_str} == "train_val" ] ; then

    cat ${data_d_root}/snpnet-elastic-net/phenotype.phe \
    | awk '($15 == "train" || $15 == "val"){print $1, $2}'

elif [ ${split_str} == "train" ] ; then

    cat ${data_d_root}/snpnet-elastic-net/phenotype.phe \
    | awk '($15 == "train"){print $1, $2}'

fi | plink2 \
--memory 60000 --threads 6 \
--keep /dev/stdin \
--maf 0.001 --geno 0.1 \
--pfile ${pfile} vzs \
--indep-pairwise 50 5 .5 \
--out ${out_prefix}

mv ${out_prefix}.log ${out_prefix}.prune.log
