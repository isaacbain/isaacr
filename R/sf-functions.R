#' Crop sf object by bbox
#'
#' @param x sf object to crop
#' @param bbox bbox object to crop by
#'
#' @return A smaller sf object
#' @export
#'
#' @examples
st_crop_bbox <- function(x, bbox) {
  if (!inherits(x, "sf")) stop("x must be an sf object")
  if (!inherits(bbox, "bbox")) stop("bbox must be a bbox object")

  sf::st_intersection(x, sf::st_as_sfc(bbox))
}
