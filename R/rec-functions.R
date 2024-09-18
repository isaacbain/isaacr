#' Load REC2.5 watershed data
#'
#' @param df REC geodatabase file
#' @param layer Which layer to load
#'
#' @return An sf object with the REC watershed data
#' @export
#'
load.ws <- function(df = "data/REC2_geodata_version_5/nzRec2_v5.gdb", layer = "rec2ws"){
  rec_ws <<- sf::st_read(dsn = df,
                         layer = layer)
}

#' Load REC2.5 river data
#'
#' @param df REC geodatabase file
#' @param layer Which layer to load
#'
#' @return An sf object with the REC river data
#' @export
#'
load.rivers <- function(df = "data/REC2_geodata_version_5/nzRec2_v5.gdb", layer = "riverlines"){
  rec_rivers <<- sf::st_read(dsn = df,
                             layer = layer)
}

#' Trace upstream
#'
#' @param df REC sf object
#' @param start_segment Starting segment
#' @param max_distance Maximum distance to trace upstream, set to Inf to goto top of catchment
#' @param current_distance Set to 0
#'
#' @return A list of segments which are upstream of the starting segment
#' @export
#'
trace_upstream <- function(df, start_segment, max_distance = Inf, current_distance = 0) {
  # Find the current segment details
  current_segment <- df |> dplyr::filter(nzsegment == start_segment)

  # Base case: If no upstream segment is found or max distance is reached
  if (is.na(current_segment$FROM_NODE) || current_distance >= max_distance) {
    return(current_segment)
  }

  # Recursive case: Find upstream segments
  upstream_segments <- df |> dplyr::filter(TO_NODE == current_segment$FROM_NODE)

  # Recursively call the function for each upstream segment and combine results
  results <- current_segment
  for (segment in upstream_segments$nzsegment) {
    # Calculate new distance
    new_distance <- current_distance + as.numeric(current_segment$Shape_Length)
    if (new_distance < max_distance) {
      results <- rbind(results, trace_upstream(df, segment, max_distance, new_distance))
    }
  }

  return(results)
}
