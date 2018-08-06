# InWeb_InBio dataset
## Yosuke Tanigawa (ytanigaw@stanford.edu) 2018/8/6


We prepared InBio protein-protein interaction network reference dataset.

The result is sitting in
`/oak/stanford/groups/mrivas/users/ytanigaw/repos/rivas-lab/biobank-methods-dev/public_data/InWeb_InBio/InWeb_InBio.Ensembl.SNPs.tsv.gz`


Each line of the file represents an edge of PPI. Let's say there is an interaction between protein x and protein y.

There are 6 columns:
1. SNPs_x : list of SNPs that mapped to protein x
2. SNPs_y : list of SNPs that mapped to protein y
3. Gene stable ID_x : Ensembl Gene ID for protein x
4. Gene stable ID_y : Ensembl Gene ID for protein y
5. score 0 : The first InBio score 
6. score 1 : The second InBio score

The notation of the SNPs_{x,y} is {chromosome}:{position}{reference allele}/{alternative allele}.

To get the list of SNPs on the same pathway, one can concatenate the first two columns (SNPs_x and SNPs_y) and interpret the set of SNPs in these two columns are involved in the same pathway.


## InBio dataset
InBio dataset is downloaded from their website (https://www.intomics.com/inbio/map/#downloads) to our OAK space, 
`/oak/stanford/groups/mrivas/public_data/InWeb_InBioMap_2016_09_12/downloads`.

Given that this dataset is anchored to both UniProt ID and Ensembl Protein ID, we mapped Ensembl Protein ID to Ensembl Gene ID.
After this mapping, we used the variant annotation file that provide Gene ID for coding variants to 
to map InBio data (list of interacting protein pairs) to list of edges of SNPs.

To be clear, our mapping schema is:

```
Genomic variants (SNPs, identified as quadruple, chromosome, position, ref, alt) -- Genes (Ensembl Gene ID) -- Ensembl Protein ID
```

The actual mapping procedure is documented in the notebook in the same directory and the data sources are as follows:

## Ensembl Gene ID / Ensembl Protein ID mapping through Ensembl Biomart
We mapped Ensembl Protein ID to Ensembl Gene ID by using a mapping table extracted from Ensembl Biomart.
We used Biomart versio 93.


## UK Biobank variant annotation
We used the variant annotation file to get the mapping from variant to gene ID.
`/oak/stanford/groups/mrivas/private_data/ukbb/array_annotation_500k/bims_combined.vep.cf.tsv.gz`
