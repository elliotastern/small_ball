library(dplyr)
library(ggplot2)

# import data
champs <- read.csv("file:///C:/Users/stern/Downloads/nba_championchips_defense.csv")


def_avg  <- mean(champs$champion.nba.com.defensive.rating)

# visualization
ggplot(champs, aes(x = Year, y = champion.nba.com.defensive.rating, color = Results)) +
  geom_text(aes(label = Team), size = 3.5, fontface = "bold") +
  scale_y_continuous(name="Defensive Ratings", limits=c(0, 30)) +
  geom_hline(yintercept = def_avg, color = "black", lwd = .8) +
  geom_text(aes(label = "Average Defensive Rating", y = def_avg + .5, x = 2014.5) , colour="black", fontface = "bold" , angle=0, size=4)




