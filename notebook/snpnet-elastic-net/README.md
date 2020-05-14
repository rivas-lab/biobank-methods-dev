# The elastic net in `snpnet`

## performance evaluation

- [`snpnet-elastic-net.eval.tsv`](snpnet-elastic-net.eval.tsv): this table has the evaluated performance.
  - `GBE_ID`: the phenotype ID in Global Biobank Engine
  - `alpha`: the value of the alpha parameter in elastic net
  - `n_variables`: the number of genetic variants (this does NOT include the number of covariates) in the model
  - `geno`: the r2 or AUC of the risk score computed only with the genetic variants.
  - `covar`: the r2 or AUC of the risk score computed only with the covariates.
  - `geno_covar`: : the r2 or AUC of the risk score computed with both the genetic variants and covariates.
- [`snpnet-elastic-net.eval.ipynb`](snpnet-elastic-net.eval.ipynb): this notebook was used to generate the table above.

## file location

- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net`

## phenotype

- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/phenotype.phe`

### phenotype source files

The original file used in the snpnet v1 analysis was the followings:

- Standing height
  - `/oak/stanford/groups/mrivas/ukbb24983/phenotypedata/ukb9797_20170818_qt/INI50.phe`
- BMI
  - `/oak/stanford/groups/mrivas/ukbb24983/phenotypedata/ukb9797_20170818_qt/INI21001.phe`

Those files are already archived.

```{bash}
cd /oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net

tar -I pigz -xvf /oak/stanford/groups/mrivas/ukbb24983/phenotypedata/phenotypedata_old.tar.gz old/ukb9797_20170818_qt/INI50.phe old/ukb9797_20170818_qt/INI21001.phe
```

- INI50: Standing height
  - `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/INI50.phe`
- INI21001: BMI
  - `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net/INI21001.phe`
- HC382: asthma
  - `/oak/stanford/groups/mrivas/ukbb24983/phenotypedata/extras/highconfidenceqc/v1_2017/phe/HC382.phe`
- HC269: high_cholesterol
  - `/oak/stanford/groups/mrivas/ukbb24983/phenotypedata/extras/highconfidenceqc/v1_2017/phe/HC269.phe`

## covariates

- `/oak/stanford/groups/mrivas/ukbb24983/sqc/population_stratification_w24983_20190809/ukb24983_GWAS_covar.20190809.phe`
- age, sex, PC1-PC10

## split

`/oak/stanford/groups/mrivas/users/ytanigaw/repos/rivas-lab/biobank-methods-dev/private_data/data-split/train.fam`

## genotype data

`/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19.{pgen,psam,pvar.zst}`

### genotype file QC

Genotype data is the array genotype dataset, consists of 805,426 variants.
We found that there was REF/ALT flip in the original dataset.
(I guess I forgot to add --keep-allele-order flag when creating it...)

```{bash}
cat /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2.bim | wc -l
805426

cat /oak/stanford/groups/mrivas/users/ytanigaw/repos/rivas-lab/biobank-methods-dev/private_data/data-split/train.bim | cut -f2 | md5sum
2cae5f3930e57feef883b80baf329b2e  -

cat /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2.bim | cut -f2 | md5sum
2cae5f3930e57feef883b80baf329b2e  -

head /oak/stanford/groups/mrivas/users/ytanigaw/repos/rivas-lab/biobank-methods-dev/private_data/data-split/train.bim
1       rs28659788      0       723307  G       C
1       rs116587930     0       727841  A       G
1       rs116720794     0       729632  T       C
1       rs3131972       0       752721  A       G
1       rs12184325      0       754105  T       C
1       rs3131962       0       756604  A       G
1       rs114525117     0       759036  A       G
1       rs3115850       0       761147  T       C
1       rs115991721     0       767096  G       A
1       rs12562034      0       768448  A       G

head /oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2.bim
1       rs28659788      0       723307  G       C
1       rs116587930     0       727841  A       G
1       rs116720794     0       729632  T       C
1       rs3131972       0       752721  G       A
1       rs12184325      0       754105  T       C
1       rs3131962       0       756604  G       A
1       rs114525117     0       759036  A       G
1       rs3115850       0       761147  C       T
1       rs115991721     0       767096  G       A
1       rs12562034      0       768448  A       G
```
