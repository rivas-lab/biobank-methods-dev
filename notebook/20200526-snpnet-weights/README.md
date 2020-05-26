# penalty factors in `snpnet`

1. PTVs get .5
2. Protein altering variants is .75
3. Others 1

We test those with two phenotypes, Asthma and LDL cholesterol

## data location

`/scratch/groups/mrivas/projects/biobank-methods-dev/20200526-snpnet-weights`

## job submission

### weighted

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.net.sh - -w HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.net.sh - -w INI30780 gaussian


### unweighted

```{bash}
resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.net.sh - HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.net.sh - INI30780 gaussian
```
