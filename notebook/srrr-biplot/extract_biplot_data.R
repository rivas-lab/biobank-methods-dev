fullargs <- commandArgs(trailingOnly=FALSE)
args <- commandArgs(trailingOnly=TRUE)

script.name <- normalizePath(sub("--file=", "", fullargs[grep("--file=", fullargs)]))

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))

####################################################################
source(file.path(dirname(script.name), 'srrr-plot_functinos.R'))
####################################################################
results_dir <- args[1] 
r           <- as.integer(args[2])
save_path   <- args[3]
####################################################################

load(find_res_file(results_dir, find_argmax_lambda_idx(results_dir)))

extract_biplot_data(fit$C, rownames(A_init), rownames(fit$C), save_path)
