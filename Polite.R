library(rvest)
library(polite)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(glue)
library(rlang)

topg_url <- "https://en.wikipedia.org/wiki/1994_FIFA_World_Cup"

session <- bow(topg_url,
               user_agent = "Filipe Webscraping Tutorial")

session

#Scraping Tables
tables_94 <- scrape(session) %>%
  html_nodes("table.wikitable")

#Choosing the Final Standings Table
final_standings <- tables_94[13] %>% html_table() %>% flatten_df() %>% set_names(c("Position","Team","Group","Games","Wins","Draws","Losses","GoalsFor","GoalsAgainst","GoalDifference","Points"))

final_standings <- final_standings[-c(5,10,19),]

#Transform the columns 4:11 in numeric. Produces NA in GoalDifference
final_standings[,4:11] <- lapply(final_standings[,4:11],as.numeric)
final_standings$Group <- as.factor(final_standings$Group)

#Transform GoaldDifference 
final_standings$GoalDifference <- final_standings$GoalsFor-final_standings$GoalsAgainst

View(final_standings)

                      
