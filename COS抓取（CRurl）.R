library(RCurl)        # 加载类库
library(XML)
x<-paste("http://cos.name/cn/")

sc<-getURL("http://cos.name/cn/")
SCList=strsplit(sc, '"')[[1]]
interest<- SCList[grep('interest', SCList)+1]


getCOS<-function (x){
  url<-x       # COS的数据源地址
  doc = xmlTreeParse(getURL(url),useInternal = TRUE)  
  getNodeSet(doc, "//bbp-topic-permalink")
  
  topic<-sapply(ans, xmlGetAttr, "bbp-topic-permalink")
}
  


  topic = url %>% html() %>% html_nodes(".bbp-topic-permalink") %>%
  
  
  
  doc = xmlTreeParse(getURL(url),useInternal = TRUE)                              # 解析XML文档
  
  ans<-getNodeSet(doc, "//yweather:atmosphere")
  humidity<-as.numeric(sapply(ans, xmlGetAttr, "humidity"))                       # 温度
  visibility<-as.numeric(sapply(ans, xmlGetAttr, "visibility"))                   # 能见度
  pressure<-as.numeric(sapply(ans, xmlGetAttr, "pressure"))                       # 气压
  rising<-as.numeric(sapply(ans, xmlGetAttr, "rising"))                           # 气压变动
  
  ans<-getNodeSet(doc, "//item/yweather:condition")
  code<-sapply(ans, xmlGetAttr, "code")                                           # 天气情况
  
  ans<-getNodeSet(doc, "//item/yweather:forecast[1]")
  low<-as.numeric(sapply(ans, xmlGetAttr, "low"))                                 # 最高气温
  high<-as.numeric(sapply(ans, xmlGetAttr, "high"))                               # 最低气温
  
  print(paste(x,'==>',low,high,code,humidity,visibility,pressure,rising))
  cbind(low,high,code,humidity,visibility,pressure,rising)                        # 以data.frame格式返回
}


date <-

dates = function(x){
  date = x %>% html() %>% html_nodes(".bbp-reply-post-date") %>%
    html_text() %>% .[1] %>% as.vector
  return(date)
}

infofun = function(i) {
  
  
  
  url = str_c("http://cos.name/cn/page/", i,"/")
  
  topic = url %>% html() %>% html_nodes(".bbp-topic-permalink") %>%
    
    html_text() %>% as.vector
  
  author = url %>% html() %>%
    
    html_nodes(".bbp-topic-started-by .bbp-author-name") %>%
    
    html_text() %>% as.vector
  
  Links = url %>% html() %>% html_nodes(".bbp-topic-permalink") %>%
    
    html_attr("href") %>% as.vector
  
  day = lapply(Links,dates) %>% unlist
  
  data.frame(主题 = topic,作者= author,日期 = day)
  
}



#info.list = lapply(1:1675,infofun)

info.list = lapply(1:4,infofun)
info.list
