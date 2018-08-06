# InWeb_InBio dataset

We prepared InBio protein-protein interaction network reference dataset.

## InBio dataset
InBio dataset is downloaded from their website (https://www.intomics.com/inbio/map/#downloads) to our OAK space, 
`/oak/stanford/groups/mrivas/public_data/InWeb_InBioMap_2016_09_12/downloads`.

Given that this dataset is anchored to UniProt ID, we mapped the ID to Ensembl Gene ID.
With the variant annotation file that provide Gene ID for coding variants, 
we can map InBio data (list of interacting protein pairs) to 
list of edges of SNPs.

To be clear, our mapping schema is:

```
Genomic variants (SNPs, identified as quadruple, chromosome, position, ref, alt) -- Genes (Ensembl Gene ID) -- UniProt ID
```

The actual mapping procedure is documented in the notebook in the same directory and the data sources are as follows:

## Ensembl Gene ID mapping through Ensembl Biomart
We first tried to map the ID using the dump from Ensembl Biomart. We used GRCh37 version of Ensembl Biomart (version 93) (http://grch37.ensembl.org/biomart/) and exported the followings to the file.

- Gene stable ID
- Gene name
- UniProtKB/TrEMBL ID

However, it turned out that we only get a few (~3) Uniprot IDs (on InBio dataset) mapped to Ensembl ID using this table.
We decided to use other data source (UniProt dump for both the current version and archive version).

## UniProt ID dump

We downloaded the mapping information (between UniProt ID and Ensembl Gene ID) from UniProt FTP site:

ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/README

Specifically, we used 

ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/idmapping.dat.2015_03.gz

and 

ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/by_organism/HUMAN_9606_idmapping.dat.gz

because the documentation says 2015/03 is the last version before they performed redundancy elimination.


## UK Biobank variant annotation
We used the variant annotation file to get the mapping from variant to gene ID.
`/oak/stanford/groups/mrivas/private_data/ukbb/array_annotation_500k/bims_combined.vep.cf.tsv.gz`
