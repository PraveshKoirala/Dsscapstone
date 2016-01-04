readFiles <- function(){
  library(quanteda)
  
  tweets <- readLines("en_US/en_US.twitter.txt", encoding="UTF-8", skipNul = T)
  blogs <- readLines("en_US/en_US.blogs.txt", encoding="UTF-8")
  news <- readLines("en_US/en_US.news.txt", encoding="UTF-8")
  
  data <- c(tweets, blogs, news)
  data
  
}