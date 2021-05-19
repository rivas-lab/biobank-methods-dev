#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

GREAT_res_dir=$1
ontology=$2
sample_ID=$3

echo "#sample_ID ontology term_ID BPval BFold Bn Bk BProb" | tr ' ' '\t'

cat ${GREAT_res_dir}/${ontology}.tsv | sed -e 's/# ID/term_ID/' \
| awk -v FS='\t' -v OFS='\t' -v sample_ID=${sample_ID} -v ontology=${ontology} \
'(NR>8){print sample_ID, ontology, $1, $5, $8, $10, $11, $12}'
