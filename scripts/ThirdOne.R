library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")
select(surveys, plot_id, species_id, weight)
filter(surveys,year==1995)
surveys2 <- filter(surveys,weight<5)
# ditto select, and can combine filter and select

surveysSm <- surveys %>%
  filter(weight<5) %>%
  select(species_id, sex, weight)
# select will act on what is to the left of pipe

surveysSm <- surveys %>%
  filter(year<1995) %>%
  select(year, sex, weight)

idx <- !is.na(surveysSm$weight)
sey = c("year","sex","weight")
surveysVSm <- surveysSm[idx,sey]
surveysVSm

surveys %>%
  mutate(weightKg = weight/1000.,
         weightKg2 =  weightKg**2) %>%
  select(year, weight, weightKg2)

surveyshalf <-surveys %>%
  mutate(hindfoothalf = hindfoot_length/2.) %>%
  filter(!is.na(hindfoothalf)) %>%
  filter(hindfoothalf<30)   %>%
  select(species_id, hindfoothalf)
# na filter can also be done with na omit sort of command

surveys %>%
  group_by(sex,species_id) %>%
  summarize(meanw=median(weight, na.rm=TRUE))
# this will have a load of NaN at end and this is because while we do na filter, it is on 
# weight - and we have grouped by before this point - the NaN are due to NA in the sex, in 
# this case. So need to filter out NA before groupd
surveys %>%
  filter(!is.na(weight) & !is.na(sex)) %>%
  group_by(sex,species_id) %>%
  summarize(meanw=median(weight, na.rm=TRUE)) %>%
  tail()

