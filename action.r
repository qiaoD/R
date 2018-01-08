library(RMySQL)

conn <- dbConnect(MySQL(), dbname='dblab', username='root', password='root', host='127.0.0.1', port=3306)

query = 'select * from user_action LIMIT 100000'

user_action <- dbGetQuery(conn,query)

summary(as.numeric(user_action$behavior_type))

library(ggplot2)
# ggplot(user_action, aes(as.numeric(behavior_type)))+geom_histogram()

temp <- subset(user_action, as.numeric(behavior_type)==4)
count <- sort(table(temp$item_category), decreasing=T)
result <- as.data.frame(count[1:10])
ggplot(result, aes(Var1, Freq, col=factor(Var1)))+geom_point()

