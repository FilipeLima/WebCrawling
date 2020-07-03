install.packages("Rcrawler")

DATA <- ContentScraper(Url="http://www.uol.com.br",XpathPatterns=c("//head/title","//*/article"),PatternsName=c("title", "article"))

DATA<-ContentScraper(Url="https://lol.gamepedia.com/League_of_Legends_Esports_Wiki",
                     CssPatterns = c(".frontpage-content",".titletabs-tab"), astext = TRUE)

DATA<-ContentScraper(Url="https://en.wikipedia.org/wiki/1994_FIFA_World_Cup",XpathPatterns=c("//head/title","//*/article","//body")
                      ,astext = TRUE)

bodyDATA <- DATA[[3]]
bodyDATA <- gsub("\n","",bodyDATA)
bodyDATA <- gsub("\n","",bodyDATA)
bodyDATA <- gsub("^", "", bodyDATA)
bodyDATA <- strsplit(bodyDATA,' ')


