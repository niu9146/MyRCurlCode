# 前面有个帖子介绍了英超球赛的数据趴取，现在要与时俱进，用R的另一个包同样可以简洁的趴取这个网站的数据。
library(rvest)
library(rjson)
url = "http://data2.7m.cn/history_Matches_Data/2009-2010/92/en/fixture.js"

dat = url %>% html() %>% html_nodes('p') %>% html_text()
data = strsplit(dat,"\r\n")

Round = data[[1]][6]
Round = substr(Round,regexpr("\\[",Round)[1],regexpr("\\]",Round)[1])
Round = fromJSON(Round)
                
Date = data[[1]][7]
Date = substr(Date,regexpr("\\[",Date)[1],regexpr("\\]",Date)[1])
Date = fromJSON(Date)
                
Scores = data[[1]][8]
Scores = substr(Scores,regexpr("\\[",Scores)[1],regexpr("\\]",Scores)[1])
Scores = fromJSON(Scores)
                
Home = data[[1]][11]
Home = substr(Home,regexpr("\\[",Home)[1],regexpr("\\]",Home)[1])
Home = fromJSON(Home)
                
Away = data[[1]][12]
Away = substr(Away,regexpr("\\[",Away)[1],regexpr("\\]",Away)[1])
Away = fromJSON(Away)
                
Total = data.frame(轮次 = Round,日期 = Date,主队 = Home,得分 = Scores,客队 = Away)
                
a = seq(1,nrow(Total),10) 
England = lapply(a, function(i) Total[ii+9),]) 

# 比如向查看地38轮的比赛：
England[[38]]

# 轮次                日期              主队     得分              客队
# 371   38 2010,05,09,23,00,00           Everton 1-0(0-0)        Portsmouth
# 372   38 2010,05,09,23,00,00   West Ham United 1-1(1-1)   Manchester City
# 373   38 2010,05,09,23,00,00  Bolton Wanderers 2-1(1-0)        Birmingham
# 374   38 2010,05,09,23,00,00 Manchester United 4-0(2-0)        Stoke City
# 375   38 2010,05,09,23,00,00        Chelsea FC 8-0(2-0)    Wigan Athletic
# 376   38 2010,05,09,23,00,00       Aston Villa 0-1(0-0)  Blackburn Rovers
# 377   38 2010,05,09,23,00,00            Wolves 2-1(1-1)        Sunderland
# 378   38 2010,05,09,23,00,00           Burnley 4-2(1-2) Tottenham Hotspur
# 379   38 2010,05,09,23,00,00           Arsenal 4-0(3-0)            Fulham
# 380   38 2010,05,09,23,00,00         Hull City 0-0(0-0)         Liverpool

# 要查看第一轮的比赛：
England[[1]]