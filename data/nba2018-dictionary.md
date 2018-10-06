---
title: "NBA 2018 Data Dictionary"
author: "Christine Zhu"
date: "8/29/2018"
output: github_document
---

## About This Data

This data is a comprehensive dataset covering NBA player statistics from the 2018 NBA season, including player names and their respective stats (like height, weight, experience, various point statistics). 

**Summary**

Number of rows/ players: 477
Number of columns: 38 

``` {r}
colSums(is.na(dat2))
which(is.na(dat2$points2_perc))
dat2[16,]
colSums(is.na(dat2))
```

Running the above code in R indicates that missing values are codified as NA. 

- points3_perc: 39 NAs

- points1_perc: 19 NAs

- points2_perc: 5 NAs


**Additional Information** 

There are five types of player positions (see [wikipedia](https://en.wikipedia.org/wiki/Basketball_positions) for more details):

+ `PG`: point guard
+ `SG`: shooting guard
+ `SF`: small forward
+ `PF`: power forward
+ `C`: center

You can also find out more about each team through [basketball reference](https://www.basketball-reference.com). 

For example: [More information about GSW](https://www.basketball-reference.com/teams/GSW/)


|Variable    | Description |Type                |
|:---------|:-------------------|:---------------|
player| first and last names of player |  Factor |
|number| number on jersey| Factor | 
|team |3-letter team abbreviation | Factor | 
|position| player’s position | Factor | 
| height| height in feet-inches| Factor |
| weight| weight in pounds | Numeric |
| birth_date| date of birth (“Month day, year”)| Factor |
| country| Numeric |-letter country abbreviation| Factor |
| experience| years of experience in NBA (a value of R means rookie) | Factor |
|college| college attended in USA| Factor |
| salary| player salary in dollars| Numeric |
| rank| Rank of player in his team | Integer |
| age| Age of Player at the start of February Factor |st of that season | Integer |
| games| Games Played furing regular season | Integer |
| sames_started| Games Started | Integer |
| minutes| Minutes Played during regular season | Integer |
| field_goals| Field Goals Made| Integer |
| field_goals_atts| Field Goal Attempts | Integer |
| field_goals_perc| Field Goal Percentage | Numeric |
| points3 |3-Point Field Goals | Integer |
| points3_atts|3-Point Field Goal Attempts | Integer |
| points3_perc|3-Point Field Percentage | Numeric |
| points2 |2-Point Field Goals| Integer |
| points2_atts|2-Point Field Goal Attempts | Integer |
| points2_perc|2-Point Field Goal Percentage | Numeric |
| effective_field_goal_perc| Effective Field Goal Percentage | Numeric |
| points1 | Free Throws Made | Integer |
| points1_atts| Free Throw Attempts| Integer |
| points1_perc| Free Throw Percentage | Numeric |
| off_rebounds| Offensive Rebounds | Integer |
| def_rebounds| Defensive Rebounds | Integer |
| assists| Assists | Integer |
| steals| Steals |Integer |
| blocks| Blocks |Integer |
| turnovers| Turnovers |Integer |
| fouls| Fouls |Integer | 
| points| Total points |Integer | 



