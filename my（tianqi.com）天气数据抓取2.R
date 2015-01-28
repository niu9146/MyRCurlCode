library(rvest)

url <- 'http://www.weather.com.cn/weather1d/101120101.shtml'
web <- html(url,encoding="UTF-8")

title<- html_text(web %>% html_nodes("title")) # 获取网页标题


sk<-html(web,"sk")
sk %>% html_nodes("tem span")%>%html_text()%>%as.numeric()


html_text(sk ,"win")
html_text(web,"win")

html_tag(web)
html_attr(web,"win" )


html_nodes(web,  xpath = "//table//td")


today =  web %>% html_nodes("p") # %>% html_nodes("updataTime")
today =  today%>%html_text("today")
today =  today%>%html_nodes("sk")
