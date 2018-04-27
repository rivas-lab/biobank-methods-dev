#!/bin/bash
set -beEuo pipefail

split_class=$1

repo_dir=$(dirname $(dirname $(pwd)))
data_dir="$repo_dir/private_data/$(basename $(pwd))"


plink2 \
--threads 4 \
--memory 32000 \
--bfile ${data_dir}/${split_class} \
--out ${data_dir}/${split_class} \
--make-pgen
