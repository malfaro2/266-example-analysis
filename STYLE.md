# Style guide for this project

For humans and for AI assistants. When the code and this file disagree, the code is wrong.

## R

We follow the [tidyverse style guide](https://style.tidyverse.org/). The parts that matter most here:

- **Names say what a thing is.** `snake_case`, nouns for data (`fertility_long`), verbs for functions (`check_unique_key()`). Never `df2`, `tmp`, `x`, `data1`.
- `<-` for assignment, `TRUE`/`FALSE` spelled out (never `T`/`F`), spaces around operators, lines under 80 characters.
- One pipe step per line.
- **No magic numbers.** A number that means something (a year, a threshold) gets a name once, at the top of the step or in the runbook, and is used by name everywhere.
- **Don't repeat yourself.** If you copy a block a second time, write a function or use `across()`.
- **Comments explain *why*, not *what*.** A comment must stay true when the code changes; a wrong comment is worse than none.
- **Missing values are a decision.** Drop `NA`s only in the columns a step needs, and report how many rows were dropped. Never `na.omit()` a whole table.
- Check `styler::style_file()` and `lintr::lint()` before committing.

## Python

We follow [PEP 8](https://peps.python.org/pep-0008/): `snake_case` for functions and variables, `CapWords` only for classes, no unused imports, docstrings on every function.

## Files and folders

- `data/raw/` is read-only. Fixes go in code or in `data/reference/`.
- One script per pipeline step, numbered in run order. Shared functions go in `R/functions.R`.
- All paths are relative to the project folder.
- Every number reported in `run-analysis.qmd` text comes from inline code.
