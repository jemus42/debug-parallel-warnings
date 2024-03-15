n_repls = 1e4
n_threads = min(20, parallelly::availableCores() - 1)

data.table::setDTthreads(1)


# Just to check that each instance actually produces the same data structure
assert_result <- function(result) {
  checkmate::assert_data_table(result, nrows = n_repls)
  checkmate::assert_true(identical(names(result), c("a", "b")))
  checkmate::assert_true(unique(result$a) == "blabla")
  checkmate::assert_true(unique(result$b) == 3)
}
