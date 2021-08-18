##############################
# 0 - LOAD PACKAGE   
##############################
library(ggplot2) #3.3.3

############################## 
# 1 - LOAD DATA
##############################
spurs <- read.csv("Basketball Defensive Ratings.csv", stringsAsFactors = FALSE)

############################## 
# 2 - DATA CLEANING
##############################
spurs$Duncan <- gsub("\\\\n", "\n", spurs$Duncan)

############################## 
# 3 - DATA VISUALIZATION
############################## 

ggplot(spurs, aes(x = Year, y = Adjusted.Defensive.Ratings, color = Rim.Protector, label = Duncan)) +
  geom_point(size = 3, shape = 15) +
  ylab("Defensive Rating") +
  ylim(1, 30) +
  geom_text(data = subset(spurs, Year == "1998-99"), vjust = -1, size = 5, aes(fontface = 2)) +
  geom_text(data = subset(spurs, Year == "1994-95"), vjust = -1, hjust = 0, size = 5, aes(fontface = 2)) +
  geom_text(data = subset(spurs, Year == "1996-97"), vjust = +1.5, size = 5, aes(fontface=2)) +
  theme(axis.text.x = element_text(face = "bold"),
        axis.text.y = element_text(angle = 45))
  
ggplot(spurs, aes(x = Year, y = Adjusted.Defensive.Ratings, label = Duncan, color = Rim.Protector)) +
  geom_text(data = subset(spurs, Year == "1998-99"), vjust = -1, size = 5, aes(fontface = 2)) +
  geom_text(data = subset(spurs, Year == "1994-95"), vjust = -1, hjust = 0, size = 5, aes(fontface = 2)) +
  geom_text(data = subset(spurs, Year == "1996-97"), vjust = +1.5, size = 5, aes(fontface = 2)) +
  theme(axis.text.y = element_text(angle = 45),
        axis.text.x = element_text(face = "bold")) +
  ylim(1, 30) +
  ylab("Defensive Ratings") +
  geom_point(shape = 15, size = 3) 


