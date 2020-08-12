#!/bin/bash
set -beEuo pipefail

GBE_ID=$1

bash 7f_SBayesR-per-chr-merge-exclude-mhc.sh ${GBE_ID}
bash 8_beta_conv_one-file.sh SBayesR-chr_merge-exclude-mhc ${GBE_ID} 
bash 9c_plink_score_one-file.sh SBayesR-chr_merge-exclude-mhc ${GBE_ID}

