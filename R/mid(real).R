#1.1 ggplot2 패키지 안에 있는 실습데이터 msleep를 df_ms라는 이름의 데이터 프레임 형태로 불러오세요.

df_ms <-as.data.frame(ggplot2::msleep)
View(df_ms)



#1.2 msleep의 도움말(매뉴얼)을 살펴보세요. 데이터와 각 변수에 대한 설명을 보고 정리해서 주석으로 남기도록 하세요. 참고로 ggplot2패키지를 로드하지 않았다는 가정 하에 진행하세요.

?msleep

#name - common name 
#vore - 육식, 초식 , 잡식 , 모름  
#conservation - 동물 보존상태 
#sleep_total - 총수면량 (시간단위 )
#sleep_rem - 램 수면시간(시간단위)
#sleep_cycle - 수면 주기 길이 (시간단위)
#awake -깨어 있는 시간(시간단위)
#brainwt - 뇌의 무게 (kg 단위)
#bodywt - 몸통 무게 (kg 단위 ) 

#1.3 데이터 파악하기에서 배운 모든 함수를 사용해서 데이터를 파악하세요. 이때 출력된 결과를 보고 파악한 내용을 간단히 주석으로 남기도록 하세요. 특히 각 변수의 데이터 타입을 반드시 확인하여 기재하세요.

head(df_ms) ## 앞부분에서 5개의 행 데이터를 보겠다 
tail(df_ms) ## 마지막 데이터 5개의 행데이터를 보여준다 
View(df_ms) ## 엑셀 형식으로 보여준다 
dim(df_ms) ## 83행 11 개 attribute
str(df_ms)  ## 속성 마다 변수 확인가능  

summary(df_ms) 
## df_ms  값의 최대 최소 3/4 지점을 확인할수있다 . 

#gensu,vore, order, conservation, name => chr 
#sleep_total,sleep_rem,sleep_cycle,awake,brainwt,bodywt => num 


#2.1 모든 변수에 대하여 각각 결측치가 있는 변수인지 확인하세요. 

table(is.na(df_ms$name)) ## 결측 치 x 
table(is.na(df_ms$genus)) ## 결측 치 x 
table(is.na(df_ms$conservation))  ## 결측치 29개
table(is.na(df_ms$order))  ## 결측 치 x 
table(is.na(df_ms$vore)) ## 결측치 7개 

table(is.na(df_ms$sleep_total)) ## 결측 치 x 
table(is.na(df_ms$sleep_rem)) ## 결측치 22개 
table(is.na(df_ms$sleep_cycle)) ## 결측치 21개 
table(is.na(df_ms$brainwt)) ## 결측치 27개 
table(is.na(df_ms$bodywt))  ## 결측 치 x 
table(is.na(df_ms$awake))  ## 결측 치 x 



#2.2 문자열(chr)로 되어 있는 변수 중에 결측치가 있는 변수에 대해서 결측치들을 "unknown"으로 변환하세요.

#문자열(chr)로 되어 있는 변수 중에 결측치 = > conservation , vore 변수 
# Conservation 결측치 unknown 으로 변경
df_ms$conservation <- ifelse(is.na(df_ms$conservation), "unknown" , df_ms$conservation)

#  Vore 결측치 unknown 으로 변경 
df_ms$vore <- ifelse(is.na(df_ms$vore), "unknown" , df_ms$vore)

View(df_ms)


#2.3 극단치가 있는지 확인이 필요한 모든 변수에 대해 각각 극단치를 확인하세요.

boxplot(df_ms$sleep_total) ## 극단치 존재  x 
boxplot(df_ms$sleep_rem) ## 극단치 존재 
boxplot(df_ms$sleep_cycle) ## 극단치 존재 

boxplot(df_ms$awake) ## 극단치 존재  x 

boxplot(df_ms$bodywt) ## 극단치 존재 
boxplot(df_ms$brainwt) ## 극단치 존재 

#2.4 극단치가 있는 변수 중 무게(wt)와 관련된 변수는 이 작업을 할 필요가 없습니다. 나머지 극단치가 있는 변수에 대해서 결측치 처리를 한 뒤, 결측치의 수를 확인하세요. 
boxplot(df_ms$sleep_rem)$stats # 극단치 확인
df_ms$sleep_rem <- ifelse(df_ms$sleep_rem > 4 , NA , df_ms$sleep_rem) 
# 4초과 이면 결측 치 처리 
table(is.na(df_ms$sleep_rem)) # 결측치 25개 확인 

boxplot(df_ms$sleep_cycle)$stats # 극단치 확인
df_ms$sleep_cycle <- ifelse(df_ms$sleep_cycle > 1.0 , NA ,  df_ms$sleep_cycle)
#1.0 초과이면 결측치 처리 

table(is.na(df_ms$sleep_cycle)) # 결측치 53개 확인 


#3.1 총수면량에서 렘(rem)수면량을 제외한 비렘수면량(sleep_nonrem)을 파생변수로 만들어 보세요.

df_ms$sleep_nonrem <- (df_ms$sleep_total - df_ms$sleep_rem)
# total - rem = nonrem 공식 활용한 파생변수 할당 

View(df_ms)


#3.2 총수면량과 렘(rem)수면량, 비렘수면량에 대해서 분 단위(in hours to minutes)로 계산된 파생변수를 각각 만들어 보세요.(기존 변수명 뒤에 '_min'을 붙이세요). 시간 단위로 되어 있는 변수를 분 단위 변수로 변경할 때 수식에 유의하도록 하세요.

df_ms$sleep_total_min <- (df_ms$sleep_total*60) 
#total(hour) *60 -> total_min

df_ms$sleep_rem_min <- (df_ms$sleep_rem*60)
#rem(hour) *60 -> rem_min

df_ms$sleep_nonrem__min <- (df_ms$sleep_nonrem*60)
#nonrem(hour) *60 -> nonrem_min 

View(df_ms)


#4.1 식성 구분(육/잡/초/충/모름)이 들어 있는 변수의 각 식성별 빈도수를 빈도표로 확인해보세요.
library(dplyr)

df_ms %>% 
  group_by(vore) %>%  # 식성으로 그룹바이 
  summarise(n=n()) # 식성별 빈도수 확인 


#4.2 잡식동물(omni)의 총수면량(분 단위), 렘수면량(분 단위), 비렘수면량(분 단위)을 추출해보세요.
df_ms %>%  
  filter(vore =="omni") %>% ## 잡식동물 만 추출 %>% 
  summarise(sleep_total_min_omni = sum(sleep_total_min,na.rm = T) ## 총수면량(분 단위) 결측치 제거 
            ,sleep_rem_min_omni = sum(sleep_rem_min,na.rm = T) ## 렘수면량(분 단위) 결측치 제거 
            ,sleep_nonrem__min_omni = sum(sleep_nonrem,na.rm = T) ) ##비렘수면량(분 단위) 결측치 제거 

View(df_ms)

#4.3 식성 구분(육/잡/초/충/모름)별로 총수면량(시간 단위)의 평균을 구해보세요.

df_ms %>% 
  group_by(vore) %>% ## 식성별 추출 
  summarise(mean_sleep_total = mean(sleep_total,na.rm =T)) ## 평균  치 계산 및 결측치 제거 


#4.4 식성 구분(육/잡/초/충/모름)별 총수면량(분 단위)을 막대그래프로 나타내보세요. 이때 막대그래프는 평균이 높은 순으로 보여지게 하세요.

library(ggplot2) ## 라이브러리 불러오기  ggplot2 

df_ms_sleep_total <-df_ms %>%  #sleep_total 에 할당 
  group_by(vore) %>%  # 식성별 그룹화 
  summarise(mean_sleep_total_min = mean(sleep_total_min,na.rm =T)) %>% # 결측치 제거 및 평균 
  arrange(-mean_sleep_total_min) # arrange 하기 

df_ms_sleep_total
## 막대 그래프 만들기 
ggplot(data = df_ms_sleep_total , aes(x = reorder(vore,-mean_sleep_total_min) ,
                              y = mean_sleep_total_min))+
  
  geom_col()

#x에 mean sleep_total 순으로 배열 

View(df_ms)

#5.1 멸종 위협받는 종에 대한 정보가 들어 있는 칼럼을 factor 타입으로 변환한 뒤, 변환된 데이터 타입을 확인해보세요.

df_ms$conservation <-as.factor(df_ms$conservation) ## conservation 항목 factor 타입 변환 

df_ms$conservation
class(df_ms$conservation) ## 타입 확인 

#5.2 위의 변수가 어떠한 범주로 되어 있는지 적절한 함수를 사용해서 확인하세요.

summary(df_ms$conservation) ## cd, domesticated ,en ,lc ,nt ,unknown, vu 로 나눠짐 

#5.3 아래의 표는 멸종 위협에 대해서 High와 Low, Non으로 구분한 표입니다. red_list라는 이름의 데이터 프레임으로 만들어보세요.

red_list = data.frame(conservation = c("en","vu","nt","cd","lc","domesticatd"),
                      risk = c("high","high","low","low","low","non")) 

#데이터 프레이 만들기 

red_list


#5.4 red_list 데이터 프레임을 활용하여 df_ms 데이터에 risk 라는 변수가 오른쪽에 파생변수로 추가되도록 하세요.

View(df_ms)

df_ms<-df_ms %>%  
  mutate(left_join(df_ms,red_list, by = "conservation")) ##coservation 항목으로 이어붙이기 

View(df_ms)

#5.5 멸종 위기 수준(high/low/non)에 따라 깨어있는 시간의 평균, 중앙값, 최소값, 최대값, 빈도를 구해보세요.

df_ms %>% 
  group_by(risk) %>%  # 멸종위기 수준 별로 묶기 
  summarise(mean_awake_time = mean(awake),#깨어있는 시간의 평균
            median_awake_time = median(awake),#깨어있는 시간의 중앙값
            min_awake_time = min(awake), #깨어있는 시간의 최소값,
            max_awake_time = max(awake), #깨어있는 시간의 최대값
            n =n()) #깨어있는 시간의 빈도

  
#5.6 멸종 위기 수준(high/low/non)에 따라 렘수면(분 단위)의 평균, 중앙값, 최소값, 최대값, 빈도를 구해보세요.

df_ms %>% 
  group_by(risk) %>% # 멸종위기 수준 별로 묶기 
  summarise(mean_rem_min = mean(sleep_rem_min,na.rm =T),#렘수면(분 단위)의 평균
            median_rem_min = median(sleep_rem_min,na.rm =T),#렘수면(분 단위)의 중앙값
            min_rem_min = min(sleep_rem_min,na.rm =T), #렘수면(분 단위)의 최솟값 
            max_rem_min = max(sleep_rem_min,na.rm =T), #렘수면(분 단위)의 최대값 
            n =n()) #렘수면(분 단위)의 빈도  

#6.1 가축(domesticated)만 추출해서 몸무게(x축)와 뇌 무게(y축)를 산점도로 나타내보세요.

df_ms_domesticated <- df_ms %>% filter(conservation == "domesticated") ## 가축(domesticated)만 추출

df_ms_domesticated

ggplot(data= df_ms_domesticated , aes(x =bodywt , y = brainwt))+  ## 산점도 그림 그리기  
  geom_point()

#6.2 몸무게 중 뇌 무게의 백분율을 나타내는 brain_ratio 라는 파생변수를 만들어보세요. 백분율에 유의하세요.

# 몸무게 중 뇌 무게의 백분율을 나타내는 brain_ratio 공식
df_ms$brain_ratio <- (df_ms$brainwt/df_ms$bodywt *100) ## brain_ratio파생변수 추가 

View(df_ms)


#6.3 식성 구분(육/잡/초/충/모름)별 뇌무게 백분율을 막대그래프로 나타내보세요. 이때 막대그래프는 평균이 높은 순으로 보여지게 하세요.

df_ms_brainratio <-df_ms %>% 
  group_by(vore) %>% ## 식성별 그룹화 
  summarise(mean_brain_ratio = mean(brain_ratio,na.rm =T)) %>% # 뇌무게 백분율 계산 및 결측치 제거 
  arrange(-mean_brain_ratio)

df_ms_brainratio

#막대그래프는 평균이 높은 순
ggplot(data = df_ms_brainratio , aes(x = reorder(vore,-mean_brain_ratio),
                                     y = mean_brain_ratio))+ 
  geom_col()

#7.1 제공된 mammal_theria CSV파일을 불러오세요. (변수명 일부가 깨져서 나온다면 fileEncoding="UTF-8-BOM" 파라미터를 설정하세요.)


mammal_theria <- read.csv("Desktop/2022-1-business-programming/mammal_theria.csv",fileEncoding = "UTF-8-BOM")
# mammal_theria CSV파일을 불러오기 및 utf-8 파라미터 설정 


mammal_theria

#7.2 df_ms 데이터에 두 분류 칼럼 theria_main와 theria_sub이 오른쪽에 파생변수로 추가되도록 하세요.

library(dplyr) 

#  theria_main와 theria_sub order 로 연결하기 
df_ms<-df_ms %>%  
  mutate(left_join(df_ms,mammal_theria, by = "order")) 


View(df_ms)


#7.3 로라시아상목(Laurasiatheria)과 영장상목(Euarchontoglires)만 추출하여 가장 많은 분류명(order)을 5개 출력하세요. 이때 상위 5위부터 상위 1위까지 순서로 보여지도록 하세요.

df_ms %>% 
  group_by(order) %>% #  분류명(order) 으로 구분하기 
  filter(theria_sub == "Laurasiatheria" | theria_sub == "Euarchontoglires") %>% 
  #로라시아상목(Laurasiatheria)과 영장상목(Euarchontoglires)만 추출
  summarise(n=n()) %>% # 빈도추출 
  arrange(n) %>% # 나열 
  tail(-6) # 상위 5위부터 상위 1위 나열 

#8.1 총수면량(시간 단위)을 아래와 같이 구분하는 sleep_grade 변수를 추가하세요. 각각 몇 동물씩 있는지 빈도표를 확인해보세요.

df_ms$sleep_grade <- ifelse(df_ms$sleep_total >= 15 ,"A", # 15시간이상 A 
                            ifelse(df_ms$sleep_total >= 10 ,"B" ,# 10시간이상 15시간 미만 B 
                                   ifelse(df_ms$sleep_total >= 5 ,"C","D")))
# 5시간 이상 10시간 C
# 5시간 미만 D 
                            

table(df_ms$sleep_grade) # A :12, B : 33 ,C : 27 D :11 

#8.2 총수면량 중 비렘수면의 백분율을 나타내는 nonrem_ratio 라는 파생변수를 만들어보세요.

df_ms$nonrem_ratio  <- (df_ms$sleep_nonrem/df_ms$sleep_total*100) 
# 총수면량 중 비렘수면의 백분율공식 파생변수 추가 

View(df_ms)

#8.3 수면량 등급별 비렘수면 백분율을 막대그래프로 나타내보세요. 이때 막대그래프는 평균이 낮은 순으로 보여지게 하세요.
library(ggplot2)

df_ms_mean_nonrem_ratio <-df_ms %>%  # df_ms_mean_nonrem_ratio할당 
  group_by(sleep_grade) %>%  ## 수면량 등급별 
  summarise(mean_nonrem_ratio = mean(nonrem_ratio,na.rm = T)) %>%  ## 평균 비렘수면 백분율 구하고 결측치 제거 
  arrange(mean_nonrem_ratio)## 순서대로 나열 

df_ms_mean_nonrem_ratio

ggplot(data = df_ms_mean_nonrem_ratio , aes(x = reorder(sleep_grade,mean_nonrem_ratio),
                                            y = mean_nonrem_ratio))+
  geom_col()#평균이 낮은 순으로 보여주는 그래프 



#8.4 식성 구분(육/잡/초/충/모름)별 비렘수면 백분율을 막대그래프로 나타내보세요. 이때 막대그래프는 평균이 낮은 순으로 보여지게 하세요.

df_ms_mean_nonrem_ratio_vore <-df_ms %>% #df_ms_mean_nonrem_ratio_vore 할당 
  group_by(vore) %>% # 식성별 그룹화 
  summarise(mean_nonrem_ratio = mean(nonrem_ratio,na.rm = T)) %>% # 비렘수면 백분율 평균 구하고 결측치 제거하기 
  arrange(mean_nonrem_ratio) #mean_nonrem_ratio 나열하기 

df_ms_mean_nonrem_ratio_vore # 데이터 프레임 확인하기 

ggplot(data = df_ms_mean_nonrem_ratio_vore , aes(x = reorder(vore,mean_nonrem_ratio),
                                            y = mean_nonrem_ratio))+
  geom_col() 

# 평균이 낮은 순으로 비렘수면 백분율 나열하기 
# mean_nonrem_ratio 나열하기 



#9.1 사람(Human)의 뇌무게 백분율을 확인하여 human_brainwt 이라는 변수에 할당하세요. 이때 숫자를 직접입력하는 방식을 사용하지 말고 해당하는 값이 할당되도록 하세요.

View(df_ms)

human_brainwt <- df_ms[df_ms$name == 'Human', "brain_ratio"] ##  사람(Human)의 뇌무게 백분율을 확인하여 해당값 할당 
human_brainwt <- df_ms[34,20]##  사람(Human)의 뇌무게 백분율을 확인하여 해당값 할당 [34행 20열 ]
dim(df_ms)


#9.2 human_brainwt보다 뇌무게 백분율이 높은 그룹을 "High", 낮은 그룹을 "Low", 기준이되는 사람은 "Human" 이라고 판별한 brain_grade 라는 변수를 만들어서 
#해당 변수별로 총수면량(시간 단위)의 최소값, 중앙값, 평균, 최대값, 빈도를 출력하세요.


#뇌무게 백분율이 높은 그룹을 "High", 낮은 그룹을 "Low", 기준이되는 사람은 "Human" 이라고 판별  
df_ms$brain_grade <- ifelse(df_ms$brain_ratio > human_brainwt ,"High",
                              ifelse(df_ms$brain_ratio == human_brainwt ,"Human" ,"Low"))

df_ms %>% 
  group_by(brain_grade) %>% #뇌무게 단계로 구분하기 
  filter(!is.na(brain_grade)) %>%  ## brain _grade 에서 none 값 제거 
  summarise(min_sleep_total = min(sleep_total,na.rm =T), #총수면량(시간 단위)의 최소값 ,결측치제거
            median_sleep_total = median(sleep_total,na.rm =T),#총수면량(시간 단위)의중간,결측치제거
            mean_sleep_total = mean(sleep_total,na.rm =T),#총수면량(시간 단위)의 평균값 ,결측치제거
            max_sleep_total = max(sleep_total,na.rm =T),#총수면량(시간 단위)의 최대값 ,결측치제거
            n =n())                        #총수면량(시간 단위)의 빈도  ,결측치제거

