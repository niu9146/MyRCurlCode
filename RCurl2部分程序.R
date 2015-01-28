library("RCurl")
library(XML)
# new
# new2
url.exists("http://baidu.com")
d=debugGatherer()
temp <-getURL("http://www.dataguru.cn/",debugfunction=d$update,verbose =TRUE)
cat(d$value()[3])#提交给服务器的头信息
cat(d$value()[1])#服务器地址以及端口号
cat(d$value()[2])#服务器端返回的头信息
# d$reset()
# d$value()

headers = basicTextGatherer()
txt=getURL("http://www.dataguru.cn/",headerfunction = headers$update)
names(headers$value()) #说明是字符串形式
headers$value()


h = basicHeaderGatherer()
txtt=getURL("http://www.dataguru.cn/",headerfunction = h$update)
names(h$value())
h$value()

curl = getCurlHandle() # 了解交互时间等信息
d=getURL("http://www.dataguru.cn/", curl = curl)
getCurlInfo(curl)$response.code
getCurlInfo(curl)


########################################
# 伪装自己的header信息
myheader<-c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)
temp2<-getURL("http://baidu.com",httpheader=myheader)


d2=debugGatherer()
temp3<-getURL("http://baidu.com",httpheader=myheader,debugfunction=d2$update,verbose =T)
cat(d2$value()[3])#提交给服务器的头信息
########################################




########################################
listCurlOptions() #除了header，可设参数有170多种

#getForm()  可以做搜索，通过修改wd的参数，实现模拟搜索，返回结果是百度的搜索结果

character=c("http://www.baidu.com/s?wd=RCurl&rsv_spt=1&issp=1&f=3&rsv_bp=0&rsv_idx=2&ie=utf-8&tn=baiduhome_pg&rsv_enter=0&rsv_pq=945171d00006779d&rsv_t=b0518Zb396TeojdQOab%2Fq2O8BZ0SMcXNo8lVE06mb3DvVzl3WbOCxET5rr3DFjpd5qHz&inputT=2715&rsv_sug3=14&rsv_sug1=4&rsp=0&rsv_sug4=10406")
getFormParams(character)
url=getForm("http://www.baidu.com/s", 
            "wd"="RCurl", 
            rsv_spt="1", 
            issp="1" ,
            f="3", 
            rsv_bp="0",
            rsv_idx="2" ,
            ie="utf-8" ,
            tn="baiduhome_pg" ,
            rsv_enter="0" ,
            rsv_pq="945171d00006779d" ,
            rsv_t="b0518Zb396TeojdQOab%2Fq2O8BZ0SMcXNo8lVE06mb3DvVzl3WbOCxET5rr3DFjpd5qHz", 
            inputT="2715" ,
            rsv_sug3="14" ,
            rsv_sug1="4", 
            rsp="0" ,
            rsv_sug4="10406")
write.table(url,"E:/RCurl/1.txt")


url2=getForm("http://www.baidu.com/s", 
            "wd"="电影团购", 
            rsv_spt="1", 
            issp="1" ,
            f="3", 
            rsv_bp="0",
            rsv_idx="2" ,
            ie="utf-8" ,
            tn="baiduhome_pg" ,
            rsv_enter="0" ,
            rsv_pq="945171d00006779d" ,
            rsv_t="b0518Zb396TeojdQOab%2Fq2O8BZ0SMcXNo8lVE06mb3DvVzl3WbOCxET5rr3DFjpd5qHz", 
            inputT="2715" ,
            rsv_sug3="14" ,
            rsv_sug1="4", 
            rsp="0" ,
            rsv_sug4="10406")
write.table(url2,"E:/RCurl/2.txt")


########################################
#登录ftp
url=c("ftp.wcc.nrcs.usda.gov/data/snow/snow_course/table/history/idaho")
filename=getURL(url,dirlistonly = TRUE ) #读取目录

# 登录新浪 getURL
curl=getCurlHandle()
destination=getURL("http://www.sina.com.cn",curl=curl)
destination=getURL("http://www.sina.com",curl=curl,followlocation = TRUE) 
  # followlocation = TRUE,为自动跳转。 
  # maxredirs = as.integer(20),最大重定向次数，一般为3-5.
getCurlInfo(curl)

# getBinaryURL {RCurl} 下载文件
url=c("ftp://202.194.76.5")# 访问济南大学FTP服务器
temp=getBinaryURL(url)
note=file("e:/RCurl/hellodata.xls",open="wb") #写入目录列表到excel文件
writeBin(temp,note)   #写入目录列表到excel文件
close(note)

url2="http://www.zzrsks.com.cn/UploadFiles/File/2012%E5%B9%B4%E8%81%8C%E7%A7%B0%E5%A4%96%E8%AF%AD%E8%80%83%E8%AF%95%E5%90%88%E6%A0%BC%E4%BA%BA%E5%91%98%E5%90%8D%E5%8D%95.xls"
temp2=getBinaryURL(url2)
note=file("e:/RCurl/mingdan.xls",open="wb") #写入目录列表到excel文件
writeBin(temp2,note)   #写入目录列表到excel文件
close(note)


# strsplit  切割文件
class(Sys.time())
strsplit(as.character(Sys.time()),' ')
unlist(strsplit(as.character(Sys.time()),' '))[2]
unlist(strsplit(as.character(Sys.time()),' '))[1]

url3="http://rfunction.com/code/1202/"
filename=getURL(url3,dirlistonly = TRUE ) #读取文件名
filename
sfilename=unlist(strsplit(filename,"<li><a href="))
sfilename=unlist(strsplit(sfilename,"</a></li>\n"))
strsplit(sfilename[[3]]," ")[1,2]

# 下载文件
url3="http://rfunction.com/code/1202/"
html=getURL(url3)
temp =strsplit(html, "<li><a href=\"")[[1]]
files1 =strsplit(temp, "\"")

#######################
#单一文件取文件名
files1[3]       
unlist(files1[3])[1]
#######################
# lapply 应用在所有变量上，取文件名。

files2=lapply(files1, function(x){ x[1] })
files3= unlist(files2)
files4 = files3[-(1:2)]
files4[1]

baseURL="http://rfunction.com/code/1202/"
for(i in 1:length(files)){
  URL = paste(baseURL, files[i], sep="")
  
  
  bin <- getBinaryURL(URL)
  con <- file(paste("1202", files[i], sep="."), open = "wb")
  writeBin(bin, con)
  close(con)
  Sys.sleep(2) #每读一次休息2秒，避免被站点识别为恶意连接
}


########################################



url="ftp.wcc.nrcs.usda.gov/data/snow/snow_course/table/history/idaho/"
filenames = getURL(url, dirlistonly = TRUE)

curl = getCurlHandle()
destination=getURL("http://www.sina.com”, curl = curl)
                   getCurlInfo(curl)$response.code
                   
                   followlocation=T
                   
                   
                   Sys.time()
                   strsplit(Sys.time,'')
                   class(Sys.time)
                   class(Sys.time())
                   as.character(Sys.time())
                   strsplit(as.character(Sys.time()),'')
                   strsplit(as.character(Sys.time()),' ')
                   strsplit(as.character(Sys.time()),' ')[2]
                   unlist(strsplit(as.character(Sys.time()),' '))
                   unlist(strsplit(as.character(Sys.time()),' '))[2]
                   
                   
                   url="http://job.abchina.com/abb/download_accessory.do?action=accessory&pronunciamentoId=46702"
                   temp<- getBinaryURL(url)
                   note <- file("hellodata.xls,open = "wb")
writeBin(temp,note)
close(note)








##########第一段视频↑######
##########第二段视频↓######

library(RCurl)
library(XML)


url="http://www.bioguo.org/AnimalTFDB/BrowseAllTF.php?spe=Mus_musculus"
wp<-getURL(url)

#htmlParse()解析XML或HTML文件或字符串包含XML / HTML内容，
# 并生成一个R表示XML / HTML树。
doc <-htmlParse(wp, asText= TRUE) 

# readHTMLTable()读取一个文件的文件名或URL给所有的表，
#或已解析的文件通过HtmlParser。
#或者，可以指定文档中的单个节点表
tables <-readHTMLTable(doc,which=5)
write.table(tables,"e:/RCurl/1.xls")


#########################################
#抓取http://scholarlyoa.com/other-pages/hijacked-journals/上的表格

url2="http://scholarlyoa.com/other-pages/hijacked-journals/"
bg<-getURL(url2)
doc2 <-htmlParse(bg, asText= TRUE) 
tables2 <-readHTMLTable(doc2,which=2)
write.table(tables2,"e:/RCurl/3.xls")

########################################



url="http://219.143.71.11/wdc4seis@bj/earthquakes/csn_quakes_p001.jsp"
wp<-getURL(url)
doc <-htmlParse(wp, asText= TRUE)
tables <-readHTMLTable(doc)
tables <-readHTMLTable(doc,header=F,which=2)




url="http://www.w3school.com.cn/example/xmle/books.xml"
doc<-xmlParse(url)

getNodeSet(doc,"/bookstore/book[1]")  #抓取第一本书
getNodeSet(doc,"/bookstore/book[last()]") #抓取最后一本书
getNodeSet(doc,"/bookstore/book[position()<3]") #抓取前2本书本书

getNodeSet(doc,'//title[@lang]') # 抓取title具有lang属性的数据
getNodeSet(doc,'///book/price') # 抓取价格数据

getNodeSet(doc,'//title[@lang]|//book/price') # 抓取title具有lang属性的数据中的价格

###########################################
#大众点评电影团购数据抓取

myheader=c("User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
           "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
           "Accept-Language"="en-us",
           "Connection"="keep-alive",
           "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)
temp=getURL("http://t.dianping.com/guangzhou?q=%E7%94%B5%E5%BD%B1",encoding="UTF-8")
write.table(temp,"e:/RCurl/tuanguangzhou.txt")
k=htmlParse(temp)
getNodeSet(k,'//script[@type="text/plain"]')[95]
youhui=sapply(getNodeSet(k,'//script[@type="text/plain"]'),xmlValue)
youhui[95]

urllist=0
page=1:5
urllist[page]=paste("http://t.dianping.com/guangzhou?pageno=",page,"&q=%E7%94%B5%E5%BD%B1",sep='')
for(url in urllist)
{
  temp=getURL(url,httpheader=myheader,encoding="UTF-8")
  
  k=htmlParse(temp)
  
  youhui=sapply(getNodeSet(k,'//script[@type="text/plain"]'),xmlValue)
  cat(url,"\n")   #防止出错，把URL输出来，cat函数用于输出到外部文件。
}
##########################################
# 济南大众点评电影团购抓取
myheader=c("User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
           "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
           "Accept-Language"="en-us",
           "Connection"="keep-alive",
           "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)
url="http://t.dianping.com/movie/jinan"
temp=getURL(url,httpheader=myheader,encoding="UTF-8")
write.table(temp,"e:/RCurl/tuanjinan.txt")
k=htmlParse(temp)
getNodeSet(k,'//li[@class="J_floor_box floor-box"]')
# write.table(k,"e:/RCurl/tuan2.txt") #想保存，但保存不了？？？？
youhui=sapply(getNodeSet(k,'//li[@class="J_floor_box floor-box"]'),xmlValue)
youhui[1]

dyy= unlist(strsplit(as.character(youhui[1]),"\n"))[7]
dyy=gsub(pattern=" ", replacement="",dyy)
yj=unlist(strsplit(as.character(youhui[1]),"\n"))[20]
yj=gsub(pattern=" ", replacement="",yj)
xj=unlist(strsplit(as.character(youhui[1]),"\n"))[17]
xj=gsub(pattern=" ", replacement="",xj)

t=lapply(youhui,function(x){
  dyy= unlist(strsplit(as.character(x),"\n"))[7]
  dyy=gsub(pattern=" ", replacement="",dyy)
  yj=unlist(strsplit(as.character(x),"\n"))[20]
  yj=gsub(pattern=" ", replacement="",yj)
  xj=unlist(strsplit(as.character(x),"\n"))[17]
  xj=gsub(pattern=" ", replacement="",xj) 
  tt=c(dyy,yj,xj)
  return(tt)
}
  )


urllist=0
page=1:5
urllist[page]=paste("http://t.dianping.com/guangzhou?pageno=",page,"&q=%E7%94%B5%E5%BD%B1",sep='')
for(url in urllist)
{
  temp=getURL(url,httpheader=myheader,encoding="UTF-8")
  
  k=htmlParse(temp)
  
  youhui=sapply(getNodeSet(k,'//script[@type="text/plain"]'),xmlValue)
  cat(url,"\n")
}