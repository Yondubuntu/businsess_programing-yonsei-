## 데이터 구조 

## 데이터프레임 구조 

a <-  1 
a 
b <- "hello"
b
class(a) ## a class 확인 
class(b) ## b class 확인 

c <- c (1,2,'a','b') 
c
class(c) ## 벡터 한가지 변수타입으로 구성되어있어 character 로 표현 된다 . 

## Vatcor = 1차원 
x1 <-  data.frame(var1 = c(1,2,3),
                  var2 = c('a','b','c') , 
                  var3 = c(1,2,'a'))
x1 
class(x1) 

class(x1$var1) # var1 class : numeric
class(x1$var2) # var2 class : character
class(x1$var3) # var3  class : charcater 

## 데이터 프레임 = 2차원 

x2 <- matrix(1:12, ncol = 2 ) ## matrix 생성 column - 2 개 
x2
class(x2)
## 매트릭스 = 2차원 

## 어레이 다차원 

x3 <- array(1:20 , dim = c(2,5,2))## array 생성 , 2개의 행 2개의 칼럼  array 는 matrix 가여러개 
class(x3)

x4 <- list(f1 = a ,
           f2 = x1 ,
           f3 = x2 ,
           f4 = x3 )   ### list 생성 
x4
class(x4) ## x4 class 확인 

mpg <-as.data.frame(ggplot2 :: mpg) ## mpg 데이터 불러오기 

##리스트 다차원 서로 다른데이터 모든 구조 포함 


boxplot(mpg$cty) ## 상자 그리기 

x <-boxplot(mpg$cty) ## 박스 플랏 x 에 할당 
x    

class(x)## x class - llis t 
class(x$stats) ## x stats class - array matrix 
class(x$n) 


## 데이터 파악하기  
exam <- read.csv("csv_exam.csv") ## csv 읽어오기 
exam 
head(exam) ## exam 앞부분 데이터 구성되어있는지 확인가능하다 
head(exam,10) ## 앞부분에서 10개행을 보겠다 하면 볼수있다 
tail(exam) ## 끝부분을 보여줄수있다
tail(exam, 10) ## 뒤에서 부터 10개행을 보여줄수있다 
View(exam) ## 엑셀 처럼확인하기
dim(exam) ## 행 열 확인가능하다 . 

str(exam) ## 데이터 변수들의 속성을 확인할수있다 . 

summary(exam) ## 변수의 값들을 요약 통계량을 확인할수있다 . 최대 최소 1/4 3/4 분위 지점들확인 



head(mpg) ## 앞부분에서 데이터를 보겠다 
tail(mpg)
View(mpg)
dim(mpg) ## 234 행 11개 attribute
str(mpg)  ## 속성 마다 변수 확인가능 
summary(mpg) ## character 로 되어있으면 요약 통계가 따로 나오지않는다 

## 변수 명 바꿔주는 작업 함수들 rename -> packagae 설치부터 시작 

install.packages("dplyr") ## dplyr package 다운로드 
library(dplyr)

df_raw  <- data.frame(var1 = c(1,2,1),
                      var2 = c(2,3,2)) ## 데이터 만들기 
df_new <- df_raw 
df_new  ## 새로운곳에 데이터 할당 복사본 만들어주기 

df_new <- rename(df_new , v2 = var2) 
df_new

df_new <- rename(df_new , v1 =var1) ## 변수 명 var1 -> v1 으로 변경 
df_new
df_raw


## 파생 변수 만들기 

df <- data.frame(var1 = c(1,2,1),
                      var2 = c(2,3,2)) ## 데이터 만들기 

df$var_sum <- df$var1 + df$var2 ## sum 파생변수 만들기 
df 

df$var_mean <- df$var_sum/2  ## 평균 파생변수 만들기 

df

df$var_mean2 <- mean(df) ## 에러 발생 

df
## mpg 데이터로 활용해보기 

mpg$total <-(mpg$cty + mpg$hwy)/2 
View(mpg)
mean(mpg$total)
summary(mpg$total)
library(ggplot2)
qplot(mpg$total) ## 막대그래프으로 연속형 변수는 너무 세밀해진다 알기 모호해짐
hist(mpg$total) ## 빈도수 가 어느정도인지 확인할수있다 . 반드시 연속형이어야한다. 연속형아니면 에러값 발생 


##  조건문 사용하기 

mpg$test <- ifelse(mpg$total>=20, "pass" , "fail") ## 파생변수 pass fail 추가해주기 조건문 함수로 
View(mpg)

table(mpg$test) ## 빈도표 만들기 fail 몇개인지 pass 몇개인지 

qplot(mpg$test) ## 빈도수 만들기 
class(mpg$test)


## 중첩 조건 문 사용 하기 

mpg$grade <- ifelse(mpg$total >= 25 , "A",
                    ifelse(mpg$total>= 20 , "B","C")) ## 중첩 조건문으로 a,b,c등급 구분하기 
table(mpg$grade) ## 빈도표 확인하기 갯수로 확인하기 
qplot(mpg$grade) ## qp plot 으로 확인해보기 

mpg$grade2 <- ifelse(mpg$total >= 25 , "A",
                    ifelse(mpg$total>= 20 , "B",
                           ifelse(mpg$total >= 15 , "C" , "D")))
table(mpg$grade2)
qplot(mpg$grade2)



## 데이터 가공하기  데이터 전처리 하기 ## 

exam %>%  
  filter(class ==1)  ## 컨트로 쉬프트 m  1반 학생들만 추출 class -1 인 학생만 추출 

exam %>%  
  filter(class !=1) ## 1 반 핛생제외 하고 추출하기 
exam %>%  
  filter(math >50)  ##수학 점수 50점 초과인 학생만 추출하기 
exam %>%  
  filter(class == 1 & math >= 50 )
exam %>%  
  filter(english >=90 | math >= 90 | science >=90 ) ## 한과목이라도 90 점이상인 사람 추출하기 

exam %>%
  filter(class %in% c(1,3,5)) ## 매칭 연산자 

exam 

class1 <- exam %>%  
  filter(class ==1) ## class 1 반인 학생들 할당하기 
class1
mean(class1$math)

2**3 ## 제곱 계산하기 
7 %/% 3 # 몫 계산하기 
7%% 3  ## 나머지  계산기 

exam %>% 
   select (math)

exam %>% 
  select(class,math)    ## class 와 math 만 선택하기 

exam %>%  
  filter (class ==1 ) %>%  
  select(english) ##    1반 학생들의 영어 점수 확인하기 


exam %>%  
  select(id , math) %>% 
  head(5)                  ### 헤드로 1번부터 오름차순으로 math 점수 나열하기 

