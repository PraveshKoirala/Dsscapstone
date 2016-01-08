# create ngrams using quanteda

library(quanteda)
require(data.table)

bi_tri_grams <- function(d){
  # d is a character vector
  
  c <- corpus(d)

  bigrams <- dfm(c, ngrams=2)
  trigrams <- dfm(c, ngrams=3)
  
  bigram_freq_table <- colSums(sort(bigrams))
  trigram_freq_table <- colSums(sort(trigrams))
  
  bigram_freq_table <- data.table(text=names(bigram_freq_table), 
                                  count=bigram_freq_table, key = "text")
  trigram_freq_table <- data.table(text=names(trigram_freq_table), 
                                   count=trigram_freq_table, key = "text")
  
  list(bi=bigram_freq_table[count>1], tri=trigram_freq_table[count>1])
  
}