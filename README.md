# debug-parallel-warnings


Testing a dummy function that produces a long `data.table` and emits warnings.

- `settings.R` defines `n_repls` and `n_threads` for scaling.

- `orig-no-warnings.R` just runs `foreach` in parallel, which muffles warnings.
- `with-warnings.R` does some handler shenanigans to capture warnings
- `dofuture-multisession` uses `{doFuture}` to automatically handle warnings with the `"multisession"` strategy using `{future}`
- `dofuture-multicore` is the same but using the `"multicore"` strategy which forks the process to use shared memory, 
  which sadly does not work on Windows or inside RStudio.


## Experimental timings

Using just 10000 repls and 20 threads:

```
foreach without warnings:       6.114 sec elapsed
foreach with captured warnings: 1.193 sec elapsed

foreach with doFuture, strategy 'multisession': 98.93 sec elapsed
foreach with doFuture, strategy 'multicore': 91.883 sec elapsed
```
