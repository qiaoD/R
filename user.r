library(RMySQL)

conn <- dbConnect(MySQL(), dbname='dblab', username='root', password='root', host='127.0.0.1', port=3306)

query = 'select * from user_action LIMIT 100000'

user_action <- dbGetQuery(conn,query)

summary(as.numeric(user_action$behavior_type))

library(ggplot2)
ggplot(user_action, aes(as.numeric(behavior_type)))+geom_histogram()

