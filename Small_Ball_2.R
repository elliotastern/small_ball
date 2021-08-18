##############################
# 0 - LOAD PACKAGE   
##############################
library('tidyverse') #1.2.1

############################## 
# 1 - LOAD DATA
##############################
nba <- read.csv("nba_2014_15.csv", stringsAsFactors = FALSE)
nba16 <- read.csv("nba_2015_16.csv", stringsAsFactors = FALSE)
nba17 <- read.csv("nba_2016_17.csv", stringsAsFactors = FALSE)


############################## 
# 2 - DATA CLEANING
##############################
# Clean Date column
nba$DATE <- as.Date(nba$DATE, format = "%m/%d/%Y")

# Limit to Cleveland Games
cleveland <- nba %>%
  filter(TEAMS == "Cleveland") %>%
  filter(DATASET == "2014-2015 Regular Season")   

# Add Mozgov column to split by
cleveland$Mozgov <- ifelse(cleveland$DATE > as.Date("2015-01-09", format = "%Y-%m-%d"), "With Mozgov 2014-15", "Without Mozgov 2014-15")
  

with_moz    <-mean(cleveland$DEFF[cleveland$Mozgov == "With Mozgov 2014-15"])
without_moz <-mean(cleveland$DEFF[cleveland$Mozgov == "Without Mozgov 2014-15"])

median(cleveland$DEFF[cleveland$Mozgov == "With Mozgov 2014-15"])
median(cleveland$DEFF[cleveland$Mozgov == "Without Mozgov 2014-15"])

mean(cleveland$OEFF[cleveland$Mozgov == "With Mozgov 2014-15"])
mean(cleveland$OEFF[cleveland$Mozgov == "Without Mozgov 2014-15"])

lines <- cleveland %>%
  group_by(Mozgov) %>%
  summarise(mean_defense = mean(DEFF))


# Clean Date column
nba16$DATE <- as.Date(nba16$DATE, format = "%m/%d/%Y")


# Limit to Cleveland Games
cleveland16 <- nba16 %>%
  filter(TEAMS == "Cleveland") %>%
  filter(DATASET == "2015-2016 Regular Season")   

with_moz16    <-mean(cleveland16$DEFF)

# Add Mozgov column to split by
cleveland16$Mozgov <- "With Mozgov 2015-16"

cleveland_combined <- rbind(cleveland[c("DATE", "DEFF", "Mozgov")]
                        , cleveland16[c("DATE", "DEFF", "Mozgov")])

# Clean Date column
nba17$DATE <- as.Date(nba17$DATE, format = "%m/%d/%Y")

# Limit to Cleveland Games
cleveland17 <- nba17 %>%
  filter(TEAMS == "Cleveland")

without_moz17    <-mean(cleveland17$DEFF)

# Add Mozgov column to split by
cleveland17$Mozgov <- "Without Mozgov 2016-17"

cleveland_combined <- rbind(cleveland_combined[c("DATE", "DEFF", "Mozgov")]
                            , cleveland17[c("DATE", "DEFF", "Mozgov")])

############################## 
# 3 - DATA VISUALIZATION
############################## 
ggplot(cleveland, aes(x = DATE, y = DEFF, color = Mozgov)) +
  geom_point() +
  geom_hline(yintercept=with_moz,    color = "turquoise",       lwd = 2)+
  geom_hline(yintercept=without_moz, color = "red", lwd = 2)+
  theme_minimal() +
  geom_text(aes(label = "Average Without Mozgov",    y = with_moz   + 5, x = as.Date("2015-01-09", format = "%Y-%m-%d")- 30) , colour="red4", fontface = "bold" , angle=0, text=element_text(size=27)) +
  geom_text(aes(label = "Average With Mozgov", y = without_moz- 5, x = as.Date("2015-01-09", format = "%Y-%m-%d")+ 55) , colour="turquoise4", fontface = "bold" , angle=0, text=element_text(size=27))


ggplot(cleveland_combined, aes(x = DATE, y = DEFF, color = Mozgov)) +
  geom_point(size = 1, alpha = .4) +
  geom_hline(yintercept=with_moz,    color = "turquoise",       lwd = .7)+
  geom_hline(yintercept=without_moz, color = "red",             lwd = .8)+
  geom_hline(yintercept=with_moz16, color = "green",            lwd = .7)+
  geom_hline(yintercept=with_moz17, color = "purple",           lwd = .8)+
  theme_minimal() +
  geom_text(aes(label = "Average Without \n Mozgov 2014-15",    y = without_moz - 1.5, x = as.Date("2015-01-09", format = "%Y-%m-%d")+ 35) , colour="turquoise3", fontface = "bold" , angle=0, size=4) +
  geom_text(aes(label = "Average With \n Mozgov 2014-15", y = with_moz- 2, x = as.Date("2015-01-09", format = "%Y-%m-%d")+ 35) , colour="red3", fontface = "bold" , angle=0, size=4) +
  geom_text(aes(label = "Average With \n Mozgov 2015-16", y = with_moz16 - 2, x = as.Date("2016-01-09", format = "%Y-%m-%d")) , colour="green3", fontface = "bold" , angle=0, size=4) +
  geom_text(aes(label = "Average Without \n Mozgov 2016-17", y = without_moz17 + 2, x = as.Date("2017-01-09", format = "%Y-%m-%d")) , colour="purple3", fontface = "bold" , angle=0, size=4)

