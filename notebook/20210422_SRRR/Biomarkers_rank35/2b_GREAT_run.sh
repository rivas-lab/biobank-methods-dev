#!/bin/bash
set -beEuo pipefail

SRCNAME=$(readlink -f $0)
SRCDIR=$(dirname ${SRCNAME})

source parameters.sh



great_local_d="${great_d}/$(basename ${data_d})/${results_sub_d}/${rdata_base}/GREAT"

mkdir -p ${great_local_d}/2_out
mkdir -p ${great_local_d}/3_out_by_onto
cd ${great_local_d}

# copy input

echo "scp ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT/1_in_bed.tar.gz ."
scp       ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT/1_in_bed.tar.gz .

# unzip

tar -xzvf 1_in_bed.tar.gz

# run GREAT

find ${great_local_d}/1_in_bed -name "*.bed" \
| while read in_bed ; do
    echo ${in_bed}
    out_dir=${great_local_d}/2_out/$(basename $in_bed .bed)
    GREATER ${assembly} --requiredTests=neither \
        --minAnnotCount=2 \
        --maxAnnotCount=500 \
        ${in_bed} \
        ${out_dir}
done

# extract

find ${great_local_d}/1_in_bed -name "*.bed" \
| while read in_bed ; do
    out_dir=${great_local_d}/2_out/$(basename $in_bed .bed)

    bash $(dirname ${SRCDIR})/GREAT_binom_viewer.sh ${out_dir} ${ontology} $(basename $in_bed .bed) \
        | egrep -v '^#'
done \
| bgzip -l9 -@6 > ${great_local_d}/3_out_by_onto/${ontology}.tsv.gz

# copy back

echo "scp ${great_local_d}/3_out_by_onto/${ontology}.tsv.gz ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT/3_out_by_onto/"
scp       ${great_local_d}/3_out_by_onto/${ontology}.tsv.gz ${hostname}:${data_d}/${results_sub_d}/${rdata_base}/GREAT/3_out_by_onto/
