#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source parameters.sh

cd ${great_d}
tar -czvf GREAT_out.tar.gz GREAT_out

echo "scp ${great_d}/GREAT_out.tar.gz ${hostname}:${data_d}/${RData_path%.RData}/"
scp ${great_d}/GREAT_out.tar.gz ${hostname}:${data_d}/${RData_path%.RData}/

