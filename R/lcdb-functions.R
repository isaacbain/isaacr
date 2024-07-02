#' Load LCDB symbology
#'
#' @return A data frame with the symbology for the LCDB classes
#' @export
#'
#' @examples
#' load_lcdb_symbology()
load_lcdb_symbology <- function() {
  landcover_df <- data.frame(
    Class = c(
      "1", "6", "5", "2", "10", "12", "15", "16", "14", "20", "21", "22",
      "30", "33", "40", "41", "43", "44", "45", "46", "47", "50", "51", "52",
      "54", "55", "56", "58", "80", "81", "64", "68", "69", "71", "70", "0"
    ),
    Colour = c(
      "#9c9c9c", "#704489", "#a80000", "#688578", "#ffff73", "#ca7af5", "#abcd66", "#9cba9c",
      "#dbd4ff", "#bee8ff", "#bee8ff", "#d6f5e8", "#ffd37f", "#e69800", "#beff8c", "#a3d400",
      "#e6e68c", "#d2d25a", "#c2ffd6", "#def5de", "#7af5ca", "#705c00", "#7d690f", "#8c7922",
      "#a8994f", "#b8ab6a", "#c4bb89", "#d4cdae", "#bfcdae", "#d4c27a", "#a1ad61", "#477f00",
      "#284600", "#38a800", "#448989", "#000000"
    ),
    Name = c(
      "Built-up Area (settlement)", "Surface Mines and Dumps", "Transport Infrastructure",
      "Urban Parkland/Open Space", "Sand or Gravel", "Landslide", "Alpine Grass/Herbfield",
      "Gravel or Rock", "Permanent Snow and Ice", "Lake or Pond", "River", "Estuarine Open Water",
      "Short-rotation Cropland", "Orchard Vineyard and Other Perennial Crops",
      "High Producing Exotic Grassland", "Low Producing Grassland", "Tall Tussock Grassland",
      "Depleted Grassland", "Herbaceous Freshwater Vegetation", "Herbaceous Saline Vegetation",
      "Flaxland", "Fernland", "Gorse and/or Broom", "Manuka and/or Kanuka",
      "Broadleaved Indigenous Hardwoods", "Sub Alpine Shrubland", "Mixed Exotic Shrubland",
      "Matagouri or Grey Scrub", "Peat Shrubland (Chatham Is)", "Dune Shrubland (Chatham Is)",
      "Forest - Harvested", "Deciduous Hardwoods", "Indigenous Forest", "Exotic Forest",
      "Mangrove", "Not land"
    )
  )

  return(landcover_df)
}
