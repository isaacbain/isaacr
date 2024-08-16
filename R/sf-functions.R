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
#' hexagon_sf <- create_hexagon(center = c(1600000, 5500000), radius = 100000, rotation = pi/8, crs = 2193)
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

