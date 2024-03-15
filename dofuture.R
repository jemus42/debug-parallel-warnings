source("settings.R")

library(foreach)
library(doFuture)
data.table::setDTthreads(1)

n_repls = 1e5
n_threads = 20

# https://www.jottr.org/2023/06/26/dofuture/
cli::cli_alert_info("Running foreach with doFuture with {n_repls} repls on {n_threads} threads")
future::plan("multisession", workers = n_threads)

tictoc::tic("foreach with doFuture")
result_4 <- foreach(i = seq_len(n_repls), .combine = "rbind") %dofuture% {
  a <- "blabla"
  b <- "3"
  sqrt(-1)
  log(-1)
  res <- data.frame(a,b)
  res
}
tictoc::toc()
