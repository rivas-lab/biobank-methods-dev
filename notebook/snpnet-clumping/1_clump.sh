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

GBE_ID=$1
clump_p1=$2
split_str=$3

ml load plink/1.90b6.17 plink2/20200725

# We installed PLINK1.9/2 software as software modules in our HPC system.
# This `ml load plink/1.90b6.17 plink2/20200725` updates the PATHs

data_d_root="/oak/stanford/groups/mrivas/projects/biobank-methods-dev"
data_d="${data_d_root}/$(basename ${SRCDIR})"
bfile='/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'
clump_in_sumstats=$(ls ${data_d_root}/snpnet-PRScs/sumstats_${split_str}/${GBE_ID}.*glm.*)
out_prefix="${data_d}/${split_str}/${GBE_ID}.p1_${clump_p1}"

# run plink

if   [ ${split_str} == "train_val" ] ; then

    cat ${data_d_root}/snpnet-elastic-net/phenotype.phe \
    | awk '($15 == "train" || $15 == "val"){print $1, $2}'

elif [ ${split_str} == "train" ] ; then

    cat ${data_d_root}/snpnet-elastic-net/phenotype.phe \
    | awk '($15 == "train"){print $1, $2}'

fi | plink \
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

exit 0

for GBE_ID in INI50 INI21001 HC269 HC382 ; do for p1 in 1e-5 1e-4 1e-3 ; do bash 1_clump.sh $GBE_ID $p1 train ; done ; done
for GBE_ID in INI50 INI21001 HC269 HC382 ; do for p1 in 1e-5 1e-4 1e-3 ; do bash 1_clump.sh $GBE_ID $p1 train_val ; done ; done
