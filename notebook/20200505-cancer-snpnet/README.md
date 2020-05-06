# cancer snpnet

- list of traits are coplied from: `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/multisnpnetcancer.txt`
- results dir: `/scratch/groups/mrivas/projects/PRS/private_output/20200505-cancer-snpnet`
- job script: `snpnet.cancer.sh`


## job submission

```{bash}
bash snpnet.cancer.sh cancer1001
```

```{bash}
cat multisnpnetcancer.txt | awk -v FS=',' '(NR==2){print $1}' | while read GBE_ID ; do bash resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-00:00:00' --mem 20000 --mem_mult 2 --log logs/resbatch.log --src snpnet.cancer.sh - ${GBE_ID} ; done

cat multisnpnetcancer.txt | awk -v FS=',' '(NR>2){print $1}' | while read GBE_ID ; do bash resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-00:00:00' --mem 20000 --mem_mult 2 --log logs/resbatch.log --src snpnet.cancer.sh - ${GBE_ID} ; done
```

## Notes on snpnet v.0.3.8

For this analysis, we use snpnet `v.0.3.8`. Starting this version, it support `--keep` option. We confirmed that the number of individuals in `train` and `val` matches with what we expect.

```{txt}
[2020-05-05 02:07:05 snpnet] The number of individuals in train set: 235997
[2020-05-05 02:07:05 snpnet] The number of individuals in val set: 33714
```
