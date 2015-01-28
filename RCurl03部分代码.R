############################
# 字符串处理

# 赋值
# 长度、个数：nchar，length
# 替换：chartr（原始字符，替换字符，字符串）
# 连接：paste  参数sep，collapse(增加连接符)
# 切割：strsplit
# 比较：>、<、==、!=
# 并集、交集、补集：union，intersect，setdiff
# 截取：substr，substring
# 匹配：match，pmatch，charmatch


mychar="dataguru"
list=c("data","gu","ru")
chartr("u","r",mychar)
paste("data","guru")
paste0("data","guru")
paste(list,collapse="-")  #collapse 是针对数组处理的，字符串不行。
paste("data","gu","ru",collapse ="-")

substr(mychar,1,4)  #仅辨别第一个参数的
substring(mychar,1,4)

substr(mychar,c(1,2),4)         # 从1-4
substring(mychar,c(1,2),4)      # 从1-4，从2-4
substring(mychar,c(1,2),c(2,4)) #从1-2，从2-4

match(mychar,list)
match("data",list) #返回位置
match("dat",list) #返回位置,match是完全匹配，
pmatch("at",list) #返回位置,match是完全匹配，

pmatch("gu",list) #返回位置,pmatch是部分匹配，
pmatch("u",list) #返回位置,pmatch是部分匹配，仅从字符串的头开始

charmatch("g",list) #返回位置,charmatch是部分匹配，一个字符也行。

#正则表达式
 
# \：转义字符
# .：除了换行以外的任意字符
# ^：一行字符串的起始
# $：一行字符串的结束
# *：零个或者多个之前的字符
# +：一个或者多个之前的字符
# ?：零个或者一个之前的字符
# 保留字符都需要转义字符\来转义表示

# sd* 可以匹配到s，sd，sddd，


# 方括号[]，代表可以匹配其中任何一个字符。而^在[]中代表“非”, -代表“之间”
#     [qjk]：q，j，k中任意一个字符
#     [^qjk]：非q，j，k的任意其它字符
#     [a-z]：a至z中任意一个小写字符
#     [^a-z]：非任意一个a至z小写字符的其它字符（可以是大写字符）
#     [a-zA-Z]：任意一个英文字母
#     [a-z]+：一个或者多个小写英文字母
# |：或者
# 小括号()与花括号｛｝配合“|”使用,
# d{1},匹配d出现1次，d{1,}匹配1以上个d,d{1,4}匹配d出现1-4次，


# 常用的特殊转义字符含义
# \n：换行符
# \t：tab
# \w：任意字母（包括下划线）或者数字即[a-zA-Z0-9_]
# \W：\w的反义即[^a-zA-Z0-9_]
# \d：任意一个数字即[0-9]
# \D：\d的反义即[^0-9]
# \s：任意一个空格，比如space, tab, newline 等
# \S：\s的反义，任意一个非空格
 



#邮箱的正则匹配表达式：/^[a-z]([a-z0-9]*[-_]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2})?$/i
#国际域名格式如下：域名由各国文字的特定字符集、英文字母、数字及“-”(即连字符或减号)任意组合而成, 但开头及结尾均不能含有“-”，“-”不能连续出现 。 域名中字母不分大小写。域名最长可达60个字节(包括后缀.com、.net、.org等)。 
#说明：
# ①/内容/i 构成一个不区分大小写的正则表达式；^ 匹配开始；$ 匹配结束。
# ②[a-z] E-Mail前缀必需是一个英文字母开头
# ③([a-z0-9]*[-_]?[a-z0-9]+)* 和_a_2、aaa11、_1_a_2匹配，和a1_、aaff_33a_、a__aa不匹配，如果是空字符，也是匹配的，*表示0个或者多个。
# ④*表示0个或多个前面的字符.
# ⑤[a-z0-9]* 匹配0个或多个英文字母或者数字；[-_]? 匹配0个或1“-”，因为“-”不能连续出现。
# ⑥[a-z0-9]+ 匹配1个或多个英文字母或者数字，因为“-”不能做为结尾
# ⑦@ 必需有个有@
# ⑧([a-z0-9]*[-_]?[a-z0-9]+)+ 见上面([a-z0-9]*[-_]?[a-z0-9]+)*解释，但是不能为空，+表示一个或者为多个。
# ⑨[\.] 将特殊字符(.)当成普通字符；[a-z]{2,3} 匹配2个至3个英文字母，一般为com或者net等。
# ⑩([\.][a-z]{2})? 匹配0个或者1个[\.][a-z]{2}(比如.cn等) 我不知道一般.com.cn最后部份是不是都是两位的,如果不是请修改{2}为{起始字数,结束字数} 


part="/^[a-z]([a-z0-9]*[-_]?[a-z0-9]+)*@([a-z0-9]*[-_]?[a-z0-9]+)+[\.][a-z]{2,3}([\.][a-z]{2})?$/i"
list=c("sunshine@163.com","data@li.com","safdaf@li.com")
grepl(part,list)

# sub 值返回第一个匹配的
# gsub 返回全局匹配值
list1=paste(list,collapse=",")

# grepl：返回一个逻辑值
# grep：返回匹配的id
# 正则替换：sub和gsub
grep("@",list)
grep("@",list1)

grepl("@",list)
grepl("@",list1)

sub("@","#",list)
sub("@","#",list1)
gsub("@","#",list)
gsub("@","#",list1)


# regexpr：返回一个数字，1表示匹配，-1表示不匹配，以及两个属性，匹配的长度和
# 是否使用useBytes
# regexec：返回一个list，字符串中第一个匹配及其长度以及是否使用useBytes
# gregexpr：返回一个list，每一个匹配及其长度以及是否使用useBytes

regexpr("@",list)

# [1] 9 5 7    第9位开始数1位，返回匹配结果，
# attr(,"match.length")
# [1] 1 1 1
# attr(,"useBytes")
# [1] TRUE


##########前半部分###
mychar="dataguru"
list=c("data","guru","rcurl")

chartr("u","r",mychar)
paste("data","guru")
paste(list,collapse='-')

substr(mychar,c(1,2),4)

substring(mychar,c(1,2),c(2,4))

list[1]<list[2]

union(mychar,list)
setdiff(mychar,list)
setdiff(list,mychar)

match("gur",list)
charmatch("gur",list)


#(sd)*   sd   sdsd  s sd  sdddd  sdfsdfg

(da)+
  da  dada  dadada 


pattern="^[A-Za-z0-9\\._%+-]+@[A-Za-z0-9\\.-]+\\.[A-Za-z]{2,4}$"
pattern2="\\w+@\\w+\\.[A-Za-z]{2,4}"
sunshine@163.com

list=c("sunshine@163.com","hujiko","data@jik.kon","kjhfdh@ji.jikol")
> list1
[1] "sunshine@163.com,hujiko,data@jik.kon,kjhfdh@ji.jikol"
grepl(pattern,list)
grep(pattern,list)

list1=paste(list,collapse=",")
gsub(pattern2,"data",list1)


regexec(pattern2,list1)


#####后半部分###
library(RCurl)


http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/603000.phtml?year=2013&jidu=4

temp=getURL("http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/603000.phtml?year=2013&jidu=4")

k=strsplit(temp,"\r\n")[[1]]

timeadr=k[grep("<a target='_blank'",k)+1]

time=substring(timeadr,4,13)

gsub

fpriceadr=k[grep("<a target='_blank'",k)+3]

fprice=gregexpr(">\\d+",fpriceadr)
i=3
for(i in 1:length(fpriceadr))
{
  tempp=fprice[[i]]
  fprices=substring(fpriceadr[i],tempp+1,tempp+attr(tempp,'match.length')+3)
}



pri=getURL("http://hq.sinajs.cn/list=sh603000",.encoding="GBK")


temp=getURL("http://qt.gtimg.cn/r=0.2984983995413796q=marketStat,stdunixtime,usDJI")

plot(fprices)
