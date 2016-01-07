# create ngrams using quanteda

library(quanteda)

bi_tri_grams <- function(d){
  # d is a character vector
  
  c <- corpus(d)

  bigrams <- dfm(c, ngrams=2)
  trigrams <- dfm(c, ngrams=3)
  
  bigram_freq_table <- colSums(sort(bigrams))
  trigram_freq_table <- colSums(sort(trigrams))
  
  list(bi=bigram_freq_table, tri=trigram_freq_table)
  
}