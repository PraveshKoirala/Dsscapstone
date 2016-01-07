source("readFiles.R")
source("getChunks.R")
source("cleanData.R")
source("ngrams.R")

data <- readFiles()
chunks <- getChunks(data, 0)

clean_chunks <- lapply(chunks, cleanData)

saveRDS(clean_chunks, file="clean_chunks.rds")

trigrams <- list()
bigrams <- list()

addNgram <- function (d){
  d <- sapply(d, function(c){stri_join(c, collapse=" ")})
  grams <- bi_tri_grams(d)
  trigrams <- list(trigrams, list(grams$tri))
  bigrams <- list(bigrams, list(grams$bi))
  gc()
}

grams <- lapply(clean_chunks, addNgram)
