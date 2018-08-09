#!/bin/bash

#SBATCH --job-name=sample10k
#SBATCH   --output=sample10k.%j.out
#SBATCH    --error=sample10k.%j.err
#SBATCH --time=1:00:00
#SBATCH --qos=normal
#SBATCH -p normal,mrivas,owners
#SBATCH --nodes=1
#SBATCH --cores=4
#SBATCH --mem=64000
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=yk.tanigawa@gmail.com

set -beEuo pipefail

# We defined 10k samples to keep in sample_train_10k.ipynb
# This script create bed/bim/fam triple based on that definition.

repo_dir=$(dirname $(dirname $(pwd)))
data_dir="$repo_dir/private_data/$(basename $(pwd))"

plink2 \
--threads 4 \
--memory 64000 \
--bfile ${data_dir}/train \
--keep ${data_dir}/train_10k.fam \
--out ${data_dir}/train_10k \
--make-bed
 
