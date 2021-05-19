#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source parameters.sh

cd ${great_d}

echo "scp ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT_in_bed.tar.gz ."
scp ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT_in_bed.tar.gz .

tar -xzvf GREAT_in_bed.tar.gz

