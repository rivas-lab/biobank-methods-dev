# cancer snpnet

- list of traits are coplied from: `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/asthma.lst~`
- results dir: `/scratch/groups/mrivas/projects/PRS/private_output/20200506-asthma-snpnet`
- job script: `snpnet.cancer.sh`

## job submission

## binomial

```{bash}
bash snpnet.asthma.sh HC382
```

```{bash}
cat asthma.lst | awk -v FS=',' '{print $1}' | grep -v INI | while read GBE_ID ; do bash resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet_asthma --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-00:00:00' --mem 30000 --mem_mult 2 --log logs/resbatch.log --src snpnet.asthma.sh - ${GBE_ID} binomial ; done

cat asthma.lst | awk -v FS=',' '{print $1}' | grep    INI | while read GBE_ID ; do bash resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet_asthma --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-00:00:00' --mem 30000 --mem_mult 2 --log logs/resbatch.log --src snpnet.asthma.sh - ${GBE_ID} gaussian ; done

```
