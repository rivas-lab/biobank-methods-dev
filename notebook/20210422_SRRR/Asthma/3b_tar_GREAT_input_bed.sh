#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source parameters.sh

cd ${data_d}/${RData_path%.RData}/
tar -czvf GREAT_in_bed.tar.gz GREAT_in_bed

