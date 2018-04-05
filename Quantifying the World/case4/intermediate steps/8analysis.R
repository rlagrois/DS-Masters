setwd("D:/SMU/qtw/case4")
getwd()
library(ggplot2)
library(RColorBrewer)
library(dplyr)
library(Hmisc)
library(car)


#Load in DFs
load("cbWomen.rda")
summary(cbWomen)
str(cbWomen)

load("cbmen.rda")
summary(cbmen)
str(cbmen)

#Remove remaining NAs for colored boxplot
wData = cbWomen %>% mutate(year = year) %>%
  group_by(year) %>%
  filter(!is.na(age)) %>%
  mutate(med_age = median(age))

mData = cbmen %>% mutate(year = year) %>%
  group_by(year) %>%
  filter(!is.na(age)) %>%
  mutate(med_age = median(age))

#QQ Plots
qqnorm(cbWomen$age, main = "Normal QQ Plot: Women's Age", ylab = "Age")
qqline(cbWomen$age)

qqnorm(cbmen$age, main = "Normal QQ Plot: Men's Age", ylab = "Age")
qqline(cbmen$age)


#box plots ages by year
#Women, points with quantile lines
boxY <- scale_y_continuous(name= "Age", breaks = seq(5, 90, 5), limits=c(5,90))
boxX <- scale_x_discrete(name="Year")
wBox <- ggplot(wData, aes(x = factor(year), y = age)) + geom_point(alpha=0.3) +
  stat_summary(fun.data = "median_hilow",  color = "blue", geom="crossbar", mapping = aes(group=year))
wBox <- wBox + boxY + boxX + ggtitle("Boxplot of Ages by Year: Women") + theme(plot.title = element_text(hjust = 0.5))
wBox

#women colored by median
wBox2 <- ggplot(wData, aes(x=factor(year), y=age, fill=med_age)) + geom_boxplot()
wBox2 <- wBox2 + boxY + boxX + ggtitle("Boxplot of Ages by Year: Women") + theme(plot.title = element_text(hjust = 0.5))
wBox2

#men points with quantile lines
mboxY <- scale_y_continuous(name= "Age", breaks = seq(5, 90, 5), limits=c(5,90))
mboxX <- scale_x_discrete(name="Year")
mBox <- ggplot(mData, aes(x = factor(year), y = age)) + geom_point(alpha=0.3) +
  stat_summary(fun.data = "median_hilow",  color = "darkgreen", geom="crossbar", mapping = aes(group=year))
mBox <- mBox + mboxY + mboxX + ggtitle("Boxplot of Ages by Year: Men") + theme(plot.title = element_text(hjust = 0.5))
mBox

#men colored by median
mBox2 <- ggplot(mData, aes(x=factor(year), y=age, fill=med_age)) + geom_boxplot(aes(fill=med_age, group=year), 
  color = "black")
mBox2 <- mBox2 + mboxY + mboxX + ggtitle("Boxplot of Ages by Year: Men") + 
  theme(plot.title = element_text(hjust = 0.5)) + scale_fill_gradient(high="darkolivegreen1", low="darkgreen")
mBox2


#Density Plots
#women year lines
wDen <- ggplot(cbWomen, aes(x=age)) + geom_density(aes(group=year, color=year)) + 
  ggtitle("Density of Ages by Year: Women") + theme(plot.title = element_text(hjust = 0.5))
wDen
#women point with density lines
wDen2 <- ggplot(cbWomen, aes(x=year, y=age)) + geom_point(size=1) + geom_density_2d(size=1) + 
  ggtitle("Density of Ages by Year: Women") + theme(plot.title = element_text(hjust = 0.5))
wDen2

#men year lines
mDen <- ggplot(cbmen, aes(x=age)) + geom_density(aes(group=year, color=year)) + 
  ggtitle("Density of Ages by Year: Men") + theme(plot.title = element_text(hjust = 0.5)) + 
  scale_color_gradient(high="darkolivegreen3", low="gray8")
mDen
#men points with density lines
mDen2 <- ggplot(cbmen, aes(x=year, y=age)) + geom_point(size=1) + geom_density_2d(color="darkgreen", size=1) + 
  ggtitle("Density of Ages by Year: Men") + theme(plot.title = element_text(hjust = 0.5))
mDen2


