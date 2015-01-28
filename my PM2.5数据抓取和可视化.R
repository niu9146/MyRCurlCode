library(RgoogleMaps)
library(RCurl)
library(XML)
Start = Sys.time()
day = 13
skip = 0
website = "http://www.tianqi.com/air/"

pm = getURL(website,.encoding="UTF-8")
pmweb = htmlParse(pm,encoding="UTF-8")

pmtotal = getNodeSet(pmweb,"//div[@class='warp']//a")
pmurl = sapply(X=pmtotal,FUN=xmlGetAttr,name="href")
pmcityA = getNodeSet(pmtotal[[1]],"//strong")
pmcity = sapply(X=pmcityA,FUN=xmlValue)
pmcity = gsub(pattern="[A-Z]",replacement="",x=pmcity)
remove.160 = function(x)
{
  x = strsplit(x=x,split="")[[1]]
  index = sapply(X=x,FUN=utf8ToInt)
  x = x[index!=160&index!=32]
  return(paste(x,collapse=""))
}
pmcity = sapply(X=pmcity,FUN=remove.160)
pmcity = as.character(pmcity[pmcity!=""])
pmurl = pmurl[!grepl(pattern="article",x=pmurl)]
index = match(c("黄山风景区","菏泽","九华山风景区","恩施","黄冈","随州"),table=pmcity)
pmcity = pmcity[-index]
pmurl = pmurl[-index]
result = NULL
for( i in pmcity)
{
  tmp = China[grepl(pattern=i,x=China$County),]
  if(nrow(tmp)>1)
    tmp = tmp[1,]
  result = rbind(result,tmp)
  rm(tmp)
}


data = NULL
date = NULL
for( i in pmurl)
{
  #i = pmurl[45]
  city = pmcity[match(i,table=pmurl)]
  cat(paste("Get data for",city,"... ...\n"))
  cityweb = getURL(url=paste(website,i,sep="/"),.encoding="UTF-8")
  cityweb = strsplit(x=cityweb,split="flashvalue")[[1]]
  cityweb = cityweb[grepl(pattern="set name",x=cityweb)]
  cityweb = cityweb[grepl(pattern="月",x=cityweb)]
  pm = NULL
  if(length(cityweb) == 0)
  {
    cat("Date is incorrect... skip...\n")
    next
  }
  
  for(j in cityweb[day])
  {
    j = cityweb[day]
    tmp = strsplit(x=j,split="\\s")[[1]]
    name = tmp[grepl(pattern="name",x=tmp)]
    name = strsplit(x=name,split="\\'")[[1]][2]
    value = tmp[grepl(pattern="value",x=tmp)]
    value = as.numeric(strsplit(x=value,split="\\'")[[1]][2])
    rm(tmp)
    pm = cbind(pm,value)
  }
  if(!is.null(date))
  {
    if(date != name)
    {
      cat("Date is incorrect... skip...\n")
      skip = skip + 1
      next
    }
  }else{
    date = name
  }
  data = rbind(data,cbind(city=city,pm))
}

lon = NULL
lat = NULL
for( i in data[,1])
{
  tmp = China[grepl(pattern=i,x=China$County),]
  tmp = tmp[1,]
  lon = c(lon,tmp[1,4])
  lat = c(lat,tmp[1,5])
}
#col.base = c("green","orange","red")
pm = as.numeric(data[,2])
#col = ifelse(test=pm<100,yes=1,ifelse(pm>200,yes=3,no=2))
#col = col.base[col]
tp.pm = GetMap.bbox(lonR=lon,latR=lat)
pm.max = max(pm)
red = seq(from=0,to=1,length.out=pm.max)
green = seq(from=1,to=0,length.out=pm.max)
blue = seq(from=0,to=0,length.out=pm.max)
col = rgb(red=red,green=green,blue=blue,alpha=0.5)
col = col[pm]
cex = pm/100 + 5
suppressWarnings(expr=PlotOnStaticMap(MyMap=tp.pm,lat=lat,lon=lon,pch=20,col=col,cex=cex,mar=c(0,0,2,0)))
title(main=paste(date,"全国",length(pm),"个主要城市PM2.5分布情况",sep=""))
text.col = rgb(red=1,green=1,blue=1,alpha=0.9)
text(x=210,y=-250,labels=paste("数据来源：",website,sep=""),cex=0.8,col=text.col)
text(x=210,y=-230,labels="R语言  RgoogleMaps  @Conda",cex=0.8,col=text.col)
Stop = Sys.time()
Cost = Stop - Start
cat(paste("\n\n\nIt cost",Cost,"minutes.\n"))
cat(paste("Gather",length(pm),"cities pm 2.5 data, and skip",skip,"city for incorrect date."))
