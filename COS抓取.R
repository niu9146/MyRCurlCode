library(rvest)

library(stringr)

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

> info.list = lapply(1:4,infofun)
> info.list