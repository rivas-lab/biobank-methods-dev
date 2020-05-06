# cancer snpnet

- list of traits are coplied from: `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/multisnpnetcancer.txt`

```{bash}
bash snpnet.cancer.sh cancer1001
```

[2020-05-05 02:07:05 snpnet] The number of individuals in train set: 235997
[2020-05-05 02:07:05 snpnet] The number of individuals in val set: 33714

## job submission


```{bash}
cat  multisnpnetcancer.txt | awk -v FS=',' '(NR>1){print $1}' | while read GBE_ID ; do sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --mem 10000 --cpus-per-task 4 --time=2-00:00:00  /oak/stanford/groups/mrivas/users/ytanigaw/repos/yk-tanigawa/resbatch/resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-00:00:00' --try_total 12 --mem 10000 --mem_mult 2 --log logs/resbatch.log --src snpnet.cancer.sh - ${GBE_ID} ; done
```
