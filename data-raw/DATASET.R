## code to prepare `DATASET` dataset goes here
library(sf)

# import lcdb5 dataset
lcdb5 <- st_read("/Users/baiis674/working/gis_data/lris-lcdb-v50-land-cover-database-version-50-mainland-new-zealand-SHP/lcdb-v50-land-cover-database-version-50-mainland-new-zealand.shp")

# Define the bounding box for Christchurch
chch_bbox_nztm <- st_bbox(c(xmin = 1543016, xmax = 1587730, ymin = 5169087, ymax = 5190086), crs = st_crs(2193))

# crop the dataset
lcdb5_chch <- sf::st_crop(lcdb5, chch_bbox_nztm)

usethis::use_data(lcdb5_chch, overwrite = TRUE)

# Define the bounding box for blenheim
blenheim_bbox_nztm <- st_bbox(c(xmin = 1660092, xmax = 1693589, ymin = 5396530, ymax = 5412816), crs = st_crs(2193))

lcdb5_blenheim <- st_crop(lcdb5, blenheim_bbox_nztm)

usethis::use_data(lcdb5_blenheim, overwrite = TRUE)
