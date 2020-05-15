
# job submission for ldm

## array=1

```{bash}
sbatch --chdir=./ -p normal --reservation r_covid19 --account a_covid19 --nodes=1 --mem=8000 --cpus-per-task=1 --time=2-0:00:00 --job-name=ldm --output=logs/ldm.%A_%a.out --error=logs/ldm.%A_%a.err --array=1 3_ldm-sparse.sh
```

## array=2-143

```{bash}
sbatch --chdir=./ -p normal --reservation r_covid19 --account a_covid19 --nodes=1 --mem=8000 --cpus-per-task=1 --time=2-0:00:00 --job-name=ldm --output=logs/ldm.%A_%a.out --error=logs/ldm.%A_%a.err --array=2-143 3_ldm-sparse.sh
```
