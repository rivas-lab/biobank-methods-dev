#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source parameters.sh

sample=$1
in_bed=${great_d}/GREAT_in_bed/${sample}.bed
out_dir=${great_d}/GREAT_out/${sample}

if [ ! -d $(dirname ${out_dir}) ] ; then mkdir -p $(dirname ${out_dir}) ; fi

GREATER ${assembly} --requiredTests=neither \
    --minAnnotCount=2 \
    --maxAnnotCount=500 \
    ${in_bed} \
    ${out_dir}

