# wd
setwd('C:/Users/WIPS/Downloads')
library(readxl)

# read datas
dat9=read_xlsx('상품해설서_9류.xlsx')
dat11=read_xlsx('상품해설서_11류.xlsx')
dat16=read_xlsx('상품해설서_16류.xlsx')
dat21=read_xlsx('상품해설서_21류.xlsx')
dat25=read_xlsx('상품해설서_25류.xlsx')
dat41=read_xlsx('상품해설서_41류.xlsx', sheet='41류')

df=read_xlsx('전체목록.xlsx')
dim(df) # 56382     5

# 지정상품 영문, 국문 모두 일치하는 경우는 del

for (i in c(9, 11, 16, 21, 25, 41)) {
  dat <- get(paste0("dat", i))  # Retrieve the data frame dynamically
  
  for (j in 1:nrow(dat)) {
    df <- subset(df, !(`지정상품(국문)` == dat$`지정상품명(한글)`[j] & `지정상품(영문)` == dat$`지정상품명(영문)`[j]))
  }
}


# df를 20개 단위로 자르기
library(dplyr)
table(df$NICE분류)



# Splitting the dataframe into chunks based on NICE분류
Split1<-split(df, df$NICE분류)


# Make into file chunk 20 rows
setwd('C:/Users/WIPS/Downloads/splitfile')
# Number of rows in each chunk
chunk_size <- 20
library(writexl)

for (i in 1:45){
  df2 = Split1[[i]]
  
  for (j in seq(1, nrow(df2), chunk_size)) {
    chunk <- slice(df2, j:(j + chunk_size - 1))
    
    # File name
    start_row <- j
    end_row <- min(j + chunk_size - 1, nrow(df2))
    file_name <- sprintf("%02d-%02d-%02d.xlsx", i,start_row, end_row)
    
    # Save dataframe to Excel file
    write_xlsx(chunk, path = file_name)
  }
  
}



