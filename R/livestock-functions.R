#' Nearest stock unit equivalent based on year
#'
#'
#' @description
#' `get_stock_unit` returns the nearest stock unit equivalent for the given animal and year.
#'
#' The function uses the stock_units data frame to find the nearest year and corresponding stock unit equivalent.
#' The stock_units data frame contains the stock unit equivalents for different animals
#' for the years 1980, 1985, 2000, and 2017. This can be updated as needed, or held constant.
#'
#' Follows the methods of Snelder et al (2021).
#'
#' @references
#'
#' Snelder TH, Fraser C, Larned ST, Monaghan R, De Malmanche S, Whitehead AL. Attribution of river water-quality trends to agricultural land use and climate variability in New Zealand. Marine and Freshwater Research. 2021;73(1):1-19. doi:10.1071/mf21086
#'
#' @param animal animal type (e.g. "sheep", "beer", "dairy", "deer")
#' @param year year
#' @param stock_units stock units data frame
#'
#' @return Nearest stock unit equivalent for the given animal and year
#' @export
#'
#' @examples
#' get_stock_unit("Sheep", 1990)
#'
#' library(dplyr)
#'
#' test_df <- tibble(
#'   year = rep(c(1970, 1985, 1990, 2005), each = 3),
#'   animal = rep(c("Sheep", "Beef cattle", "Dairy cattle"), times = 4),
#'   count = c(3000, 5000, 7000, 8000, 10000, 6000, 7000, 9000, 11000, 5000, 6000, 7000)
#' )
#'
#' test_df |>
#'   rowwise() |>
#'   mutate(stock_unit_equivalent = count * get_stock_unit(animal, year)) |>
#'   ungroup()
get_stock_unit <- function(animal, year, stock_units = stock_units) {

  stock_units <- dplyr::tibble(
    year = c(1980, 1985, 2000, 2017),
    `Sheep` = c(0.95, 0.95, 1.15, 1.35),
    `Beef cattle` = c(5, 5.3, 6, 6.9),
    `Dairy cattle` = c(5, 5.5, 6.8, 8),
    `Deer` = c(1.6, 1.6, 2, 2.3)
  )

  year_diff <- abs(stock_units$year - year)
  nearest_year <- stock_units$year[which.min(year_diff)]
  multiplier <- stock_units |>
    dplyr::filter(year == nearest_year) |>
    dplyr::select(all_of(animal)) |>
    dplyr::pull()
  return(multiplier)
}

