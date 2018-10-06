workout01-christine-zhu
================
Christine Zhu
10/5/2018

``` r
dat2$experience <- replace(dat2$experience, dat2$experience == "R", "0")
dat2$experience <- as.integer(dat2$experience)


dat2$salary <- dat2$salary/1000000

dat2$position <- factor(dat2$position, levels = c("C", "PF", "PG", "SF", "SG"), labels = c("center", "power_fd", "point_guard", "small_forward", "shoot_guard"))


dat2<-mutate(dat2,
             missed_fg = field_goals_atts -field_goals,
             missed_ft = points1_atts - points1,
             rebounds = def_rebounds + off_rebounds,
             efficiency = (points + rebounds + assists + steals + blocks - missed_fg - missed_ft - turnovers)/games)

sink(file = "../output/efficiency-summary.txt", append = FALSE)
summary(dat2$efficiency)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -0.6667  5.0000  8.3470  9.5790 12.6100 33.8300

``` r
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
```

    ## # A tibble: 30 x 15
    ##     team experience salary points3 points2 points1 points off_rebounds
    ##    <chr>      <dbl>  <dbl>   <dbl>   <dbl>   <dbl>  <dbl>        <dbl>
    ##  1   ATL        100     95     660    2337    1453   8107          832
    ##  2   BOS         63     94     985    2183    1536   8857          744
    ##  3   BRK         70     78     777    2040    1444   7855          689
    ##  4   CHI         59     95     565    2162    1330   7349          865
    ##  5   CHO         63     91     808    2089    1497   8099          621
    ##  6   CLE        145    129    1030    2148    1384   8770          735
    ##  7   DAL         65     95     712    1754    1007   6651          521
    ##  8   DEN         83     81     868    2351    1477   8783          872
    ##  9   DET         55    105     631    2638    1140   8309          908
    ## 10   GSW        113    102     982    2545    1455   9491          770
    ## # ... with 20 more rows, and 7 more variables: def_rebounds <dbl>,
    ## #   assists <dbl>, steals <dbl>, blocks <dbl>, turnovers <dbl>,
    ## #   fouls <dbl>, efficiency <dbl>

``` r
sink(file = "../data/teams-summary.txt")
summary(teams)
```

    ##      team             experience         salary          points3      
    ##  Length:30          Min.   : 39.00   Min.   : 58.00   Min.   : 519.0  
    ##  Class :character   1st Qu.: 59.00   1st Qu.: 87.50   1st Qu.: 620.0  
    ##  Mode  :character   Median : 67.50   Median : 95.00   Median : 718.0  
    ##                     Mean   : 74.13   Mean   : 94.23   Mean   : 737.8  
    ##                     3rd Qu.: 83.00   3rd Qu.:104.75   3rd Qu.: 805.8  
    ##                     Max.   :145.00   Max.   :129.00   Max.   :1140.0  
    ##     points2        points1         points      off_rebounds  
    ##  Min.   :1754   Min.   : 998   Min.   :6360   Min.   :521.0  
    ##  1st Qu.:2104   1st Qu.:1240   1st Qu.:7906   1st Qu.:711.0  
    ##  Median :2290   Median :1426   Median :8240   Median :780.0  
    ##  Mean   :2263   Mean   :1375   Mean   :8114   Mean   :776.9  
    ##  3rd Qu.:2458   3rd Qu.:1495   3rd Qu.:8611   3rd Qu.:863.0  
    ##  Max.   :2638   Max.   :1623   Max.   :9491   Max.   :962.0  
    ##   def_rebounds     assists         steals          blocks     
    ##  Min.   :1876   Min.   :1183   Min.   :483.0   Min.   :232.0  
    ##  1st Qu.:2455   1st Qu.:1551   1st Qu.:543.0   1st Qu.:318.2  
    ##  Median :2600   Median :1753   Median :591.5   Median :357.5  
    ##  Mean   :2552   Mean   :1744   Mean   :588.9   Mean   :363.0  
    ##  3rd Qu.:2692   3rd Qu.:1882   3rd Qu.:626.8   3rd Qu.:392.5  
    ##  Max.   :2869   Max.   :2486   Max.   :782.0   Max.   :554.0  
    ##    turnovers          fouls        efficiency   
    ##  Min.   : 674.0   Min.   :1168   Min.   :131.5  
    ##  1st Qu.: 972.8   1st Qu.:1444   1st Qu.:144.1  
    ##  Median :1029.5   Median :1567   Median :148.0  
    ##  Mean   :1025.0   Mean   :1519   Mean   :152.3  
    ##  3rd Qu.:1100.5   3rd Qu.:1620   3rd Qu.:160.6  
    ##  Max.   :1212.0   Max.   :1887   Max.   :182.1

``` r
sink()


write.csv(teams, file = "../data/nba-teams.csv", row.names= FALSE)



mean(teams$efficiency)
```

    ## [1] 152.3033

``` r
teams <- mutate(teams,
                efficiency_new = (1.5*points + steals + def_rebounds +off_rebounds + blocks - turnovers - 2*fouls))
```

``` r
ggplot(teams, aes(x= team, y = sort(salary))) +
  ggtitle("NBA Teams ranked by total salary")+
  geom_col() + 
  geom_hline(yintercept = mean(teams$salary), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Salary in millions") 
```

![](/Users/Christine/Documents/Berkeley/Stat133/workout1/report/rank%20by%20salary-1.png)

``` r
ggplot(teams, aes(x= team, y = sort(points))) +
  ggtitle("NBA Teams ranked by total points")+
  geom_col() + 
  geom_hline(yintercept = mean(teams$points), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Total points") 
```

![](/Users/Christine/Documents/Berkeley/Stat133/workout1/report/rank%20by%20points-1.png)

``` r
ggplot(teams, aes(x= team, y = sort(efficiency))) +
  ggtitle("NBA Teams ranked by total efficiency")+
  geom_col() + 
  geom_hline(yintercept = mean(teams$efficiency), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Efficiency Scores") 
```

![](/Users/Christine/Documents/Berkeley/Stat133/workout1/report/rank%20by%20efficiency-1.png)

``` r
#for my own effieciency index:
#efficiency_new = 1.5*points + steals + rebounds  - turnovers - 2*fouls 
#rationale: I think for an nba player, points are the most crucial thing, so I increased the weight on points by a factor of 1.5; additionally, fouls detract from the total efficiency of the team, so I also subtracted by a factor of 2* fouls (they detract from the efficiency, but the number of fouls doesn't ictate a team's ability: more aggressive teams may make more fouls but might also play better because of their aggressive nature, so boosting points (+ still including steals etc) accounts for that; I took away the missed free throws etc. because I think that in terms of basketball, people are most interested in who can bring the most points to the table)

ggplot(teams, aes(x= team, y = sort(efficiency_new))) +
  geom_col() + 
  geom_hline(yintercept = mean(teams$efficiency_new), color = "darkred") +
  coord_flip() +
  labs(x = "Team", y = "Efficiency Updated Scores") 
```

![](/Users/Christine/Documents/Berkeley/Stat133/workout1/report/rank%20by%20updated%20efficiency-1.png)

**Comments and reflections** I think in general, learning new things about visualization (e.g. adding lines/ random little things) took time to search up: due to my lack of practice, I also had some difficulty getting dplyr things right. For example, even though I've used mutate a lot it took me a while to realize that doing teams&lt;-mutate(dat2,....) was messing up the rest of my data, because it undid my previous changes/ groupings etc. It took me probably 3.5 hours to finish this even though everything was fairly basic—I think I need to become more familiar with a lot of the packages/ implications of dataframes in addition to things like round() which I had to search up. I also think it took some time to process what the assignment was really asking for, and of course, trying to build the data dictionary took me a long time just from tedious copy pasting the syntax for a table. This wasn't my first time using an R Script, but I still definitely prefer markdown. I think learning about all the new visualization stuff though was a lot of fun + things like write functions and sink functions
