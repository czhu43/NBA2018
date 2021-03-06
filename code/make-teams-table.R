# ---
#   title: "NBA 2018"
# author: "Christine Zhu"
# date: "10/02/2018"
# input: nba2018.csv, raw data 
# output: nba2018-teams.csv, effieciency-summary.txt
# ---


dat2$experience <- replace(dat2$experience, dat2$experience == "R", "0")
dat2$experience <- as.integer(dat2$experience)


dat2$salary <- dat2$salary/1000000

dat2$position <- factor(dat2$position, levels = c("C", "PF", "PG", "SF", "SG"), labels = c("center", "power_fd", "point_guard", "small_forward", "shoot_guard"))
summary(nba$position)


dat2<-mutate(dat2,
             missed_fg = field_goals_atts -field_goals,
             missed_ft = points1_atts - points1,
             rebounds = def_rebounds + off_rebounds,
             efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers)/games)

sink(file = "../output/efficiency-summary.txt", append = FALSE)
summary(dat2$efficiency)
sink()



teams <- dat2 %>%
  group_by(team) %>% 
  summarise(
    experience = round(sum(experience), 2),
    salary = round(sum(salary, 2)),
    points3 = round(sum(points3), 2),
    points2 = round(sum(points2), 2),
    points1 = round(sum(points1), 2),
    points = round(sum(points), 2),
    off_rebounds = round(sum(off_rebounds), 2),
    def_rebounds = round(sum(def_rebounds), 2),
    assists = round(sum(assists), 2),
    steals = round(sum(steals), 2),
    blocks = round(sum(blocks),2),
    turnovers = round(sum(turnovers), 2),
    fouls = round(sum(fouls), 2),
    efficiency = round(sum(efficiency), 2) )


teams

sink(file = "../data/teams-summary.txt")
summary(teams)
sink()


write.csv(teams, file = "../data/nba-teams.csv", row.names= FALSE)




ggplot(teams, aes(x= team, y = sort(points))) +
  ggtitle("NBA Teams ranked by total points")+
  geom_col() + 
  geom_hline(yintercept = mean(teams$points), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Total points") 

ggplot(teams, aes(x= team, y = sort(efficiency))) +
  ggtitle("NBA Teams ranked by total efficiency")+
  geom_col() + 
  geom_hline(yintercept = mean(teams$efficiency), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Efficiency Scores") 

mean(teams$efficiency)

teams <- mutate(teams,
                efficiency_new = (1.5*points + steals + def_rebounds +off_rebounds + blocks - turnovers - 2*fouls))

#for my own effieciency index:
#efficiency_new = 1.5*points + steals + rebounds  - turnovers - 2*fouls 
#rationale: I think for an nba player, points are the most crucial thing, so I increased the weight on points by a factor of 1.5; additionally, fouls detract from the total efficiency of the team, so I also subtracted by a factor of 2* fouls (they detract from the efficiency, but the number of fouls doesn't ictate a team's ability: more aggressive teams may make more fouls but might also play better because of their aggressive nature, so boosting points (+ still including steals etc) accounts for that; I took away the missed free throws etc. because I think that in terms of basketball, people are most interested in who can bring the most points to the table)

ggplot(teams, aes(x= team, y = sort(efficiency_new))) +
  geom_col() + 
  geom_hline(yintercept = mean(teams$efficiency_new), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Efficiency Updated Scores") 


#Comments and reflections
# I think in general, learning new things about visualization (e.g. adding lines/ random little things) took time to search up: due to my lack of practice, I also had some difficulty getting dplyr things right. For example, even though I've used mutate a lot it took me a while to realize that doing teams<-mutate(dat2,....) was messing up the rest of my data, because it undid my previous changes/ groupings etc. It took me probably 3.5 hours to finish this even though everything was fairly basic—I think I need to become more familiar with a lot of the packages/ implications of dataframes in addition to things like round() which I had to search up. I also think it took some time to process what the assignment was really asking for, and of course, trying to build the data dictionary took me a long time just from tedious copy pasting the syntax for a table. This wasn't my first time using an R Script, but I still definitely prefer markdown. I think learning about all the new visualization stuff though was a lot of fun + things like write functions and sink functions
