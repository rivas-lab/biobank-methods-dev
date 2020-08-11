# clumping-based PRS

As a performance comparison, we perform clumping-based PRS analysis.

For LD clumping, we use `plink --clump` (analysis script: [`1_clump.sh`](1_clump)).

We then computed PRS with [`2_plink-score.sh`](2_plink-score.sh).

Finally, we evaluated their predictive performance in the held-out test set in [`3a_performance_eval_train.ipynb`](3a_performance_eval_train.ipynb) and [`3b_performance_eval_train_val.ipynb`](3b_performance_eval_train_val.ipynb).

We repeated the same set of analysis using (i) training set only (60%, the results are shown in [`3a_performance_eval_train.ipynb`](3a_performance_eval_train.ipynb) and [`snpnet-clumping.train.eval.tsv`](snpnet-clumping.train.eval.tsv)) amd (ii) the combined set of training and validation set (60 + 20%, the results are shown in [`3b_performance_eval_train_val.ipynb`](3b_performance_eval_train_val.ipynb) and [`snpnet-clumping.train_val.eval.tsv`](snpnet-clumping.train_val.eval.tsv)).

We can check the predictive performance in the validation set in (i) to optimize the hyperparameter, and look at the test-set predictive performance in (ii).
