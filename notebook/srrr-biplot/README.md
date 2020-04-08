# SRRR biplot

Using the results from SRRR, we extract the relevant matrices.

## Scripts

- [`srrr-plot_functinos.R`](srrr-plot_functinos.R): helper function.
- [`extract_biplot_data.R`](extract_biplot_data.R): extract three matrices from SRRR results directory.
  - Manny provided [a snippet on Gist](https://gist.github.com/marivascruz/a3ed835c6f8d77652007974acd286d2c) for data extraction. Yosuke modified so that we can extract the relevant matrices as tsv files.
  - We keep a copy of the snippet, [`writeSVDSRRR.r`](writeSVDSRRR.r), in this directory.
- [`srrr_plot_functinos.py`](srrr_plot_functinos.py): helper functions for data visualization.
- [`srrr-plot-example.ipynb`](srrr-plot-example.ipynb): example notebook for visualization.
- [`3_R_plot.ipynb`](3_R_plot.ipynb): ggplot version of biplot!

## Note

- It turned out that it's hard to annotate with Python nicely (1st image) especially when multiple phenotypes are sharing a similar direction.
- I rewrote the plotting codes in ggplot2 (2nd image), which also means we can embed this with ggplotly!!

## Examples

### `results_asthma_rank_5_unweightedresults_rank_2`

```{bash}
Rscript extract_biplot_data.R /oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_asthma_rank_5_unweightedresults_rank_2/results_rank_2/ 2 /oak/stanford/groups/mrivas/projects/biobank-methods-dev/srrr-biplot/test
```

This will extract three tsv files as

- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/srrr-biplot/test.{U,D,V}.tsv`

Then, you may run example codes in `srrr-plot-example.ipynb` for visualization.

## Datasets

### Biomarkers, Rank 10

- `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_biomarkers_unweightedresults_rank_10/results_rank_10/`
- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/srrr-biplot/biomarkers_unweightedresults_rank_10.{U,D,V}.tsv`
- [`2_plot_biomarkers_unweightedresults_rank_10.ipynb`](2_plot_biomarkers_unweightedresults_rank_10.ipynb)

### Biomarkers, Rank 20

- `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_biomarkers_unweightedresults_rank_20/results_rank_20/`
- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/srrr-biplot/biomarkers_unweightedresults_rank_20.{U,D,V}.tsv`
- [`2_plot_biomarkers_unweightedresults_rank_20.ipynb`](2_plot_biomarkers_unweightedresults_rank_20.ipynb)

### Biomarkers, Rank 35

- `/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_biomarkers_unweightedresults_rank_35/results_rank_35/`
- `/oak/stanford/groups/mrivas/projects/biobank-methods-dev/srrr-biplot/biomarkers_unweightedresults_rank_35.{U,D,V}.tsv`
- [`2_plot_biomarkers_unweightedresults_rank_35.ipynb`](2_plot_biomarkers_unweightedresults_rank_35.ipynb)
