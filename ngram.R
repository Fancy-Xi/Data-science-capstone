
#title: "Prediction for shiny"
#author: "Xi Fang"
#date: "8/19/2020"
#output: github_document

        


bigram_w <- readRDS("bigram_w.rds")
trigram_w <- readRDS("trigram_w.rds")
quadigram_w <- readRDS("quadgram_w.rds")
quintigram_w <- readRDS("quintgram_w.rds")



## Create prediction model

bigram <- function(input_words){
        num <- length(input_words)
        filter(bigram_w, 
               word1==input_words[num]) %>% 
                top_n(1, n) %>%
                filter(row_number() == 1L) %>%
                select(num_range("word", 2)) %>%
                as.character() -> out
        ifelse(out =="character(0)", "?", return(out))
}


trigram <- function(input_words){
        num <- length(input_words)
        filter(trigram_w, 
               word1==input_words[num-1], 
               word2==input_words[num])  %>% 
                top_n(1, n) %>%
                filter(row_number() == 1L) %>%
                select(num_range("word", 3)) %>%
                as.character() -> out
        ifelse(out=="character(0)", bigram(input_words), return(out))
}


quadgram <- function(input_words){
        num <- length(input_words)
        filter(quadgram_w, 
               word1==input_words[num-2], 
               word2==input_words[num-1], 
               word3==input_words[num])  %>% 
                top_n(1, n) %>%
                filter(row_number() == 1L) %>%
                select(num_range("word", 4)) %>%
                as.character() -> out
        ifelse(out=="character(0)", trigram(input_words), return(out))
}




##  User input

ngrams <- function(input){
        # Create a dataframe
        input <- data_frame(text = input)
        # Clean the Inpput
        replace_reg <- "[^[:alpha:][:space:]]*"
        input <- input %>%
                mutate(text = str_replace_all(text, replace_reg, ""))
        # Find word count, separate words, lower case
        input_count <- str_count(input, boundary("word"))
        input_words <- unlist(str_split(input, boundary("word")))
        input_words <- tolower(input_words)
        # Call the matching functions
        out <- ifelse(input_count == 1, bigram(input_words), 
                      ifelse (input_count == 2, trigram(input_words), quadgram(input_words)))
        # Output
        return(out)
}


