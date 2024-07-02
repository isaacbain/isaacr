
<!-- README.md is generated from README.Rmd. Please edit that file -->

# isaacr

<!-- badges: start -->
<!-- badges: end -->

`isaacr` is an R package with miscellaneous R functions that are useful
to me.

## Installation

You can install the development version of isaacr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("isaacbain/isaacr")
```

## Functions

### LCDB symbology

`load_lcdb_symbology()` returns a data frame with the symbology for the
LCDB classes.

### Crop sf by bounding box

`st_crop_bbox()` crops an `sf` object by a bounding box.
