## 순서대로 정렬하기 


## dplyr 패키지에서 arragnnge 함수 사용 

exam <- read.csv("csv_exam.csv") ## exan 데ㅇ
exam ## exam 데이터 확인하기 

library(dplyr)

exam %>% 
  arrange(math) ## 수학점수대로 오름차순 정렬 

exam %>%  
  arrange(desc(math)) ## 수학 점수 내림 차순 정렬 

exam %>%  
  arrange(-math) ## 수학 점수 내림 차순 정렬 

exam %>% 
  arrange (class ,math ) ## class 정렬 후 math 점수 정렬

exam %>% 
  arrange(math,class) ## math 정렬후 class 정렬 

## total 파생 변수 생성 

exam %>%  
  mutate(total = math + english + science) 

## mutat 는 읽어 주기만 

exam <- exam %>%  
  mutate(total = math + english + science)  ## 할당 해주기 

exam <- read.csv("csv_exam.csv")

exam <- exam %>%  
  mutate(total = math + english + science,
         meam = (math + english + science) /3) ## 두가지 파생 변수 추가 

## pass fail 파생 변수 추가 
exam %>%  
  mutate(test  = ifelse(science >= 60,"pass" ,"fail"))

## total 파생 변수 추가 후 바로 오름 차순 정렬 가능 

exam %>%  
  mutate(total =math + english + science) %>%  
  arrange(total) 

exam %>%  
  mutate(total =math + english + science) %>%  
  arrange(total) %>% 
  head ## 하위 앞부분 보여주는 함수 


exam %>%  
  mutate(total =math + english + science) %>%  
  arrange(-total) %>% 
  head (5) # 상위 5등까지 보여주기 

exam %>%  
  group_by(class)  ## 범주형 변수로 묶어주는 역할 

exam %>%  
  summarise(mean_math=mean(math)) ## 수학점수 평균 구하기 

## 반별 그룹 바이후 수학 평균 구핟끼

exam %>%  
  group_by(class) %>% 
  summarise(mean_math=mean(math)) ## 각반 마다 수학 평균 구하기 

exam %>%  
  group_by(class) %>% 
  summarise(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n =n()) 


## mean 평균
## sum 합계 
## media 중앙값
# n() ㅣ빈도 () 안에 class 필요  x   
# sd 표준편차 
## min 최소 
## max 최대 
## A tiblle : 데이터 가 5행 2열  tibble 특징 데이터 타입 보여준다 



mpg <- as.data.frame(ggplot2::mpg)

mpg %>%  
  group_by(manufacturer ,drv) %>%  
  summarise(mean_city = mean(cty)) %>%  
  head(10)
## 회사 별로 "suv" 자동차의 도시 및 고속도로 통합 연비  
## 평균을 구해 내림차순으로 상위 1~ 5위까지 출력 

mpg %>%  
  group_by(manufacturer) %>%
  filter(class == "suv") %>% 
  mutate(tot = (cty +hwy)/2) %>%  
  summarise(mean_tot = mean(tot)) %>%  
  arrange(-mean_tot) %>%  
  head(5) %>% 
  select(manufacturer)



## 데이터 합치기 
test1 <- data.frame( id =c(1,2,3,4,5),
                     mid =c(19,20,30,40,50))
test2 <- data.frame( id =c(1,2,3,4,5),
                     fin =c(19,20,30,40,50))

test1 
test2

total <- left_join(test1,test2, by = "id")
## id 왼쪽 값을 기값 으로 데이터 join 하기
total2 <-left_join(test2,test1,by = "id")
total2

test3 <-test2 %>%  
  arrange(-id)

exam
name <- data.frame(class = c(1,2,3,4,5),
                   teacher = c("aa","bb","cc","dd","ee"))

exam_name <- left_join(exam,name, by = "class")

total
exam_name

group_a <-data.frame(id =c(1,2,3,4,5),
                     test=c(65,51,13,31,35))

group_b <-data.frame(id =c(6,7,8,9,10),
                     test=c(65,51,13,31,35))

group_all <- bind_rows(group_a , group_b)

group_all

exam[1,] ## 첫번쨰행 추출 
exam[,1] ## 첫번째 열 추출 

exam [5,5] ##  5행 5열 값 추춣 

exam [exam$class == 1, ] ## class 1반 추출 

exam %>% 
  filter(class == 1 )
exam [exam$class == 1 & exam$math >50,  ] 
exam %>% 
  filter(class == 1 & math >50 )
exam [exam$class >=80 | exam$english >=80 | 
        exam$science>= 80,]
exam[,2]
exam[,"class"]
exam

exam %>%  
  select( math, english, science)

exam [9,"math"]
exam[exam$math >=50 ,"english"]
exam[exam$math >=50 ,c("english","science")]


## 파생 변수 두가 지 
exam$total <- exam $math +exam$science + exam$science
exam

exam %>% 
  mutate(total = math +english +science)

## apply 함수 
## 1 -> 행 방향 더하기 

exam$total2 <- apply(exam,1,sum)
exam$total3 <- apply(exam[,c(3:5)],1,sum) ## 1 -> 행 방향 더하기 

exam
## 열 방향 더하기 
apply(exam,2,sum) ## 열 방향 더하기 

apply(exam,2,mean)

## 에러 발생시  

#변수 명 , 오타 , dataframe 정확히 있는지 # 

## 코드가 완성이 안되면 esc 만들시에 나온다 

## "+ 나오면 서 어디가 문제인지 나온다  


## "not found " "not find"  일시에 

## package load 정확하게 되어있느지 

## 비교 연산자일때 등호 갯수 조심 

##  따오몸표 확인하기 

## 데이터프레임 확장자 명 확인하기 및 파일경로 정확히 확인하기 

## 들여쓰기 에러 


## 비슷한 숫자 기호 비교하기  1 I L i |  , o 0 O o  


## warning message vs Error mesage 차이 정확하게 차이 다른점 알기 









