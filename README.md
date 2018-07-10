
<!-- README.md is generated from README.Rmd. Please edit that file -->
peakPantheR <img src="man/figures/peakPantheR-logo.png" align="right" />
========================================================================

[![Build Status](https://travis-ci.org/phenomecentre/peakPantheR.svg?branch=master)](https://travis-ci.org/phenomecentre/peakPantheR) [![codecov](https://codecov.io/gh/phenomecentre/peakPantheR/branch/master/graph/badge.svg)](https://codecov.io/gh/phenomecentre/peakPantheR/branch/master)

peakPantheR
===========

Package for *Peak Picking and ANnoTation of High resolution Experiments in R*, implemented in `R` and `Shiny`

Overview
--------

`peakPantheR` implements functions to detect, integrate and report pre-defined features in MS files. It is designed for:

-   **Real time** feature detection and integration (see [Real Time Annotation](inst/doc/real-time-annotation.html))
    -   process `multiple` compounds in `one` file at a time
-   **Post-acquisition** feature detection, integration and reporting (see [Parallel Annotation](inst/doc/parallel-annotation.html))
    -   process `multiple` compounds in `multiple` files in `parallel`, store results in a `single` object

Installation
------------

Install the development version of the package directly from GitHub with:

``` r
# Install devtools
if(!require("devtools")) install.packages("devtools")
devtools::install_github("phenomecentre/peakPantheR")
```

If the dependencies `mzR` and `MSnbase` are not successfully installed, `Bioconductor` must be added to the default repositories with:

``` r
setRepositories(ind=1:2)
```

Usage
-----

Both real time and parallel compound integration require a common set of information:

-   Path(s) to `netCDF` / `mzML` MS file(s)
-   An expected region of interest (`RT` / `m/z` window) for each compound.

Vignettes
---------

More information is available in the following vignettes:

-   [Getting Started with peakPantheR](inst/doc/getting-started.html)
-   [Real Time Annotation](inst/doc/real-time-annotation.html)
-   [Parallel Annotation](inst/doc/parallel-annotation.html)

Copyright
---------

`peakPantheR` is licensed under the [GPLv3](http://choosealicense.com/licenses/gpl-3.0/)

As a summary, the GPLv3 license requires attribution, inclusion of copyright and license information, disclosure of source code and changes. Derivative work must be available under the same terms.

© National Phenome Centre (2018)
