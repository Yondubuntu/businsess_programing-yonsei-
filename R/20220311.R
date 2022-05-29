#####

a <- 1  # 변수  a 에  1을 할당 
b <- 2  # 변수  b 에 2를 할당 
c <- 3  #  
d <- 100
f <- a+b+d+100/2

income  <- c(100,200,500)
var1 <- c(1,2,5,7,8)
var2 <- c(1:5)
var3 <- c(1:5)

var4 <- seq(1,10,by =2 )

str <- "a"
str3 <- "Hello World"
str3 <- c("Hello" ,"world","is","good")

x <- c (1,2,3)
x_mean <- mean(x) ## 평균 값
x_max <- max(x)  ## 최대값
max(var1)
paste(str3, collapse = "/") ## /으로 구분하기 
paste_str3 <- paste(str3, collapse = " ") ## 빈칸으로 구분하기 


install.packages("ggplot2")

library(ggplot2)

x <- c("a","a","b","c")
x
qplot(x)
?qplot

english <- c(90, 50,100, 89)
math <- c(100,50,40,50)
class <- c(1,1,2,2)
class
df <- data.frame(english,math,class)
df

mean(df$math)
mean(df$english)

df2 <- data.frame(english = c(100,20,30,40),
                  math = c(50,50,40,30),
                  class = c(1,2,3,4)
                  )
df2 
install.packages("readxl")

library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
df_exam

mean(df_exam$english)
mean(df_exam$math)

df_exam_no <- read_excel("excel_exam_novar.xlsx",col_names = F)
df_exam_no  
df_exam_no_2 <- read_excel("excel_exam.xlsx",sheet = 2 )

df_exam_no_2


df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam

write.csv(df, file = "df_midtrem.csv")

var1 <- c(1,2,3,4,5)

var2 <- factor(c(1,3,3,2,3,5))
var1
var2
class(var1) ## var  1 타입 확인하기 
class(var2) ## var  2 타입 확인하기 

levels(var1)
levels(var2)

var3 <- c("a", "b", "d", "e")
var4 <- factor(c("a", "b", "b", "e"))

var3
var4

var2 <- as.numeric(var2) ## 해다당하는 타잎으로 변경 
mean(var2)

mpg
mpg <- as.data.frame(ggplot:mpg)## mpg 데이터 불러오기 package 다운없이 

?mpg
