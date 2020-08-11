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
P_thr=$2
split_str=$3

############################################################
# modules
############################################################

ml load plink2/20200725 R/3.6 gcc

# We installed PLINK2 software as a software module in our HPC system.
# This `ml load plink2/20200725` updates the PATH

############################################################
# file paths
############################################################

data_d_root="/oak/stanford/groups/mrivas/projects/biobank-methods-dev"
data_d="${data_d_root}/$(basename ${SRCDIR})"
prune_f="${data_d}/ukb24983_cal_cALL_v2_hg19_${split_str}.prune.in"
pfile='/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19'
clump_in_sumstats=$(ls ${data_d_root}/snpnet-PRScs/sumstats_${split_str}/${GBE_ID}.*glm.*)
out_prefix="${data_d}/${split_str}/${GBE_ID}.P_${P_thr}"
betas="${out_prefix}.plink.tsv"

############################################################
# main
############################################################

# filter the full sumstats and keep the clumped variants

Rscript /dev/stdin ${clump_in_sumstats} ${prune_f} ${P_thr} ${betas} << EOF
suppressWarnings(suppressPackageStartupMessages({ library(tidyverse); library(data.table) }))

args <- commandArgs(trailingOnly=TRUE)

sumstats_f <- args[1]
prune_f    <- args[2]
P_thr      <- as.numeric( args[3] )
out_f      <- args[4]

prune_f %>% fread(header=F) %>% pull() -> ld_indep_SNPs

sumstats_f %>% fread(
    select=c('#CHROM', 'POS', 'ID', 'REF', 'A1', 'BETA', 'OR', 'P')
) %>%
rename('CHROM'='#CHROM') %>%
filter((as.numeric(P) < P_thr), ID %in% ld_indep_SNPs) -> df

if( ! 'BETA' %in% colnames(df) ){
    df <- df %>% mutate(BETA = log(OR))
}

df %>%
select(CHROM, POS, ID, REF, A1, BETA) %>%
rename('#CHROM' = 'CHROM') %>%
fwrite(out_f, sep='\t', na = "NA", quote=F)
EOF

# apply plink2's --score

cat ${betas} \
| awk -v FS='\t' '(NR>1){print $3}' \
| plink2 --threads 6 --memory 40000 \
--pfile ${pfile} vzs \
--extract /dev/stdin \
--out ${out_prefix} \
--score ${betas} 3 5 6 header zs \
cols=maybefid,maybesid,phenos,dosagesum,scoreavgs,denom,scoresums

mv ${out_prefix}.log ${out_prefix}.sscore.log

exit 0

for GBE_ID in INI50 INI21001 HC269 HC382 ; do for p1 in 1e-5 1e-4 1e-3 ; do bash 2_plink-score.sh $GBE_ID $p1 train ; done ; done
for GBE_ID in INI50 INI21001 HC269 HC382 ; do for p1 in 1e-5 1e-4 1e-3 ; do bash 2_plink-score.sh $GBE_ID $p1 train_val ; done ; done

