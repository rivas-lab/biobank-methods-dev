# the RData from SRRR
RData_d='/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_asthma_rank_5_unweighted'
results_sub_d='results_rank_5'
rdata_base='output_lambda_67'
rank=5

# we will save our data here

data_d='/oak/stanford/groups/mrivas/projects/biobank-methods-dev/20210422_SRRR/Asthma'

# on the Bejerano lab server, we put the GREAT input/output here
great_d='/cluster/u/ytanigaw/tmp/20210422_great'
assembly='hg19'
hostname='sh2-dtn'
ontology='MGIPhenoSingleKO'

# reference data
#  variant annotation file
var_annot_f='/oak/stanford/groups/mrivas/ukbb24983/array-combined/annotation/annotation_20201012/ukb24983_cal_hla_cnv.annot_compact_20201023.tsv.gz'
#  ontology term list
ref_d='/oak/stanford/groups/mrivas/projects/biobank-methods-dev/20210422_SRRR/ref'
onto_terms='ontoTerms.canon'

# output
variant_weights_f='variant_weights.tsv'

samples_str='Component1,Component2,Component3,Component4,Component5,Component6,Component7,Component8,HC382,INI30130,INI30140,INI30150,INI30160,INI3062,INI3063,INI3064'
