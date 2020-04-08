suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(Matrix))

####################
# extract data
####################

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

extract_biplot_data <- function(C, phenames, varnames, r, save_path){
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

####################
# DeGAs scores
####################

cos2_phe <- function(ud, trait){
    -sort(-(ud[row.names(ud)==trait, ] ** 2) / sum(ud[row.names(ud)==trait, ] ** 2))
}

cos2_var <- function(vd, var){
    -sort(-(vd[row.names(vd)==var, ] ** 2) / sum(vd[row.names(vd)==var, ] ** 2))
}

####################
# plot
####################

mat_to_df <- function(mat, PC_x, PC_y, n_labels=5){
    mat %>%
    as.data.frame() %>%
    rename('PC_x' := PC_x, 'PC_y' := PC_y) %>%
    select(PC_x, PC_y) %>%
    rownames_to_column('label') %>%
    mutate(label = if_else(
        rank(-(PC_x**2+PC_y**2))<=n_labels, 
        label, ''
    ))
}

pca_plot <- function(df, PC_x, PC_y, color='red'){
    lim_abs <- 1.1 * max(abs(df %>% select(PC_x, PC_y)))
    df %>%
    ggplot(aes(x=PC_x, y=PC_y, label=label, shape='_')) +
    geom_point(size=3, color=color) +
    theme_bw() +
    ggrepel::geom_text_repel(size=3, color=color) +
    scale_shape_manual(values=('_'=4)) +
    guides(shape=FALSE) + 
    scale_x_continuous(
        sprintf('Component %s', str_replace_all(PC_x, 'PC', '')),
        limits = c(-lim_abs, lim_abs)
    ) +
    scale_y_continuous(
        sprintf('Component %s', str_replace_all(PC_y, 'PC', '')),
        limits = c(-lim_abs, lim_abs)
    )            
}

biplot <- function(df_vd, df_u, PC_x, PC_y, color_vd='blue', color_u='red'){    
    lim_u_abs   <- 1.1 * max(abs(df_u  %>% select(PC_x, PC_y)))
    lim_vd_abs  <- 1.1 * max(abs(df_vd %>% select(PC_x, PC_y)))
    df_u_scaled <- df_u %>%
    mutate(
        PC_x = PC_x * (lim_vd_abs/lim_u_abs),
        PC_y = PC_y * (lim_vd_abs/lim_u_abs)
    )
    
    ggplot() +
    layer(
        data=df_vd, mapping=aes(x=PC_x, y=PC_y, shape='_'),
        geom='point', stat = "identity", position = "identity",
        params=list(size=1, color=color_vd)
    )+
    layer(
        data=df_u_scaled, 
        mapping=aes(x=0, y=0, xend=PC_x, yend=PC_y),
        geom='segment', stat = "identity", position = "identity",
    #     params=list(size=1, color=color_u, alpha=.2, arrow=arrow())
        params=list(size=1, color=color_u, alpha=.2)    
    )+
    layer(
        data=df_u_scaled, 
        mapping=aes(x=PC_x, y=PC_y, shape='|'),
        geom='point', stat = "identity", position = "identity",
        params=list(size=1, color=color_u)
    )+
    ggrepel::geom_text_repel(
        data=bind_rows(
            df_vd       %>% mutate(color=color_vd),
            df_u_scaled %>% mutate(color=color_u)
        ), 
        mapping=aes(x=PC_x, y=PC_y, label=label, color=color),
        size=3
    ) +
    # ggrepel::geom_text_repel(
    #     data=df_vd, mapping=aes(x=PC_x,y=PC_y,label=label),
    #     size=3, color=color_vd
    # ) +
    # ggrepel::geom_text_repel(
    #     data=df_u_scaled, mapping=aes(x=PC_x,y=PC_y,label=label),
    #     size=3, color=color_u
    # ) +
    theme_bw() +
    scale_color_manual(values=list('blue'='blue', 'red'='red')) +
    scale_shape_manual(values=list('_'=4, '|'=20)) +
    guides(shape=FALSE,color=FALSE) + 
    scale_x_continuous(
        sprintf('Component %s (variant [%s])', str_replace_all(PC_x, 'PC', ''), color_vd),
        limits = c(-lim_vd_abs, lim_vd_abs),
        sec.axis = sec_axis(
            ~ . * (lim_u_abs/lim_vd_abs), 
            name = sprintf('Component %s (phenotype [%s])', str_replace_all(PC_x, 'PC', ''), color_u)
        )
    ) +
    scale_y_continuous(
        sprintf('Component %s (variant [%s])', str_replace_all(PC_y, 'PC', ''), color_vd),
        limits = c(-lim_vd_abs, lim_vd_abs),
        sec.axis = sec_axis(
            ~ . * (lim_u_abs/lim_vd_abs),
            name = sprintf('Component %s (phenotype [%s])', str_replace_all(PC_y, 'PC', ''), color_u)
        )
    )    
}
