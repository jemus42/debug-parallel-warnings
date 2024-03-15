source("settings.R")

library(doParallel)
library(foreach)
registerDoParallel(n_threads)

cli::cli_alert_info("Running foreach without warnings with {n_repls} repls on {n_threads} threads")
tictoc::tic("foreach without warnings")
result <- foreach(i = seq_len(n_repls), .combine = "rbind") %dopar% {
  a <- "blabla"
  b <- 3
  sqrt(-1)
  log(-1)
  res <- data.table::data.table(a,b)
  res
}
tictoc::toc()

assert_result(result)
