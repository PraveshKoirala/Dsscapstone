empty_DT <- function (dt){
  if (is.null(dt))
    return (TRUE)
  return (nrow(dt) == 0)
}

choose_grams <- function(t, b, u, word){
  # t := trigrams, b:= bigrams, u:= unigrams
  if (empty_DT(t)){
    if (empty_DT(b))
      return (u[1])
    return (b[1])
  }
  
  # choose_trigrams_bigrams_kneser_ney_interpolation(t, b, word)
  choose_trigrams_bigrams_stupid_backoff(t, b)
}

choose_trigrams_bigrams_stupid_backoff <- function (t, b){
  
  new <- merge(t, b, all=T, by="end", allow.cartesian=T)
  new[is.na(new)] = 0
  new <- new[order(-count.x, -count.y)]
  # new[1:min(3, length(end)), end]
  print(new[, end])
  new[1, end]
}

choose_trigrams_bigrams_kneser_ney_interpolation <- function(t, b, word){
  # smoothen the trigrams probabilities
  
  # discounting factor
  du = 3
  cu = sum(t[, count])
  tu= nrow(t)
  
  t[, p_ikn:=max(0, count - du)/cu]
  
  # For the bigrams,
  # subset of the trigrams that contain the middle word as the follows
  temp = trigrams[mid==word[length(word)-1]]
  temp = temp[, .(count=.N), by = list(mid, end)]
  
  
  
  
  
}