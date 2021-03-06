library(RMySQL)

conn <- dbConnect(MySQL(), dbname='dblab', username='root', password='root', host='127.0.0.1', port=3306)

query = 'select * from user_action LIMIT 100000'

user_action <- dbGetQuery(conn,query)

#summary(as.numeric(user_action$behavior_type))

#library(ggplot2)
# ggplot(user_action, aes(as.numeric(behavior_type)))+geom_histogram()

temp <- subset(user_action, as.numeric(behavior_type)==4)
count <- sort(table(temp$item_category), decreasing=T)
result <- as.data.frame(count[1:10])

#ggplot(result, aes(Var1, Freq, col=factor(Var1)))+geom_point()

mouth <- substr(user_action$visit_date,6,7)
user_action <- cbind(user_action, mouth)

# ggplot(user_action,aes(as.numeric(behavior_type), col=factor(mouth)))+geom_histogram()+facet_grid(.~mouth)

library(recharts)
rel <- as.data.frame(table(temp$province))
provinces <- rel$Var1
# print(provinces)
x = c()
for(n in provinces) {
x[length(x)+1] = nrow(subset(temp,(province==n)))
}
# print(x)
mapData <- data.frame(province = rel$Var1,count=x,stringAsFactors=F)
#print(mapData)
e1 = eMap(mapData, namevar=~province, datavar=~count)
# because the map can't be showed when I use cmd,so I save the map as a .html file named el.html
htmlwidgets::saveWidget(e1, 'e1.html')


