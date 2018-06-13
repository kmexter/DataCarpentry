library(tidyverse)

"✔ ggplot2 2.2.1     ✔ purrr   0.2.5
✔ tibble  1.4.2     ✔ dplyr   0.7.5
✔ tidyr   0.8.1     ✔ stringr 1.3.1
✔ readr   1.1.1     ✔ forcats 0.3.0
── Conflicts ────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()"

download.file("https://ndownloader.figshare.com/files/11930600?private_link=fe0cd1848e06456e6f38",
              "data/surveys_complete.csv")
surveysComplete <- read_csv("data/surveys_complete.csv")
surveysComplete
# to get a basic plot need all of these parameters filled 
ggplot(data = surveysComplete, aes(x=weight,y=hindfoot_length)) +
  geom_point()
# cleaner plots
ggplot(data = surveysComplete, aes(x=weight,y=hindfoot_length)) +
  geom_point(alpha=0.1) # transparancy
ggplot(data = surveysComplete, aes(x=weight,y=hindfoot_length)) +
  geom_point(color="blue")
ggplot(data = surveysComplete, aes(x=weight,y=hindfoot_length)) +
  geom_point(aes(color=species_id),size=0.5)
ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_point(aes(color=plot_id),size=0.5)
# the colour gradient is continuous, how to make it discrete
# ...by changing the class of plot_id, which is a string1d by default
surveysComplete$plot_id <- (factor(surveysComplete$plot_id))
ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_point(aes(color=plot_id),size=0.5)

ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_boxplot(size=0.5)
ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_boxplot(size=0.5) + 
  geom_jitter(alpha=0.3, color="tomato") 
# jitter will move moves left and right around the value a bit, to make the distribution fatter
ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_boxplot(size=0.5) + 
  geom_jitter(alpha=0.3, aes(color=plot_id)) 
# you can also change the plot_id to a factor in the ggplot but bah
# ()


ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_violin(count=scale) 

ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_violin(count=scale) + scale_y_log10() 

ggplot(data = surveysComplete, aes(x=species_id,y=hindfoot_length)) +
  geom_jitter(alpha=0.3, aes(color=weight)) +
  geom_boxplot(size=0.5) 
   
# Piping
yearlyCount <- surveysComplete %>%
  group_by(year,species_id) %>%
  tally()

# the n here is the count which is added by tolly
ggplot(data = yearlyCount, aes(x=year,y=n)) +
  geom_line()
# separate out on species id in two ways
ggplot(data = yearlyCount, aes(x=year,y=n, group=species_id)) +
  geom_line()
ggplot(data = yearlyCount, aes(x=year,y=n, color=species_id)) +
  geom_line()
# multipanel plot separated on species id
ggplot(data = yearlyCount, aes(x=year,y=n)) +
  geom_line() +
  facet_wrap(~ species_id)

yearlySexCounts <- surveysComplete %>%
  group_by(year, species_id, sex) %>%
  tally()
ggplot(data = yearlySexCounts, aes(x=year,y=n, color=sex)) +
  geom_line() +
  facet_wrap(~ species_id) + 
  theme_bw() + 
  theme(panel.grid=element_blank(),
        text=element_text(size=8),
        axis.text.x=element_text(color="orange",size=8,angle=90,hjust=0.5,vjust=0.5)) +
  labs(title="Sdf",x="Sdf",y="Sdf")


ggplot(data = surveysComplete, aes(x=species_id,y=weight)) +
  geom_jitter(alpha=0.1,aes(color=weight)) +
  geom_boxplot(size=0.5) +
  facet_wrap(~ sex)
