library(Matrix)

result_dir <- "/oak/stanford/groups/mrivas/users/mrivas/repos/multiresponse-ukbb/results_asthma_rank_5_unweightedresults_rank_2/results_rank_2/"
save_path <- "temp.RData"  # path to save the extracted results
is_full_matrix <- TRUE  # should full coefficient matrix be extracted or only the active subset

files_in_dir <- list.files(result_dir)
result_files <- files_in_dir[startsWith(files_in_dir, "output_lambda_") & endsWith(files_in_dir, ".RData")]
max_iter <- max(as.numeric(gsub(".RData", "", gsub(pattern = "output_lambda_", "", result_files))))

result <- file.path(result_dir, paste0("output_lambda_", max_iter, ".RData"))
myenv <- new.env()
load(result, envir = myenv)
feature_names <- names(myenv$norm_prod)

U_all <- vector("list", max_iter)
V_all <- vector("list", max_iter)

for (j in 1:max_iter) {
  cat("Lambda", j, "...")
  result <- file.path(result_dir, paste0("output_lambda_", j, ".RData"))
  if (file.exists(result)) {
    myenv <- new.env()
    load(result, envir = myenv)
    C <- myenv$fit$C
    svd_obj <- svd(C)
    U <- svd_obj$u[, 1:r, drop = F] 
    D <- diag(svd_obj$d[1:r], r)
    rownames(U) <- rownames(C)
    V <- svd_obj$v[, 1:r, drop = F]
    rownames(V) <- colnames(C) 
    
    rname_zero <- setdiff(feature_names, rownames(U))
    matSparse <- sparseMatrix(
      i = c(), 
      j = c(), 
      dims = c(length(rname_zero), ncol(U)), 
      dimnames = list(rname_zero, NULL)
    )
    if (is_full_matrix) {
      U_all[[j]] <- rbind(U, matSparse)
    } else {
      U_all[[j]] <- U
    }
    V_all[[j]] <- V
  } else {
    warning("File does not exist: ", result)
  }
  cat("Done.\n")
}

if (!is.null(save_path)) {
  save(V_all, U_all, D, file = save_path)
}
