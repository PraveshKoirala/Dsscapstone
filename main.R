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

initialized <- F

for (name in names(clean_chunks)){
  print (sprintf("Creating a corpus for %s", name))
  
  d <- na.omit(clean_chunks[[name]])
  
  grams <- bi_tri_grams(d)
  
  if (!initialized){
    trigrams <- grams$tri
    bigrams <- grams$bi
    initialized <- T
  }
  else {
    trigrams <- merge(trigrams, grams$tri, all = T)
    bigrams <- merge(bigrams, grams$bi, all = T)
    
    trigrams[is.na(trigrams)] <- 0
    bigrams[is.na(bigrams)] <- 0
    
    trigrams[, count := count.x + count.y]
    bigrams[, count := count.x + count.y]
    
    trigrams <- trigrams[, .(text, count)]
    bigrams <- bigrams[, .(text, count)]
  }
}

t_beginword <- sapply(strsplit(trigrams[, text], "_"), function(x){paste0(x[1:(length(x)-1)], collapse = "_")})
t_endword <- sapply(strsplit(trigrams[, text], "_"), function(x){paste0(x[length(x)], collapse = "_")})

b_beginword <- sapply(strsplit(bigrams[, text], "_"), function(x){paste0(x[1:(length(x)-1)], collapse = "_")})
b_endword <- sapply(strsplit(bigrams[, text], "_"), function(x){paste0(x[length(x)], collapse = "_")})

bigrams[, end:=b_endword][, text:=b_beginword]
trigrams[, end:=t_endword][, text:=t_beginword]

saveRDS(bigrams, file="bigrams.rds")
saveRDS(trigrams, file="trigrams.rds")
