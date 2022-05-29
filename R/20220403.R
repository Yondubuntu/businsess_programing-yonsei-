## 결측치 정제하기 
df <-data.frame(sex = c("M","F",NA ,"M","F"),
                score = c(5,4,3,2,NA)) ## 결측 치 넣어주기 

df # 문자열을 <> 를 통해서 표현 결측치 

is.na(df) ## TRUE FALES  로 결측치 인지 아닌지 파악 하기 

table(is.na(df)) ## 결측치 빈도 확인하기 
table(is.na(df$sex)) ## 특정 column 지정가능 

mean(df$score) ## 결측 치 있으면 값 nA 로 출력 

library(dplyr)

df %>% 
  filter(is.na(score))

df %>% 
  filter(!is.na(score))
df_nomiss <- df %>% 
  filter(!is.na(score)) ## 결측치 제거후 할당하기 

mean(df_nomiss$score)  ## 평균 구하기 
df_nomiss_all <- df %>% 
  filter(!is.na(score) & !is.na(sex))
df_nomiss_all

df_nomis_all_2 <- na.omit(df) ## 모든 결측 치 제거 하기 na.omit

df_nomis_all_2 


mean(df$score , na.rm = T)

df$score

exam <- read.csv("csv_exam_miss.csv") ## 결측 치 데이터 불럴오기 

exam

exam %>% 
  summarise(mean_math = mean(math,na.rm = T),
            sum_math = sum(math,na.rm = T),
            median_math = median(math,na.rm = T) ,
            n= n() )  ## 결측 치 지우고 평균값을  결정 가능 

## 결측을 했을때 평균값또는 다른 값으로 대체할때  방법  (데이터 대체)  ## 

# 1 평균값 대체 

math_mean <- mean(exam$math , na.rm = T)
exam$math <- ifelse(is.na(exam$math),math_mean , exam$math)

exam
table(is.na(exam$math))
mean(exam$math)
sum(exam$math)

## 이상치 정제하기 ## outlier: 정상 범주에서 크게 벗어난 값 ## 

outlier <-data.frame(sex = c(1,2,1,3,2),## sex = 1 or 2 
                score = c(5,4,3,2,6))   ## maxim score is 5 
outlier
table(outlier$sex) ## 빈도표로 확인하기 
table(outlier$score)

outlier$sex <- ifelse (outlier$sex == 3,NA,outlier$sex)
outlier
outlier$score <- ifelse (outlier$score >5 , NA , outlier$score )
outlier$score


outlier %>%  
  filter (!is.na(sex)  & !is.na(score)) %>% 
  group_by(sex) %>%  
  summarise(mean_score= mean(score))     ## 성별로 평균내기 

mean(outlier$score, na.rm  = T) ## maen 직접 구하기 


mpg <- as.data.frame(ggplot2::mpg)

boxplot(mpg$hwy) ## maximum 값보다 벗어난 값 두개를 볼수있다 . 

boxplot(mpg$hwy)$stats

mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37 , NA ,mpg$hwy)  ##결측치 처리 

mpg$hwy 

## 2 options 

table(is.na(mpg$hwy)) ## true false 확인하기 

#1 
mpg %>%  
  filter(!is.na(hwy)) %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

#2 
mpg %>%  
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy , na.rm =T))

## make Graph ## 

# 2D Graph Scatter plot - continuous results 

library(ggplot2)

ggplot(data = mpg, aes(x = displ , y = hwy)) ## x,y aes 사용 

ggplot(data = mpg, aes(x = displ , y = hwy)) +  # step 1 
  geom_point()+# step 2 3 rows containing missing values
  xlim(3,6) +## 105 rows missing 
  ylim(12,30)
  
## bar Graph 

library(dplyr)

df_mpg <- mpg%>%  
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy,na.rm = T))

df_mpg  

ggplot(data = df_mpg ,aes(x = drv, y = mean_hwy)) + 
  geom_col()
## reorder func 사용 해서 순선대로 만들어주기 (오름 차순 )
ggplot(data = df_mpg ,aes(x = reorder(drv,mean_hwy), y = mean_hwy)) + 
  geom_col()
## reorder func 사용 해서 내림차순 
ggplot(data = df_mpg ,aes(x = reorder(drv,-mean_hwy), y = mean_hwy)) +  geom_col()

## 빈도 막대 그래프 

ggplot(data = mpg, aes(x=drv))+ 
  geom_bar() ## x 축 만 지정하면 된다 
qplot(mpg$drv)



?economics


ggplot(data = economics , aes(x = date ,y =unemploy))+ 
  geom_line() ## 실업 률 그래프 
economics

ggplot(data = mpg, aes (x = drv , y = hwy))+ 
  geom_boxplot()  


## 분류에 따라 분포 박스플롯을 만들수 있다 . 













