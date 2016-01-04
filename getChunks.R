getChunks <- function(data, n){
  # we need n chunks of data.. each chunk will have
  
  chunk_size <- length(data)/n
  chunks <- split(data, ceiling(seq_along(data)/chunk_size))
  chunks
}