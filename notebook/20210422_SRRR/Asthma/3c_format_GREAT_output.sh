
# pheno='HC382'

# bash GREAT_binom_viewer.sh /oak/stanford/groups/mrivas/projects/biobank-methods-dev/20210422_SRRR/Asthma/results_rank_5/output_lambda_67/GREAT_out/${pheno} MGIPhenoSingleKO ${pheno} > ${pheno}.tsv

phenos=(Component1 Component2 Component3 Component4 Component5) 

for pheno in ${phenos[@]} ; do

    bash GREAT_binom_viewer.sh /oak/stanford/groups/mrivas/projects/biobank-methods-dev/20210422_SRRR/Asthma/results_rank_5/output_lambda_67/GREAT_out/${pheno} MGIPhenoSingleKO ${pheno} > ${pheno}.tsv

done
