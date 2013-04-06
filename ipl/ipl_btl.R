library("BradleyTerry2")

library("RPostgreSQL")

drv <- dbDriver("PostgreSQL")

con <- dbConnect(drv,host="localhost",port="5432",dbname="cricket")

query <- dbSendQuery(con, "
select
g.team_won as outcome,
g.team_1 as team,
g.team_2 as opponent
from ipl.games g
where
    extract(year from g.game_date) between 2011 and 2011
;")

games <- fetch(query,n=-1)
dim(games)

fit <- BTm(outcome,team,opponent,data=games)
fit

btl <- as.data.frame(BTabilities(fit))
btl[with(btl, order(-ability)), ]

quit("no")
