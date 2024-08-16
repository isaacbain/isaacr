#' Function to create a hexagon with a given radius, center, and rotation
#'
#' @param center coordinates of the center of the hexagon
#' @param radius radius of the hexagon
#' @param rotation rotate corners
#' @param crs crs for sf object
#'
#' @return A hexagon sf object
#' @export
#'
#' @examples
#' \dontrun{
#' hexagon_sf <- create_hexagon(center = c(1600000, 5500000), radius = 100000, rotation = pi/8, crs = 2193)
#' }
#'
st_create_hexagon <- function(center, radius, rotation = 0, crs = 2193) {
  # Define the angles for the vertices (in radians)
  angles <- seq(0, 2 * pi, length.out = 7)

  # Calculate the coordinates of the hexagon vertices before rotation
  hexagon_coords <- cbind(
    center[1] + radius * cos(angles),
    center[2] + radius * sin(angles)
  )

  # Rotation matrix
  rotation_matrix <- matrix(
    c(cos(rotation), -sin(rotation),
      sin(rotation), cos(rotation)),
    ncol = 2
  )

  # Center the coordinates for rotation around the origin
  centered_coords <- sweep(hexagon_coords, 2, center, "-")

  # Apply the rotation
  rotated_coords <- t(rotation_matrix %*% t(centered_coords))

  # Re-center the rotated coordinates
  rotated_hexagon_coords <- sweep(rotated_coords, 2, center, "+")

  # Create the hexagon as an sf polygon
  hexagon <- st_polygon(list(rotated_hexagon_coords))

  # Convert to an sf object
  hexagon_sf <- st_sfc(hexagon, crs = crs)

  # Wrap it in an sf data frame
  hexagon_sf <- st_sf(geometry = hexagon_sf)

  return(hexagon_sf)
}

#' Import folder of tifs and clip by polygon
#'
#' @param tif_folder Folder where your raster files are stored
#' @param polygon_spatvector Polygon to clip the rasters to
#'
#' @return A clipped raster
#' @export
#'
#' @examples
import_clip_raster <- function(tif_folder, polygon_spatvector) {
  # List all tif files in the specified folder
  tif_files <- list.files(path = tif_folder, pattern = "\\.tif$", full.names = TRUE)

  # Read all tif files into a list
  raster_list <- lapply(tif_files, terra::rast)

  # Merge the rasters using do.call and terra::mosaic
  merged_raster <- do.call(terra::mosaic, raster_list)

  # Clip the merged raster by the specified polygon
  clipped_raster <- terra::crop(merged_raster, polygon_spatvector)
  clipped_raster <- terra::mask(clipped_raster, polygon_spatvector)

  return(clipped_raster)
}

#' Create a Rectangle around a Point
#'
#' This function creates a rectangle of specified width and height, centered on a given point.
#'
#' @param center A numeric vector of length 2 specifying the x and y coordinates of the center of the rectangle (e.g., c(x, y)).
#' @param xsize Numeric, the total width of the rectangle (in the same units as the coordinate reference system, typically meters).
#' @param ysize Numeric, the total height of the rectangle (in the same units as the coordinate reference system, typically meters).
#' @param crs Numeric, the coordinate reference system (CRS) of the output geometry. Default is EPSG:2193 (NZTM2000).
#'
#' @return An `sf` object representing the rectangle polygon.
#'
#' @examples
#' \dontrun{
#' # Example usage: Create a rectangle with width 1000 meters and height 500 meters centered at (1577107, 5173732) in NZTM2000
#' rectangle_sf <- st_create_rectangle(center = c(1577107, 5173732), xsize = 1000, ysize = 500)
#'
#' # Plot the rectangle
#' plot(rectangle_sf)
#' }
#'
#' @import sf
#' @export
st_create_rectangle <- function(center, xsize, ysize, crs = 2193) {
  # Calculate the corner points based on the center and sizes
  x_min <- center[1] - xsize / 2
  x_max <- center[1] + xsize / 2
  y_min <- center[2] - ysize / 2
  y_max <- center[2] + ysize / 2

  # Define the coordinates of the rectangle's vertices
  rect_coords <- matrix(c(
    x_min, y_min,  # bottom-left
    x_max, y_min,  # bottom-right
    x_max, y_max,  # top-right
    x_min, y_max,  # top-left
    x_min, y_min   # closing the rectangle
  ), ncol = 2, byrow = TRUE)

  # Create the rectangle as an sf polygon
  rectangle <- st_polygon(list(rect_coords))

  # Convert to an sf object
  rectangle_sf <- st_sfc(rectangle, crs = crs)

  # Wrap it in an sf data frame
  rectangle_sf <- st_sf(geometry = rectangle_sf)

  return(rectangle_sf)
}
