# data-split

We will split 337,199 White British individuals from UKBB into training, validation, and test sets.

- `data-split_fam_file_generation.ipynb`: This notebook generates `fam` file.
- `data-split.sh` : This script splits the original genotype files into training, validation, and test sets. Please pass one of the following as the first argument for this script: `train`, `val`, or `test`. You need to have PLINK2 installed in your $PATH.
- `make_pgen.sh` : This script converts PLINK1 triple (bed, bim, fam) into PLINK2 triple (pgen, pvar, psam).

