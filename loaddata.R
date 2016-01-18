bigrams <- readRDS("bigrams.rds")
trigrams <- readRDS("trigrams.rds")

t_midword <- sapply(strsplit(trigrams[, text], "_"), function(x){paste0(x[length(x)], collapse = "_")})

trigrams[, mid:=t_midword]

setkey(trigrams, text, end, mid )
setkey(bigrams, text)
