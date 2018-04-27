#!/bin/bash
set -beEuo pipefail

split_class=$1

repo_dir=$(dirname $(dirname $(pwd)))
data_dir="$repo_dir/private_data/$(basename $(pwd))"

bfile="/oak/stanford/groups/mrivas/private_data/ukbb/24983/cal/pgen/ukb24983_cal_cALL_v2"

plink2 \
--threads 4 \
--memory 32000 \
--bfile ${bfile} \
--keep ${data_dir}/${split_class}.fam \
--out ${data_dir}/${split_class} \
--make-bed 
