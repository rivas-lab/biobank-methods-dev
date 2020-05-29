# penalty factors in `snpnet`

1. PTVs get .5
2. Protein altering variants is .75
3. Others 1

We test those with two phenotypes, Asthma and LDL cholesterol

## results summary

- [2020/5/28 biobank method development meeting](https://docs.google.com/presentation/d/1jG1jV5TLIS0xoddMTQxuuUjbx9mq5YuO9WZsYQynveA/edit?usp=sharing)
- [2020/6/11 biobank method development meeting](https://docs.google.com/presentation/d/179mcxvm_EAYaRF6mNqy-HNg4PERa4Z0uw6Tjq5WJ64Q/edit?usp=sharing)

## data location

`/scratch/groups/mrivas/projects/biobank-methods-dev/20200526-snpnet-weights`

## job submission

### coding-only dataset

#### weighted

```{bash}
resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet-coding-only --output=logs/snpnet-coding-only.%A.out --error=logs/snpnet-coding-only.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet-coding-only.log --src snpnet-coding-only.sh - -w HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet-coding-only --output=logs/snpnet-coding-only.%A.out --error=logs/snpnet-coding-only.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet-coding-only.log --src snpnet-coding-only.sh - -w INI30780 gaussian
```

#### unweighted

```{bash}
resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet-coding-only --output=logs/snpnet-coding-only.%A.out --error=logs/snpnet-coding-only.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet-coding-only.log --src snpnet-coding-only.sh - HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet-coding-only --output=logs/snpnet-coding-only.%A.out --error=logs/snpnet-coding-only.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet-coding-only.log --src snpnet-coding-only.sh - INI30780 gaussian
```

### "all" variants in the combined array dataset

#### weighted

```{bash}
resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.sh - -w HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.sh - -w INI30780 gaussian
```

#### unweighted

```{bash}
resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.sh - HC382 binomial

resbatch.sh --job_cmd 'sbatch -p mrivas --qos=high_p --job-name=snpnet --output=logs/snpnet.%A.out --error=logs/snpnet.%A.err --time=2-0:00:00' --mem 60000 -c 6 --mem_mult 2 --try_n 1 --log logs/snpnet.log --src snpnet.sh - INI30780 gaussian
```
