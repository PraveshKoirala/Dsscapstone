source("readFiles.R")
source("getChunks.R")
source("cleanData.R")

data <- readFiles()
chunks <- getChunks(data, 50)

clean_chunks <- lapply(chunks, cleanData)

saveRDS(clean_chunks, file="clean_chunks.dat")