library(readxl)
X2019_Gangseogu <- read_excel("R/2019 Gangseogu.xlsx")
View(X2019_Gangseogu)

X2019_Gangseogu <- subset(X2019_Gangseogu,X2019_Gangseogu$자치구=='강서구')

X2019_Gangseogu$합계...4 <- as.numeric(X2019_Gangseogu$합계...4)
X2019_Gangseogu <- X2019_Gangseogu %>% arrange(합계...4)
View(X2019_Gangseogu)

X2019_Gangseogu <- X2019_Gangseogu%>%slice(-21)

g <- ggplot(data=X2019_Gangseogu, aes(x=reorder(동, 합계...4), y=합계...4))+
  ggtitle('2019년 강서구 독거노인 현황')+
  xlab("동")+
  ylab("인구 수")+
  geom_col()+
  coord_flip()

gg <-ggplot(data=Gangseogu, aes(x=reorder(동, 합계...4), y=합계...4))+
  ggtitle('2020년 강서구 독거노인 현황')+
  xlab("동")+
  ylab("인구 수")+
  geom_col()+
  coord_flip()

install.packages("gridExtra")

library(gridExtra)

grid.arrange(g,gg,ncol=1)



