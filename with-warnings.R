source("settings.R")

library(doParallel)
library(foreach)
data.table::setDTthreads(1)

registerDoParallel(n_threads)

cli::cli_alert_info("Running foreach with captured warnings with {n_repls} repls on {n_threads} threads")
tictoc::tic("foreach with captured warnings")
result_1 <- foreach(i = seq_len(n_repls),
                  # separate values and warnings, display warnings
                  .final = \(res) {
                    res <- do.call(rbind, res) # transpose
                    values <- data.table::rbindlist(res[,1])
                    lapply(unique(unlist(res[,2], recursive = F)), \(x) if(!is.null(x)) warning(x)) # display warnings
                    values
                  }
) %dopar% {
  # catch warnings
  withCallingHandlers(
    warning = function(w) {
      warning_list_step <<- append(warning_list_step, list(w))
      invokeRestart("muffleWarning")
    },
    # execute loop
    expr = {
      warning_list_step <- NULL
      a <- "blabla"
      b <- "3"
      sqrt(-1)
      log(-1)
      res <- data.frame(a,b)
      list(res, warning_list_step)
    }
  )
}
tictoc::toc()
