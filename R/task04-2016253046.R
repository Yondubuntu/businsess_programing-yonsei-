
#문제1 - 제공된 df_mpg.csv 파일을 mpg라는 이름의 데이터프레임으로 불러오세요.

mpg <- read.csv("df_mpg.csv")

#문제2.1 - drv변수와 hwy변수에 결측치가 몇 개 있는지 각각 알아보세요.

table(is.na(mpg$drv)) # 결측치 계산 
## drv 결측치  na 없다 
table(is.na(mpg$hwy)) # 결측치 있는지 확인 
## hwy 결측치  7개 있다 


#문제2.2 - hwy변수의 결측치를 제외하고, 구동 방식별 고속도로 연비의 평균을 구해보세요.

library(dplyr) # 라이브러리 불러오기 
mpg %>%  
  group_by(drv) %>%  # 구동 방식별 
  filter(!is.na(hwy)) %>% # 결측치 제거 
  summarise(mean_hwy = mean(hwy)) # 평균 구하기 
  
#문제3.1 - drv 변수에 이상치가 있는지 확인하고, 이상치를 결측치 처리하세요.

table(mpg$drv)
mpg$drv <- ifelse(mpg$drv == 'k' , NA , mpg$drv) # 이상치 k 제거 
table(mpg$drv) ## 이상치 제거 확인 

#(조건을 연결해도 되고, %in%을 응용해서 간략하게 표시해도 됩니다. 되도록 후자로 연습해보세요.)

#문제3.2 - cty 변수에 이상치(극단치)가 있는지 확인 하고, 정상 범위를 벗어난 값을 결측 처리한 후 다시 이상치(극단치)가 사라졌는지 확인해보세요.

boxplot(mpg$cty)$stats ## 결측치 및 stats 로 확인하기 

mpg$cty <- ifelse (mpg$cty < 9 | mpg$cty > 26 , NA , mpg$cty) # 이상치 제거 
table(is.na(mpg$cty))


#문제4 - mpg데이터의 cty(도시 연비)와 hwy(고속도로 연비) 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 cty, y축은 hwy로 된 산점도를 만들어 보세요. 어떤 패턴을 발견할 수 있는지 간단히 해석을 남겨보세요.

library(ggplot2) # 라이브러리 다운 

ggplot(data = mpg, aes(x = cty , y =hwy))+
  geom_point()

## cty 가 늘어남에 따라 hwy 도 늘어나는 경향이 보인다. 


#문제5 - midwest데이터를 이용해 전체 인구와 아시아인 인구 간에 어떤 관계가 있는지 알아보려고 합니다. x축은 poptotal(전체 인구), y축은 popasian(아시아인 인구)으로 된 산점도를 만들어 보세요. 전체 인구는 50만명 이하, 아시아인 인구는 1만명 이하인 지역만 산점도에 표시되게 설정하세요.

ggplot(data = midwest, aes(x = poptotal , y =popasian))+
  geom_point()+ 
  xlim(0,500000)+  # x 축 50만명
  ylim(0,10000) # y 축 1 만명 이하 
  
?midwest


#문제6 - mpg 데이터에서 어떤 회사에서 생산한 "suv" 차종의 도시 연비가 높은지 알아보려고 합니다. "suv"차종을 대상으로 평균 cty(도시 연비)가 가장 높은 회사 다섯 곳을 막대 그래프로 표현해 보세요. 막대는 연비가 높은 순으로 정렬하세요.
mpg

mpg_suv <- mpg %>% 
  filter(class == "suv") %>%  # suv 차종
  group_by(manufacturer) %>%  # 회사 생산별 
  summarise(mean_cty = mean(cty,na.rm = T)) %>% 
  arrange(-mean_cty) %>% 
  head(5)

mpg_suv

ggplot(data=mpg_suv, aes(x = reorder(manufacturer,-mean_cty) , y =mean_cty))+ 
  geom_col()


#문제7 - economics 데이터에서 psavert(개인 저축률)가 시간에 따라 어떻게 변해 왔는지 알아보려고 합니다. 시간에 따른 개인 저축률의 변화를 나타낸 시계열 그래프를 만들어 보세요. 어떤 패턴을 발견할 수 있는지 간단히 해석을 남겨보세요.

ggplot(data = economics , aes(x = date ,y =psavert))+ 
  geom_line() 

## 일정 한패턴을 보이면서 줄어 들고는 있는 명확하게 내려가고 올라간 이유를 확인하기는 어렵다 

## 개인 저축률 그래프 

#문제8 - mpg 데이터에서 class(자동차 종류)가 "compact", "subcompact", "suv"인 자동차의 cty(도시 연비)가 어떻게 다른게 분포하는지 비교해보려고 합니다. 세 차종의 cty를 나타낸 상자 그림을 만들어 보세요. 어떤 패턴을 발견할 수 있는지 간단히 해석을 남겨보세요.

mpg_three <- mpg %>% 
  filter (class =="compact" |class == "subcompact" | class =="suv") %>% 
  filter(!is.na(cty)) # 결측치 제거 
  
mpg_three

ggplot(data = mpg_three, aes (x = class , y = cty))+ 
  geom_boxplot()  

## compact 와 suv 에서 이상치를 확인할수 있고 suv 에 대부분의 겂이 밑에 존재 하는것을 확인할 수있다 
