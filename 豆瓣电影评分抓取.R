library(rvest)

url = 'http://movie.douban.com/top250?format=text'
web = html(url,encoding="UTF-8")


score =  html_text(web %>% html_nodes("span") %>% html_nodes("em"))

year =  web %>% html_nodes("p")
year =  html_text(year[seq(1,50,2)])

gy = gregexpr('[0-9]{4}',year)
gd = gregexpr("导演",year)
gz = gregexpr("主演",year)

time = sapply(1:length(gy),function(i) substr(year[i],gy[[i]],gy[[i]]+attr(gy[[i]],'match.length')-1))
direct = sapply(1:length(gy),function(i) substr(year[i],gd[[i]] + 4,gz[[i]] - 4))
actor = sapply(1:length(gy),function(i) substr(year[i],gz[[i]] + 4,gy[[i]] - 4))
ga = gregexpr('\n',actor)
actor = sapply(1:length(gy),function(i) substr(actor[i],1,ga[[i]] - 1))

names =   web %>% html_nodes("img") %>% html_attr("alt")
names = iconv(names,"utf-8","gbk")

rates =  html_text(web %>% html_nodes("span"))
rates = rates[grep("人评价",rates)]
rates = gsub("人评价","",rates)


movie = data.frame(电影 = names,时间 = time,得分 = score,评价人数 = rates,导演 = direct,主演 = actor)
head(movie)
