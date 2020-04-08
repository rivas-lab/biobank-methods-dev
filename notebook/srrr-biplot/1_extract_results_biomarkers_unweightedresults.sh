#!/bin/bash
set -beEuo pipefail

for rank in 10 20 35 ;  do
    echo "$(date +%Y%m%d-%H%M%S) ${rank}"
    Rscript extract_biplot_data.R \
    /oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_biomarkers_unweightedresults_rank_${rank}/results_rank_${rank}/ \
    ${rank} \
    data/biomarkers_unweightedresults_rank_${rank}
done
