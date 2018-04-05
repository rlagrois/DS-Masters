setwd("D:/SMU/qtw/case4")

library(XML)

ubase = "http://www.cherryblossom.org/"
url = paste(ubase, "results/1999/cb99m.html", sep = "")


URLSuffixM = 
  c("results/1999/cb99m.html", "results/2000/Cb003m.htm", "results/2001/oof_m.html",
    "results/2002/oofm.htm", "results/2003/CB03-M.HTM",
    "results/2004/men.htm", "results/2005/CB05-M.htm", 
    "results/2006/men.htm", "results/2007/men.htm", 
    "results/2008/men.htm", "results/2009/09cucb-M.htm",
    "results/2010/2010cucb10m-m.htm", 
    "results/2011/2011cucb10m-m.htm",
    "results/2012/2012cucb10m-m.htm")

MenURLs = paste(ubase, URLSuffixM, sep = "")

URLSuffixF = 
  c("results/1999/cb99m.html", "results/2000/Cb003f.htm", "results/2001/oof_f.html",
    "results/2002/ooff.htm", "results/2003/CB03-F.HTM",
    "results/2004/women.htm", "results/2005/CB05-F.htm", 
    "results/2006/women.htm", "results/2007/women.htm", 
    "results/2008/women.htm", "results/2009/09cucb-F.htm",
    "results/2010/2010cucb10m-f.htm", 
    "results/2011/2011cucb10m-f.htm",
    "results/2012/2012cucb10m-f.htm")

FemaleURLs = paste(ubase, URLSuffixF, sep = "")

extractResTable =
  #
  # Retrieve data from web site, 
  # find the preformatted text,
  # and write lines or return as a character vector.
  #
  function(url = "http://www.cherryblossom.org/results/1999/cb99m.html",
           year = 1999, sex = "male", file = file)
  {
    doc = htmlParse(url)
    
    if (year == 2000) {
      # Get preformatted text from 4th font element
      # The top file is ill formed so the <pre> search doesn't work.
      ff = getNodeSet(doc, "//font")
      txt = xmlValue(ff[[4]])
      els = strsplit(txt, "\r\n")[[1]]
    }
    else if (year == 2009 & sex == "male") {
      # Get preformatted text from <div class="Section1"> element
      # Each line of results is in a <pre> element
      div1 = getNodeSet(doc, "//div[@class='Section1']")
      pres = getNodeSet(div1[[1]], "//pre")
      els = sapply(pres, xmlValue)
    }
    else if (year == 1999) {
      # Get preformatted text from <pre> elements
      pres = getNodeSet(doc, "//pre")
      txt = xmlValue(pres[[1]])
      els = strsplit(txt, "\n")[[1]] 
    }
    else {
      # Get preformatted text from <pre> elements
      pres = getNodeSet(doc, "//pre")
      txt = xmlValue(pres[[1]])
      els = strsplit(txt, "\r\n")[[1]]   
    } 
    
    if (is.null(file)) return(els)
    # Write the lines as a text file.
    else 
    writeLines(els, con = file)
    return(els)
  }


years = 1999:2012

#You must have a MenTxt folder in your working directory!!
menTables = mapply(extractResTable, url = MenURLs, year = years, file=paste(getwd(),"/MenTxt/", years, ".txt", sep = ""))
names(menTables) = years
sapply(menTables, length)

#You must have a WomenTxt folder in your working directory!!
womenTables = mapply(extractResTable, url = FemaleURLs, year = years, sex = rep("female", 14), file=paste(getwd(),"/WomenTxt/", years, ".txt", sep = ""))
names(womenTables) = years
sapply(womenTables, length)
