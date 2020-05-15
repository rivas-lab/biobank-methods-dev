# PRS-CS

As a benchmarking comparison of `snpnet` against the other methods, we apply [`PRS-CS`](https://github.com/getian107/PRScs).

- [`1_bfile_prep.sh`](1_bfile_prep.sh)
  - MAF 0.1% threshold (as in the snpnet paper)
  - [`1_bfile_prep_autosomes.sh`](1_bfile_prep_autosomes.sh): the autosome-only plink bfile
- [`2_gwas.sh`](2_gwas.sh): apply GWAS
- [`3_plink2_to_PRScs.sh`](3_plink2_to_PRScs.sh): convert the PLINK sumstats to PRS-cs format.
  - [`3_plink2_to_PRScs.R`](3_plink2_to_PRScs.R)
- [`4_PRScs.sh`](4_PRScs.sh)
