source("settings.R")

library(foreach)
library(doFuture)
# https://www.jottr.org/2023/06/26/dofuture/
future::plan("multisession", workers = n_threads)

cli::cli_alert_info("Running foreach with doFuture with {n_repls} repls on {n_threads} threads")
tictoc::tic("foreach with doFuture")
result <- foreach(i = seq_len(n_repls), .combine = "rbind") %dofuture% {
  a <- "blabla"
  b <- 3
  sqrt(-1)
  log(-1)
  res <- data.table::data.table(a,b)
  res
}
tictoc::toc()

assert_result(result)
