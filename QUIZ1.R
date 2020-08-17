con <- file("en_US.twitter.txt", "r")
readLines(con, 5)  ## Read the first line of text readLines
close(con)

#q1: The en_US.blogs.txt  file is how many megabytes?
file.info("en_US.blogs.txt")$size/1024/1024

#q2. The en_US.twitter.txt has how many lines of text?
library(R.utils)
countLines("en_US.twitter.txt") 
length(readLines("en_US.twitter.txt"))

#q3. What is the length of the longest line seen in any of the three en_US data sets?
summary(nchar(readLines(file("en_US.twitter.txt","r"))))
summary(nchar(readLines(file("en_US.blogs.txt","r"))))
summary(nchar(readLines(file("en_US.news.txt","r"))))


#q4. In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?
love <- grep(pattern = "love", x= readLines("en_US.twitter.txt"))
hate <- grep(pattern = "hate", x= readLines("en_US.twitter.txt"))
length(love)/length(hate)

#q5. The one tweet in the en_US twitter data set that matches the word "biostats" says what?
grep(pattern = "biostats", x= readLines("en_US.twitter.txt"), value = TRUE)

#q6.How many tweets have the exact characters "A computer once beat me at chess, but it was no match for me at kickboxing". (I.e. the line matches those characters exactly.)
length(grep(pattern = "A computer once beat me at chess, but it was no match for me at kickboxing", x= readLines("en_US.twitter.txt")))




