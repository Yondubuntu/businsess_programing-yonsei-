

#문제1.1 - ggplot2 패키지의 midwest 데이터를 데이터 프레임 형태로 불러오세요. mpg 데이터와 같은 방식으로 불러오면 됩니다.

midwest  <-as.data.frame(ggplot2 :: midwest)
midwest

#문제1.2 - 데이터 파악하기에서 배운 모든 함수들을 활용해서 midwest 데이터의 특징을 파악하세요. 이때 출력된 결과를 보고 파악한 내용을 간단히 주석으로 남기도록 하세요.

head(midwest) ## 앞부분에서 5개의 행 데이터를 보겠다 
tail(midwest) ## 마지막 데이터 5개의 행데이터를 보여준다 
View(midwest) ## 엑셀 형식으로 보여준다 
dim(midwest) ## 437 행 28 개 attribute
str(midwest)  ## 속성 마다 변수 확인가능  country :chr area : num 
summary(midwest) ## mid west numerical 값의 최대 최소 3/4 지점을 확인할수있다 . 

#문제2.1 - midwest 데이터의  매뉴얼(도움말)을 실행시킨 뒤 데이터와 변수에 대한  설명을 보고 정리해서 주석으로 남기도록 하세요.

?midwest   

## PID Unique county identifier.

##county County name.
#state State to which county belongs to.

#area Area of county (units unknown).

#poptotal  Total population.

#popdensity Population density (person/unit area).

# popwhite
# Number of whites.
# 
# popblack
# Number of blacks.
# 
# popamerindian
# Number of American Indians.
# 
# popasian
# Number of Asians.
# 
# popother
# Number of other races.
# 
# percwhite
# Percent white.
# 
# percblack
# Percent black.
# 
# percamerindan
# Percent American Indian.
# 
# percasian
# Percent Asian.
# 
# percother
# Percent other races.
# 
# popadults
# Number of adults.
# 
# #perchsd
# Percent with high school diploma.
# 
# percollege
# Percent college educated.
# 
# percprof
# Percent with professional degree.
# 
# poppovertyknown
# Population with known poverty status.
# 
# percpovertyknown
# Percent of population with known poverty status.
# 
# percbelowpoverty
# Percent of people below poverty line.
# 
# percchildbelowpovert
# Percent of children below poverty line.
# 
# percadultpoverty
# Percent of adults below poverty line.
# 
# percelderlypoverty
# Percent of elderly below poverty line.
# 
# inmetro
# County considered in a metro area.
# 
# category
# Miscellaneous.



#문제3.1 - poptotal 변수를 total로, popasian 변수를 asian으로 수정하세요. 변수명 수정 과정에 유의하여 잘 변환되었는지까지 확인하세요.
library(dplyr) ## 라이브러리 사용 
midwest_new <- midwest ## 새로운 midwest_new 를 생성하여 
midwest_new <-rename(midwest_new, total = poptotal)  ## 변수를 변경 
midwest_new <-rename(midwest_new, asian = popasian) ## 따로 변경해준다. 

View(midwest_new) ## 확인해보는 함수 

#문제4.1 - total 변수, asian 변수를 이용해서 '전체 인구 대비 아시아 인구 백분율' 파생변수 asian_total을 만드세요. (백분율에 유의하세요!)

midwest_new$asian_percent <- (midwest_new$asian/midwest_new$total)*100  ## (asian/total) *100 백분율 

View(midwest_new)

#문제4.2 - 도시들의 전체 인구 대비 아시아 인구 백분율이 어떻게 분포하는지 적절한 함수를 적용해서 살펴보세요. 시각화 함수 배운 것 중에서 어떤 함수를 사용할지 생각해보세요.
qplot(midwest_new$asian_percent) 

## 연속형 데이터 가아니므로 qp plot을 사용한다. 
