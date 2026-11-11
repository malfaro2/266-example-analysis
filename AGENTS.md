# Instructions for AI assistants

This file tells any AI coding assistant (Claude Code, Copilot, Positron Assistant, Cursor, ...)
how to work in this repository. Read it, and `STYLE.md`, before doing anything.
(Claude Code reads `CLAUDE.md`; that file only points here.)

## What this project is

A descriptive analysis for a statistics course. `run-analysis.qmd` runs the whole
pipeline: `R/01-import.R` → `02-clean.R` → `03-reshape-join.R` → Python step
(`python/summarize.py`) → `04-describe.R`. Students must be able to explain every line.

## Boundaries: never do these

- Never modify, rename, or delete anything in `data/raw/`.
- Never add an R or Python package without asking first. If one is approved, update `renv.lock` (`renv::snapshot()`) or the `py_require()` call.
- Never use absolute paths, `setwd()`, or `rm(list = ls())`.
- Never download data or call external services.
- Never edit the "AI use" section of `run-analysis.qmd`; the humans write it.
- Never change results silently: if a change alters a number, a row count, or a figure, say so.

## How to work

- Make the **smallest change** that does the task. Don't rewrite files you were not asked about.
- Follow `STYLE.md`.
- Propose a diff and explain each change in one sentence; wait for approval before large edits.
- After a change, the check is: `quarto render run-analysis.qmd` completes, and row counts reported in the runbook are unchanged unless the change was meant to change them.
- If you are not sure, ask. Don't guess about the data.
