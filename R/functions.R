# Small helper functions used by more than one step of the pipeline.
# Each one either checks an assumption (and stops loudly if it fails)
# or reports what a step did, so surprises show up in the rendered runbook.

# Stop if `cols` do not uniquely identify the rows of `df`.
# A duplicated key before a join silently multiplies rows.
check_unique_key <- function(df, cols) {
  n_dupes <- sum(duplicated(df[cols]))
  if (n_dupes > 0) {
    stop(n_dupes, " duplicated rows for key (", paste(cols, collapse = ", "), ")")
  }
  invisible(df)
}

# Print how many rows a step kept, so a row count that changes
# unexpectedly is visible instead of hidden. We print with cat() rather than
# message() because the runbook hides messages (warning: false).
report_rows <- function(before, after, step) {
  cat(step, ": ", nrow(before), " -> ", nrow(after), " rows\n", sep = "")
  invisible(after)
}
