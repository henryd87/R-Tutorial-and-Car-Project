library(tidyverse)

data() #gives us numerous amounts of dataset, no need to import!
View(mpg)
?mpg #describes the dataset for us, specifically for mpg dataset.
?mean #just in case we want to know what mean() does.

glimpse(mpg)
?filter
filter(mpg,cty>=20)
mpg_graph <- filter(mpg,cty>=20)
View(mpg_graph)

mpg_AudiCar <- filter(mpg,manufacturer=="audi")
View(mpg_AudiCar)

#changing units of measure, 
#mutate can be used for add a new column.
mpg_metric <- mutate(mpg, cty_metric=.425144*cty)
View(mpg_metric)
glimpse(mpg_metric)

#Introduction of the pipe. Order of what to be done
#for any program
#Command Shift M = %>% 
mpg_metric <- mpg %>%>
  mutate(cty_metric=.425144*cty)

View(mpg)

mpg %>% 
  group_by(class) %>% 
  summarise(mean(cty),median(cty))
#*This gives us the avergae mileage for each class of car.

#Data visualization with ggplot2
ggplot(mpg,aes(x=cty))+
  geom_histogram()+
  labs(x="City Mileage")


ggplot(mpg,aes(x=cty,y=hwy,color=class))+
  geom_point()+
  geom_smooth(method="lm")


ggplot(mpg,aes(x=cty,y=hwy,color=class))+
  geom_point()+
  scale_color_brewer(palette="Dark2")

#*markdown document allows us to easily share data.

#*-----------------------------------
#*-----------------------------------


#*My own analysis, not affiliated with above work from @EquitableEquations
#*Below credit is my own.
install.packages("Hmisc")
library(Hmisc)
View(mpg)
describe(mpg)
#This allows for me to see if anything is missing
# and needs to be removed.
# distinct numbers show how many types of answers I can receive,
# for instance, model has 38 distinct values fo 38 different models.
mpg$cty_oneHot <- as.integer(mpg$cty<=20) #adding column in process.
#*If the city mileage was below 20, it's one-hot number is 1.
unique(mpg$cty_oneHot)
View(mpg)
glimpse(mpg$cty_oneHot)
sum(mpg$cty_oneHot/nrow(mpg))
#This reveals that 80% of cars, regardless of model, have a city
#mileage under 20. Maybe shows a common speeding law in the region?


#--------------------------------
#Which models are more correlated to having higher highway mileage?
mpg$hwy_oneHot <- as.integer(mpg$hwy <=24)
median(mpg$hwy) #gives back 24

high24 = subset(mpg,mpg$hwy_oneHot==0) #116 cars have >= 24
low24 = subset(mpg,mpg$hwy_oneHot==1) #118 cars have <24
glimpse(high24)
ggplot(mpg,aes(x=year,y=displ,color=class))+
  geom_point()+
  scale_color_brewer(palette="Dark2")
#*This plot show that multiple classes of car
#*(2seater, compact, midsize,etc.) were mad ein either
#*1999 or 2008 with display ranges from (1,7). This
#*relates to high 24 because all of these classes of cars
#*have highway mileage above or equal to 24.



