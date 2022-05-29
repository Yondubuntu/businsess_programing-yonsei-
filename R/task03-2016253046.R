#문제1.1 - mpg 데이터를 데이터 프레임 형태로 불러오세요.

mpg <- as.data.frame(ggplot2::mpg)

View(mpg)

#문제1.2 - 배기량이 2이상 4이하인 자동차들을 추출하여 새로운 데이터프레임에 할당하세요. 배기량이 4초과 6이하인 자동차들도 추출하여 새로운 데이터프레임에 할당하세요. (초과, 미만, 이상, 이하 주의하세요.)

library(dplyr)
disp_high <- mpg %>% filter(displ>4 & displ <=6) ## 4초과 6이한 자동차data frame 
disp_high

disp_low <- mpg %>% filter(displ>=2 & displ <=4) ## 2이상 4이하인 자동차 data frame 
disp_low

#문제1.3 - 두 데이터프레임을 가지고 각 조건인 자동차들의 도시 연비의 평균을 각각 구해서 비교해보세요. (비교해보라는 의미는 해석이 있어야 된다는 의미입니다.)

disp_high %>%  
  summarise(cty_mean1 = mean(cty)) ## 도시 연비의 평균

disp_high

disp_low %>%  
  summarise(cty_mean2 = mean(cty)) ## 도시 연비의 평균


## 해석 
## 평균 4초과 6인 좋은 자동차가 도시에서의 평균 연비는 더 낮다 

#문제1.4 - 문제1.2와 문제1.3의 과정을 한번에 진행하여 출력만 되도록 하세요. (데이터프레임에 할당하여 진행하지 말고, 함수를 조합하라는 의미입니다.)

mpg %>% 
  filter(displ>4 & displ <=6) %>%  # #평균 4초과 6인 좋은 자동차
  summarise(cty_mean1 = mean(cty))

mpg %>% 
  filter(displ>=2 & displ <=4) %>% ## 2이상 4이하인 자동차 d
  summarise(cty_mean2 = mean(cty))

#문제2.1 - 제조 회사 중에서 아우디와 토요타의 자동차들을 각각 추출하여 새로운 데이터프레임에 할당하세요. (아우디 자동차 추출한 데이터프레임 하나, 토요타 자동차 추출한 데이터프레임 하나 이렇게 두 데이터프레임이 필요합니다.)

audi <- mpg %>% filter(manufacturer == "audi") #제조 회사 중에서 아우디

audi

toyota <- mpg %>% filter(manufacturer == "toyota") #제조 회사 중에서 도요타
toyota

#문제2.2 - 두 데이터프레임을 가지고 각 회사의 자동차들의 고속도로 연비의 평균을 각각 구해서 비교해보세요. (비교해보라는 의미는 해석이 있어야 된다는 의미입니다.)

toyota %>%  
  summarise(toyota_mean = mean(hwy)) #고속도로 연비의 평균 


audi %>%  
  summarise(audi_mean = mean(hwy)) #고속도로 연비의 평균 

## 해석 
## 고속도로에서의 연비는 아우디가 도요타 보다 높다 .

#문제2.3 - 문제2.1와 문제2.2의 과정을 한번에 진행하여 출력만 되도록 하세요. (데이터프레임에 할당하여 진행하지 말고, 함수를 조합하라는 의미입니다.)
mpg %>% 
  filter(manufacturer == "toyota") %>% 
  summarise(toyota_mean = mean(hwy))

mpg %>% 
  filter(manufacturer == "audi") %>% 
  summarise(audi_mean = mean(hwy))


#문제3.1 - 현대에서 생산한 자동차 중에서 도시 연비 상위 1위~3위까지에 해당하는 자동차의 데이터를 출력해보세요.


mpg %>% 
  filter(manufacturer == "hyundai") %>% #현대에서 생산한 자동차 
  arrange(-cty) %>%  #상위 1위~3위까지
  head(3) #세개 추출

#문제4.1 - 차종(type)별로 도시 연비의 평균을 구해보세요. 도시 연비의 평균순으로 내림차순이 되도록 정렬해서 출력해보세요.
mpg %>% 
  group_by(class) %>%
  summarise(cty_mean = mean(cty)) %>% 
  arrange(desc(cty_mean))


#문제5.1 - 차종(type)별로 고속도로 연비의 평균을  구해서 하위 1위~5위까지 출력해보세요.
mpg %>% 
  group_by(class) %>%
  summarise(cty_mean = mean(hwy)) %>% 
  arrange(cty_mean) %>%  # 하위 1위~5위까지 오름차순 
  head(5)



#문제6.1 - "compact" (경차)와 "subcompact" (소형차) 차종(type)을가장 많이 생산하는 5곳의 회사명만 출력해보세요.
mpg %>% 
  filter (class =="compact" |class == "subcompact") %>%  ##compact" (경차)와 "subcompact" (소형차) 차종(type)
  group_by(manufacturer) %>%  # 제조사 별로 추출 
  summarise(n=n()) %>% ##빈도수 
  arrange(-n) %>%  # 오름차순 추출 
  head(5)

#문제7.1 - 연료  종류에 따른 가격을 나타낸 아래와 같은 새로운 데이터 프레임 df_fuel 을 만들어 보세요.
df_fuel = data.frame(fl = c("c","d","e","p","r"), 
                     price_fl = c(2.45,2.38,2.11,2.86,2.22)) ## 데이터프레임 생성 
df_fuel
#문제7.2 - mpg 데이터에 price_fl 이라는 연료 가격 변수를 추가해서  모델명, 연료 종류, 연료 가격을 추출하여 10개의 행만 출력해보세요.

mpg %>% 
  mutate(left_join(mpg,df_fuel,by= "fl"))%>% ## df_fuel 데이터 추가 
  select(manufacturer,fl,price_fl) %>% ## 모델명, 연료 종류, 연료 가격을 추출
  head(10) ## 10개 행 추출

