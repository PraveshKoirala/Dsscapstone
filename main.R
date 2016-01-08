source("readFiles.R")
source("getChunks.R")
source("cleanData.R")
source("ngrams.R")

data <- readFiles()

chunks <- getChunks(data, 100)
rm('data')

clean_chunks <- lapply(chunks, cleanData)
rm('chunks')

saveRDS(clean_chunks, file="clean_chunks.rds")

trigrams <- list()
bigrams <- list()

for (name in names(clean_chunks)){
  print (sprintf("Creating a corpus for %s", name))
  
  d <- na.omit(clean_chunks[[name]])
  
  grams <- bi_tri_grams(d)
  trigrams <- list(trigrams, list(grams$tri))
  bigrams <- list(bigrams, list(grams$bi))
  gc()
}
