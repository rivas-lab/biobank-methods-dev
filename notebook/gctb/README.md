# GCTB

## tutorial

- [Bayesian alphabet tutorials](https://cnsgenomics.com/software/gctb/#Bayesianalphabet)

We tested both Stand-alone version and the MPI version.

```{bash}
/oak/stanford/groups/mrivas/software/gctb/gctb_2.0_tutorial

 mkdir -p $LOCAL_SCRATCH/tmp-gctb-out
 gctb --bfile data/1000G_eur_chr22 --pheno pheno/phenos_ga1.txt --bayes S --pi 0.1 --hsq 0.5 --chain-length 25000 --burn-in 5000 --out $LOCAL_SCRATCH/tmp-gctb-out/test 2>&1 | tee $LOCAL_SCRATCH/tmp-gctb-out/test.log

 mkdir -p $LOCAL_SCRATCH/tmp-gctb-out-mpi
 mpirun -np 2 gctb --bfile data/1000G_eur_chr22 --pheno pheno/phenos_ga1.txt --bayes S --pi 0.1 --hsq 0.5 --chain-length 25000 --burn-in 5000 --out $LOCAL_SCRATCH/tmp-gctb-out-mpi/test 2>&1 | tee $LOCAL_SCRATCH/tmp-gctb-out-mpi/test.log
```

In Sherlock, there is [a MPI tutorial](https://www.sherlock.stanford.edu/docs/software/using/R/#multiple-nodes).
