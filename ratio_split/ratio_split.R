rm(list=ls())
# read data
df=read.csv('C:/Users/WIPS/Downloads/data45.csv', fileEncoding = 'EUC-KR')

# wips 선 배정
df$company = ifelse(df$상품해설서 > 0 , 'wips', NA)

# 남은 데이터
library(dplyr)

df2= df[df$상품해설서 == 0,]

sum(df2$검색결과)



# Define the data
data <- c(2479, 451, 1535, 330, 2314, 1558, 2557, 1010, 2823, 1398, 329, 478, 223, 569, 556, 1042, 1073, 319, 110,
          412, 343, 132, 1477, 1342, 1331, 715, 357, 187, 164, 1403, 1381, 2369, 1633, 930, 1027, 2595, 365, 1120, 648)

# Calculate the sum of the data
sum_data <- sum(data)

# Calculate the sum of ratio of 12894:28191
sum_ratio <- sum_data * 12894/41085

# Randomly split the data into two sets with a sum of ratio of 10:13
set1 <- numeric(length(data))
set2 <- numeric(length(data))
sum_set1 <- 0
sum_set2 <- 0
for (i in sample(length(data))) {
  if (sum_set1 + data[i] <= sum_ratio) {
    set1[i] <- data[i]
    sum_set1 <- sum_set1 + data[i]
  } else {
    set2[i] <- data[i]
    sum_set2 <- sum_set2 + data[i]
  }
}

# Remove any empty elements from the sets
set1 <- set1[set1 != 0]
set2 <- set2[set2 != 0]

# Print the sets and their sums
print(set1)
print(sum(set1))
print(set2)
print(sum(set2))

# 윕스&진흥원 할당
df2[df2$검색결과 %in% set1,]$company <- 'wips'
df2[df2$검색결과 %in% set2,]$company <- '진흥원'
print(df2)

df[df$상품해설서 == 0,]$company <- df2$company


# wips 총 개수 : 33047
df %>%
  filter(company == 'wips') %>%
  summarise(sum_result = sum(검색결과))
# 진흥원 개수 : 23335
df %>%
  filter(company == '진흥원') %>%
  summarise(sum_result = sum(검색결과))

# write.csv
write.csv(df, 'df1_1.csv', row.names=F, fileEncoding = 'cp949')



