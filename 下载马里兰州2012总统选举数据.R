library(rvest)
library(stringr)
library(plyr)
### 场景: 下载一组CSV文件
# 下载马里兰州2012总统选举数据
# 数据源http://www.elections.state.md.us/elections/2012/election_data/index.html
# 数据信息http://www.elections.state.md.us/elections/using_election_data_instructions.html

# 设置路径
setwd("d:/data")

# 准备文件名
u = "http://www.elections.state.md.us/elections/2012/election_data/index.html"
links = u %>% html() %>% html_nodes("a") %>% html_attrs() %>% pluck(1, character(1))
filenames = links[str_detect(links, "General")]

# 下载函数
downloadCSV = function(filename, baseurl, folder) {
  dir.create(folder, showWarnings = FALSE)
  fileurl = str_c(baseurl, filename)
  if (!file.exists(str_c(folder, "/", filename))) {
    download.file(fileurl,destfile = str_c(folder, "/", filename))
    Sys.sleep(1)
  }
}

# 执行下载
l_ply(filenames, downloadCSV,
      baseurl = "http://www.elections.state.md.us/elections/2012/election_data/",
      folder = "elec12_maryland")

