suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(Matrix))

find_res_file <- function(results_dir, iter=NULL){
    if(is.null(iter)){
        files_in_dir <- list.files(results_dir)
        results_files <- files_in_dir[startsWith(files_in_dir, "output_lambda_") & endsWith(files_in_dir, ".RData")]
        iter <- max(as.numeric(gsub(".RData", "", gsub(pattern = "output_lambda_", "", results_files))))        
    }
    file.path(results_dir, paste0("output_lambda_", iter, ".RData"))
}

find_argmax_lambda_idx <- function(results_dir){
    last_rdata_env <- new.env()
    load(find_res_file(results_dir), envir = last_rdata_env)
    # feature_names <- names(last_rdata_env$norm_prod)    
    lambda_idx <- which.max(rowSums(last_rdata_env$metric_val))
    lambda_idx
}

matrix_to_df <- function(mat){
    df <- as.data.frame(mat)
    df[rowSums(df) != 0, ] %>%
    rownames_to_column('names')
}

# sparseMatrix_to_df <- function(mat){
#     df <- as.data.frame(summary(mat))
    
#     if(!is.null(rownames(mat))){
#         df <- df %>%
#         left_join(
#             data.frame(
#                 i = 1:nrow(mat),
#                 i_names = rownames(mat),
#                 stringsAsFactors=F
#             ),
#             by='i'
#         )
#     }

#     if(!is.null(colnames(mat))){
#         df <- df %>%
#         left_join(
#             data.frame(
#                 j = 1:ncol(mat),
#                 j_names = colnames(mat),
#                 stringsAsFactors=F
#             ),
#             by='j'
#         )
#     }
    
#     df
# }

extract_biplot_data <- function(C, phenames, varnames, save_path){
    svd_obj <- svd(C)
    
    # save D (singular values)
    data.frame(
        names = paste0('V', 1:r),
        eigen_v = svd_obj$d[1:r],
        stringsAsFactors=F
    ) %>%
    rename('#names' = 'names') %>%
    fwrite(sprintf('%s.D.tsv', save_path), sep='\t', na = "NA", quote=F)
    
    # save phenotype singular vectors
    V <- svd_obj$v[, 1:r, drop = F]
    rownames(V) <- phenames
    matrix_to_df(V) %>%
    rename('#names' = 'names') %>%
    fwrite(sprintf('%s.U.tsv', save_path), sep='\t', na = "NA", quote=F)

    # save variant singular vectors
    U <- svd_obj$u[, 1:r, drop = F] 
    rownames(U) <- varnames
    matrix_to_df(U) %>%
    rename('#names' = 'names') %>%
    fwrite(sprintf('%s.V.tsv', save_path), sep='\t', na = "NA", quote=F)
    
}