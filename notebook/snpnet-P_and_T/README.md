# P+T

As a performance comparison, we perform P+T-based PRS analysis.

For LD pruning, we use `plink2 --indep-pairwise 50 5 .5` (analysis script: [`1_pruning.sh`](1_pruning.sh)).

This produced a list of variants in

`/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-P_and_T/ukb24983_cal_cALL_v2_hg19_train_val.prune.in`

Focusing on those pruned variants and imposing P-value threshold, we then computed PRS with [`2_plink-score.sh`](2_plink-score.sh).

Finally, we evaluated their predictive performance in the held-out test set in [`3a_performance_eval_train.ipynb`](3a_performance_eval_train.ipynb) and [`3b_performance_eval_train_val.ipynb`](3b_performance_eval_train_val.ipynb).

We repeated the same set of analysis using (i) training set only (60%, the results are shown in [`3a_performance_eval_train.ipynb`](3a_performance_eval_train.ipynb) and [`snpnet-P_and_T.train.eval.tsv`](snpnet-P_and_T.train.eval.tsv)) amd (ii) the combined set of training and validation set (60 + 20%, the results are shown in [`3b_performance_eval_train_val.ipynb`](3b_performance_eval_train_val.ipynb) and [`snpnet-P_and_T.train_val.eval.tsv`](snpnet-P_and_T.train_val.eval.tsv)).

We can check the predictive performance in the validation set in (i) to optimize the hyperparameter, and look at the test-set predictive performance in (ii).
