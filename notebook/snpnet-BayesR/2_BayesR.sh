#!/bin/bash
set -beEuo pipefail

GBE_ID=$1

ml load gctb/2.02.standard

# We installed GCTB (a tool for Genome-wide Complex Trait Bayesian analysis) software as a software module in our HPC system.
# This `ml load gctb/2.02.standard` updates the PATHs so that we can execute gctb software.

data_d="/oak/stanford/groups/mrivas/projects/biobank-methods-dev"
out_d="${data_d}/snpnet-BayesR/BayesR"

if [ ! -d ${out_d} ] ; then mkdir -p ${out_d} ; fi

gctb \
--bayes R \
--bfile "${data_d}/snpnet-BayesR/bfile/ukb24983_cal_cALL_v2_hg19_train_val" \
--pheno ${data_d}/snpnet-elastic-net/${GBE_ID}.phe \
--pi 0.95,0.02,0.02,0.01 \
--gamma 0.0,0.01,0.1,1 \
--chain-length 25000 \
--burn-in 5000 \
--out-freq 100 \
--out ${out_d}/${GBE_ID} 2>&1 | tee ${out_d}/${GBE_ID}.gctb.log 

