require(stringr)
require(rvest)
require(rjson)

myfun = function(x){
  url = str_c("http://list.jd.com/list.html?cat=9987%2C653%2C655&page=",x,"&JL=6_0_0")
  brand = url %>% html_session() %>% html_nodes(".right-extra .p-name a") %>% html_text() 
  b = brand[-c(1:(length(brand) - 60))] %>% strsplit(" ")
  b1 = sapply(1:60,function(i) paste(b[[i]][1],collapse = ''))
  b2 = sapply(1:60,function(i) paste(b[[i]][2],collapse = ''))
  b3 = sapply(1:60,function(i) paste(b[[i]][-c(1:2)],collapse = ''))
  evalue = url %>% html_session() %>% html_nodes(".evaluate a") %>% html_text() %>% str_extract("\\d+") 
  price = url %>% html_session() %>% html_nodes(".p-price span") %>% html_attrs() %>% unlist %>% as.vector %>% str_replace('p','J_')
  price1 = apply(as.matrix(price),2,paste,collapse = ',')
  
  u = str_c("http://p.3.cn/prices/mgets?skuIds=",price1)
  dat = u %>% html() %>% html_nodes("p") %>% html_text()
  p = fromJSON(dat)
  price =sapply(1:60,function(i) p[[i]]$p)
  
  data.frame(品牌 = b1,型号 = b2,性能描述 = b3,评价人数 = evalue,价格 = price)
}

dat = lapply(1:4,myfun) #总计有44页
total = do.call(rbind,dat)

> tail(total)