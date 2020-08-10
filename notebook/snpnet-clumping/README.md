# clumping-based PRS

As a performance comparison, we perform clumping-based PRS analysis.

For LD clumping, we use `plink --clump` (analysis script: [`1_clump.sh`](1_clump)).

We then computed PRS with [`2_plink-score.sh`](2_plink-score.sh).

Finally, we evaluated their predictive performance in the held-out test set in [`3_performance_eval.ipynb`](3_performance_eval.ipynb).
