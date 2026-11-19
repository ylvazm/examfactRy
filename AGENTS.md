# AGENTS.md

`examfactRy` is a small R package that generates synthetic multiple-choice exam data from beta-distributed latent abilities. `DESCRIPTION` is the source of truth for metadata.

## Commands

Run from the repo root. `R`/`Rscript` are **not on PATH** on this Windows machine, so invoke R via its full path (R 4.4.2 as of Nov 2026):

```powershell
& "C:\Program Files\R\R-4.4.2\bin\Rscript.exe" -e "devtools::document()"
```

- `devtools::document()` — regenerate `man/*.Rd` and `NAMESPACE`; **required after editing any `#'` roxygen block**
- `devtools::load_all()` — quick smoke test that the package loads and functions run
- `rcmdcheck::rcmdcheck()` — full `R CMD check` (see known issues below)

`devtools`, `roxygen2`, `testthat`, `usethis`, and `rcmdcheck` are all installed in this R.

## Environment gotchas (Windows)

- PowerShell expands `$` inside double-quoted strings, so `-e "cat(r$notes)"` breaks. For inline R code containing `$`, write the code to a temp `.R` file and run `Rscript.exe <file>` instead.
- `pdflatex` is not installed, so `R CMD check` always ends with an ERROR on "checking PDF version of manual". That error is environmental, not a code regression.

## Package conventions

- **Base R only**: `DESCRIPTION` has no `Imports`. `rbeta` etc. come from `stats`. Avoid adding package dependencies.
- All docs are roxygen2 with `markdown = TRUE`. `man/` and `NAMESPACE` are **generated — never edit them by hand**; run `devtools::document()`.
- One function per file, file named after the function. Only `GenerateData` and `CustomExam` are exported (`@export`); internal helpers are prefixed with `.` and are never exported.
- No `tests/` directory exists yet. If adding tests, use `tests/testthat/`. All generation is stochastic (`rbeta`, `sample`), so tests need `set.seed()` for reproducibility.

## Known `R CMD check` issues (verified Nov 2026)

Expect these pre-existing findings when running a check; fix only when asked:

- **ERROR (examples)**: the `@examples` block in `R/CustomExam.R` starts with a prose line missing `#`, which is parsed as R code and fails.
- **WARNING (Rd \usage)**: `R/CustomExam.R` and `R/CustomResponses.R` document `resp_cat`/`resp.cat`, but the real argument name is `n_cat`.
- **NOTE**: `rbeta` has no `importFrom(stats, rbeta)` in `NAMESPACE` — add `@importFrom stats rbeta` to a roxygen block and re-document.
- **NOTE**: `CITATION.cff` sits at the repo root; R expects `inst/CITATION`.
- **ERROR (PDF manual)**: pdflatex missing — environmental, see above.

Also stale: `.Rbuildignore` lists `^examdata\.Rproj$` (old project name), but the project file is `examfactRy.Rproj`, so it is not actually build-ignored.
