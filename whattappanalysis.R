library(ggplot2)
library(tm)
library(wordcloud)
library(syuzhet)
library(SnowballC)

#
texts= readLines("WhatsApp Chat with Ppp.txt")


#View(texts)
docs= Corpus(VectorSource(texts))

#clean our chaat data
trans= content_transformer(function(x, pattern) gsub(pattern, "",x))
docs= tm_map(docs, trans,"/")
docs= tm_map(docs, trans,"@")
docs= tm_map(docs, trans,"\\|")
docs= tm_map(docs, content_transformer(tolower))
docs= tm_map(docs, removeNumbers)
docs= tm_map(docs, removeWords, stopwords("english"))
docs= tm_map(docs, removePunctuation)
docs= tm_map(docs, stripWhitespace)
docs= tm_map(docs, stemDocument)

#create the document term matrix
dtm = TermDocumentMatrix(docs)
mat = as.matrix(dtm)
v = sort(rowSums(mat),decreasing = T)

#data frames
d = data.frame(word= names(v), freq = v)
head(d, 10)

#generate the word cloud
set.seed(1056)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,max.words = 300, random.order = F,rot.per = 0.35, colors = brewer.pal(8,"Dark2"))
