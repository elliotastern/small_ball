##############################
# 0 - LOAD PACKAGE   
##############################
library('tidyverse') #1.2.1

############################## 
# 1 - LOAD DATA
##############################
champs <- read.csv("nba_championchips_defense.csv")

############################## 
# 2 - DATA CLEANING
############################## 
def_avg  <- mean(champs$champion.nba.com.defensive.rating)

############################## 
# 3 - DATA VIZUALIZATION
############################## 
ggplot(champs, aes(x = Year, y = champion.nba.com.defensive.rating, color = Results)) +
  geom_text(aes(label = Team), size = 3.5, fontface = "bold") +
  scale_y_continuous(name = "Defensive Ratings", limits = c(0, 30)) +
  geom_hline(yintercept = def_avg, color = "black", lwd = .8) +
  geom_text(aes(label = "Average Defensive Rating", y = def_avg + .5, x = 2014.5) , colour="black", fontface = "bold" , angle = 0, size = 4)




