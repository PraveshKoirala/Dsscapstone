bigrams <- readRDS("bigrams.rds")
trigrams <- readRDS("trigrams.rds")

t_midword <- sapply(strsplit(trigrams[, text], "_"), function(x){paste0(x[length(x)], collapse = "_")})

trigrams[, mid:=t_midword]

setkey(trigrams, text, end, mid )
setkey(bigrams, text)

N1 = nrow(trigrams[count==1])+1
N2 = nrow(trigrams[count==2])
N3 = nrow(trigrams[count==3])
N4 = nrow(trigrams[count==4])

Y = N1/(N1+2*N2)
D1 = 0.5
D1 = 1 - 2 * Y * N2/N1
D2 = 2 - 3 * Y * N3/N2
D3 = 3 - 4 * Y * N4/N3