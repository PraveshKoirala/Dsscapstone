require(stringi)
require(data.table)

source("choose_grams.R")
source("cleanData.R")
#source("loaddata.R")

predict_unigram <- function(x_vector){
  return (data.table(end="the"))
}

predict_bigram <- function(x){
  
  #print ("At predict_bigram")
  
  # at this point, bigram table is already loaded
  if (!exists("bigrams")){
    bigrams = readRDS("bigrams.rds")
  }
  l <- length(x)
  
  d <- x[l]
  
  d <- paste0(d, collapse="_")
  
  bigrams[d][order(-count), .(end, count)]
}

predict_trigram <- function(x){
  
  #print ("At predict trigram")
  
  if (!exists("trigrams")){
    trigrams = readRDS("trigrams.rds")
  }

  l <- length(x)
  
  d <- x[(l-1):l]
  
  d <- stri_join(d, collapse="_")
  
  
  trigrams[d][order(-count), .(end, count)]
  
}


predict <- function(x){
  
  # x is a string that represents the preceding words.
  # if x ends on a space, we give a new word, else we give a word beginning
  # with that letter.
  
  # when in doubt, return "the"
  if (!is.character(x)| length(x) == 0) return ("the")
  
  x_vector <- cleanData(x, tokenize=T)[[1]]
  
  if (any(is.na(x_vector))) return ("the")
  
  gram <- length(x_vector)
  
  t <- b <- u <- NULL
  
  if (gram > 1){
    t <- predict_trigram(x_vector)
  }
  if (gram > 0){
    b <- predict_bigram(x_vector)
  }
  u <- predict_unigram(x_vector)
  
  return (choose_grams(t, b, u, x_vector))
}

