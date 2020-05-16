# `SBayesR`


## scripts

- [`1_split_bfile_by_chr.sh`](1_split_bfile_by_chr.sh)
- [`2_bfile_nvars_cnt.sh`](2_bfile_nvars_cnt.sh)
  - [`2_bfile_nvars.tsv`](2_bfile_nvars.tsv)
- [`3_ldm-sparse.sh`](3_ldm-sparse.sh): this is the script used for the sparse ldm computation.
  - Job submission: `sbatch --chdir=./ -p mrivas --nodes=1 --mem=8000 --cpus-per-task=1 --time=2-0:00:00 --job-name=ldm --output=logs/ldm.%A_%a.out --error=logs/ldm.%A_%a.err --array=1-143 3_ldm-sparse.sh`
  - [`3_ldm-sparse.batch.comp.ipynb`](3_ldm-sparse.batch.comp.ipynb): this notebook generates the index file for the array job.
  - [`3_ldm-sparse.batch.tsv`](3_ldm-sparse.batch.tsv): the index file for the array job.
- [`4_ldm-sparse-merge.sh`](4_ldm-sparse-merge.sh): combine the ldm sparse matrix into one file.
  - [`4_ldm-sparse-merge.mldmlist`](4_ldm-sparse-merge.mldmlist): the list of ldm to merge.
- [`5_afreq.sh`](5_afreq.sh): compute allele frequencies of the variants (which is a required column in GCTA-COJO's ma format)
- [`6_plink2_to_GCTA-COJO-ma.sh`](6_plink2_to_GCTA-COJO-ma.sh): script to convert PLINK2 summary statistics into GCTA-COJO's ma format.
  - [`6_plink2_to_GCTA-COJO-ma.R`](6_plink2_to_GCTA-COJO-ma.R): R script for format conversion.
- [`7_SBayesR.sh`](7_SBayesR.sh): GCTB SBayesR
