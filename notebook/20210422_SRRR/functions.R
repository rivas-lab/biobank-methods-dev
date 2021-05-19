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


read_var_annot <- function(var_annot_f){
    # read variant annotation files
    var_annot_f %>%
    fread(colClasses = c('#CHROM'='character')) %>%
    rename('CHROM'='#CHROM') %>%
    mutate(ID_ALT = paste(ID, ALT, sep='_')) %>%
    mutate(
        POS_e = POS + str_length(REF),
        CHROM = if_else(CHROM == 'XY', 'X', CHROM),
        CHROM = if_else(CHROM == 'MT', 'M', CHROM),
        CHROM = paste0('chr', CHROM)
    )
}

get_top_k_variants <- function(var_contribution_df, component_idx, k=5000){
    var_contribution_df %>%
    filter(rank <= k, component == sprintf('Component%s', component_idx)) %>%
    pull(rowname)
}

mkdir_p_if_not_exist <- function(path){
    if(!dir.exists(path)){
        dir.create(path, recursive=TRUE)
    }
}
