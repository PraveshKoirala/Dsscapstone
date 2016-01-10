cleanData <- function(data, tokenize=F){
  library(stringi)
  
  # tokenize, get all words down here
  data <- stri_trans_tolower(data)
  
  profanities_regex <- "(fuck|shit|piss|motherfuck|cocksuck)[^ $]*|cunt|dick"
  
  # everything except apostrophe for contractions
  punct_regex <- "(?!')[[:punct:]]"
  
  # Remove numbers, punctuations and profanities
  data <- stri_replace_all_regex(data, c("[0-9]+?", punct_regex,
                                         profanities_regex), "", vectorize_all = F)
  
  # Extract remaining words.. hopefully, they are clean.
  all_words <- stri_extract_all_words(data)
  if (tokenize)
    return(all_words)
  else
    return(sapply(all_words, function(c){stri_join(c, collapse=" ")}))
    
}