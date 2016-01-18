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
  choose_trigrams_bigrams_kneser_ney_no_unigram_interpolation(t, b, word)
  #choose_trigrams_bigrams_stupid_backoff(t, b)
}

choose_trigrams_bigrams_stupid_backoff <- function (t, b){
  
  new <- merge(t[1:min(10, length(t))], b[1:min(20, length(b))], all=T, by="end", allow.cartesian=T)
  new[is.na(new)] = 0
  new <- new[order(-count.x, -count.y)]
  # new[1:min(3, length(end)), end]
  #print(new[, end])
  new[1:min(3, length(new)), end]
}


choose_trigrams_bigrams_kneser_ney_no_unigram_interpolation <- function(t, b, word){
  # smoothen the trigrams probabilities
  
  # discounting factor
  du_tri = 0.01
  cu = sum(t[, count])
  tu= nrow(t)
  
  t[, c("p_ikn", "du") := .(pmax(0, count - du_tri)/cu, du_tri)]
  
  # For the bigrams,
  # subset of the trigrams that contain the middle word as the follows
  bi = trigrams[mid==word[length(word)]]
  bi = bi[, .(count=.N), by = list(mid, end)]
  
  bi[, p_ikn:= (count/sum(count))]
  
  # merge bigram and trigrams
  tri_bi = merge(t[, .(end, p_ikn, du)], bi[, .(end, p_ikn)], all = T, by="end")
  
  tri_bi[is.na(tri_bi)] = 0
  tri_bi[, p_ikn:=p_ikn.x + du*tu/cu * p_ikn.y]
  
  tri_bi[order(-p_ikn), .(end)][1:min(3, .N), end]
}


choose_trigrams_bigrams_kneser_ney_interpolation <- function(t, b, word){
  # smoothen the trigrams probabilities
  
  # discounting factor
  du = sqrt(t[,count])
  cu = sum(t[, count])
  tu= nrow(t)
  
  t[, p_ikn:=pmax(0, count - du)/cu]
  
  # For the bigrams,
  # subset of the trigrams that contain the middle word as the follows
  bi = trigrams[mid==word[length(word)]]
  bi = bi[, .(count=.N), by = list(mid, end)]
  
  cu_bi = sum(bi[,count])
  du_bi = log(max(bi[, count]))
  bi[, p_ikn:=(pmax(0, count-du_bi)/cu_bi)]
  
  # Now the unigram probabilities can be obtained from the bigram tables..
  uni = bi[, .(count=.N), by = end]
  uni[, p_ikn:=count/sum(count)]
  
  # merge bigram and unigram
  bi_uni = merge(x=bi[, .(end, p_ikn)], y=uni[, .(end, p_ikn)], all=T, by="end")
  bi_uni[is.na(bi_uni)] = 0
  
  bi_uni[, p_ikn:=p_ikn.x + du_bi*p_ikn.y]
  
  # merge bigram and trigrams
  tri_bi = merge(t[, .(end, p_ikn)], bi_uni[, .(end, p_ikn)], all = T, by="end")
  
  tri_bi[is.na(tri_bi)] = 0
  tri_bi[, p_ikn:=p_ikn.x + du*tu/cu * p_ikn.y]
  
  tri_bi[order(-p_ikn), .(end)][1:min(3, .N), end]
}