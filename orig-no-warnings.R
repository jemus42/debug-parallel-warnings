source("settings.R")

library(doParallel)
library(foreach)

n_repls = 1e5
n_threads = 20

data.table::setDTthreads(1)
registerDoParallel(n_threads)
cli::cli_alert_info("Running foreach without warnings with {n_repls} repls on {n_threads} threads")
tictoc::tic("foreach without warnings")
result_3 <- foreach(i = seq_len(n_repls), .combine = "rbind") %dopar% {
  a <- "blabla"
  b <- "3"
  sqrt(-1)
  log(-1)
  res <- data.frame(a,b)
  res
}
tictoc::toc()
