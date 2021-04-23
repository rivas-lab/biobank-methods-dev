#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source ${SRCDIR}/parameters.sh

out_f=${data_d}/${RData_path%.RData}/GREAT_out/${ontology}.tsv.gz

{
    echo "#sample_ID ontology term_ID BPval BFold Bn Bk BProb" | tr ' ' '\t'
    echo ${samples_str} | tr ',' '\n' | while read pheno ; do
        bash GREAT_binom_viewer.sh \
            ${data_d}/${RData_path%.RData}/GREAT_out/${pheno} \
            ${ontology} ${pheno} \
            | egrep -v '^#'
    done 
} | bgzip -l9 -@6 > ${out_f}

echo ${out_f}

