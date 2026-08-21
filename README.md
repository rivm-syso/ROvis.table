<!-- badges: start -->
[![CI](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.table/badges/ci.json)](https://github.com/rivm-syso/ROvis.table/actions/workflows/ci.yaml)
[![Lint](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.table/badges/lint.json)](https://github.com/rivm-syso/ROvis.table/actions/workflows/ci.yaml)
[![Coverage](https://img.shields.io/endpoint?url=https://rivm-syso.github.io/ROvis.table/badges/coverage.json)](https://github.com/rivm-syso/ROvis.table/actions/workflows/ci.yaml)
<!-- badges: end -->

# ROvis.table <a href="https://github.com/rivm-syso/ROvis.table"><img src="man/figures/logo.png" align="right" height="138" /></a>

## Rijksoverheid Visualisatie - table

## Description
ROvis.table provides accessible, keyboard-navigable data tables and themed visualizations using the gt and DT packages, with RIVM styling guidelines.

## Installation

```r
# Install from GitHub (private repo - requires GitHub auth, e.g. a PAT
# via usethis::create_github_token() / gitcreds, since this repo is private)
# install.packages("remotes")
remotes::install_github("rivm-syso/ROvis.table")
```

## Usage

```r
library(ROvis.table)

# Apply the RIVM-styled gt theme to a data frame
ro_gt_theme(head(mtcars, 5))
```

## Support
First point of contact for questions: SPIN team (spin@rivm.nl)

## Roadmap
*If you have ideas for releases in the future, it is a good idea to list them in the README.*

## Contributing
See [CONTRIBUTING.md](.github/CONTRIBUTING.md) for guidelines on how to contribute, and [CONTRIBUTORS.md](CONTRIBUTORS.md) for the list of contributors.

## Instructions for developers 

Below we describe the most important guidelines and practicalities for R package
development on this project.


### Requirements
We use the `testthat`, `lintr` and `roxygen2` package for development of tests, code style 
checks and automatic documentation. We also use the `devtools` and `usethis` package during 
development to adhere to standards for R packages and make developing easier! Install them 
in your Rstudio environment:

```r
install.packages("testthat")
install.packages("lintr")
install.packages("roxygen2")
install.packages("quarto")
install.packages("pkgdown")
install.packages("devtools")
install.packages("usethis")
```

### Guidelines
Type `devtools::load_all()` in your console each time you start developing. This loads 
all dependencies and non-exported functions in the NAMESPACE. This makes developing a lot easier!

To ensure code standardization and quality, follow these guidelines:
- Add tests with `usethis::use_test()`
- Add a new package dependency to the DESCRIPTION file with `usethis::use_package()`. We use 
the `min_version` argument to specify a minimum version. 
- Add a new function dependency to the NAMESPACE with `usethis::use_import_from()`
- Add documentation to new functions by inserting a roxygen skeleton and use `devtools::document()` to
create automatic documentation in the `man` folder

## Authors and acknowledgment
This R package was created by the SPIN team (spin@rivm.nl).

## License
This package is licensed under the Apache License 2.0. See [LICENSE.md](LICENSE.md) for details.
