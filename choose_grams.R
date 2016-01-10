empty_DT <- function (dt){
  if (is.null(dt))
    return (TRUE)
  return (nrow(dt) == 0)
}

choose_grams <- function(t, b, u){
  # t := trigrams, b:= bigrams, u:= unigrams
  if (empty_DT(t)){
    if (empty_DT(b))
      return (u[1])
    return (b[1])
  }
  
  choose_trigrams_bigrams(t, b)
}

choose_trigrams_bigrams <- function (t, b){
  # Threshold to be changed
  threshold <- 0.01
  new <- merge(t, b, all=T, by="end", allow.cartesian=T)
  new <- new[order(-count.x)]
  new[, ratio:=count.x/count.y]
  new <- new[ratio>threshold]
  new[1:3, end]
}