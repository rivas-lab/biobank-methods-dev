# P+T

As a performance comparison, we perform P+T-based PRS analysis.

For LD pruning, we use `plink2 --indep-pairwise 50 5 .5` (analysis script: [`1_pruning.sh`](1_pruning.sh)).

This produced a list of variants in

`/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-P_and_T/ukb24983_cal_cALL_v2_hg19_train_val.prune.in`

Focusing on those pruned variants and imposing P-value threshold, we then computed PRS with [`2_plink-score.sh`](2_plink-score.sh).

Finally, we evaluated their predictive performance in the held-out test set in [`3_performance_eval.ipynb`](3_performance_eval.ipynb).
