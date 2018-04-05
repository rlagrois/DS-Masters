setwd("D:/SMU/qtw/case3/")


#put in data
online <- readData("online.final.trace.txt")
head(online)
offline <- readData("offline.final.trace.txt")
head(offline)


#Get nearest K
get_k_nearest <- function(query, examples, k, target_column_index) {
  X = examples[,-target_column_index]
  y = examples[,target_column_index]
  #calculate distances between the query and each example in the examples
  dists = apply(X, 1, function(x) { sqrt(sum((x-query)^2)) })
  # sort the distances and get the indices of this sorting
  sorted_dists = sort(dists, index.return = T)$ix
  # choose indices of k nearest
  k_nearest = sorted_dists[1:k]
  candidates = y[k_nearest]
  # get the most frequent answer
  result = get_mode(candidates)
  return(result)
}
  
#to be anaylized and analysis
tail(online)
query = c(offline)
example = matrix(offline,nrow=53302,ncol=9)
both = c(online,offline)


get_k_nearest(query, example,15, 1)

results
