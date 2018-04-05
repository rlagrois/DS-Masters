library(XML)
setwd("D:/SMU/qtw/case4")
getwd()

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
    doc = htmlParse(url, encoding="UTF-8")
    
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
      #els = sapply(pres, xmlValue)
      txt = sapply(pres, xmlValue)
      els = gsub("\\t", "", txt)
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

findColLocs = function(spacerRow) {
  spaceLocs = gregexpr(" ", spacerRow)[[1]]
  rowLength = nchar(spacerRow)
  
  if (substring(spacerRow, rowLength, rowLength) != " ")
    return( c(0, spaceLocs, rowLength + 1))
  else return(c(0, spaceLocs))
}

selectCols = function(shortColNames, headerRow, searchLocs) {
  sapply(shortColNames, function(shortName, headerRow, searchLocs){
    startPos = regexpr(shortName, headerRow)[[1]]
    if (startPos == -1) return( c(NA, NA) )
    index = sum(startPos >= searchLocs)
    c(searchLocs[index] + 1, searchLocs[index + 1])
  }, headerRow = headerRow, searchLocs = searchLocs )
}


extractVariables = 
  function(file, varNames =c("name", "home", "ag", "gun",
                             "net", "time"))
  {
    
    # Find the index of the row with =s
    eqIndex = grep("^===", file)
    # Extract the two key rows and the data 
    spacerRow = file[eqIndex] 
    headerRow = tolower(file[ eqIndex - 1 ])
    body = file[ -(1 : eqIndex) ]
    # Remove footnotes and blank rows
    footnotes = grep("^[[:blank:]]*(\\*|\\#)", body)
    if ( length(footnotes) > 0 ) body = body[ -footnotes ]
    blanks = grep("^[[:blank:]]*$", body)
    if (length(blanks) > 0 ) body = body[ -blanks ]
    
    
    # Obtain the starting and ending positions of variables   
    searchLocs = findColLocs(spacerRow)
    locCols = selectCols(varNames, headerRow, searchLocs)
    
    Values = mapply(substr, list(body), start = locCols[1, ], 
                    stop = locCols[2, ])
    colnames(Values) = varNames
    
    return(Values)
  }

wfilenames = paste("WomenTxt/", 1999:2012, ".txt", sep = "")
womenFiles = lapply(wfilenames, readLines)
names(womenFiles) = 1999:2012


mfilenames = paste("MenTxt/", 1999:2012, ".txt", sep = "")
menFiles = lapply(mfilenames, readLines)
names(menFiles) = 1999:2012

menResMat = lapply(menFiles, extractVariables)
length(menResMat)

# Fixes file without header
men2001 = readLines("MenTxt/2001.txt")
men2001[1:15]
womenFiles[['2001']][2:3] = men2001[4:5]
womenFiles[['2001']][1:15]

womenResMat = lapply(womenFiles, extractVariables)
length(womenResMat)

# women plot
age = sapply(womenResMat, 
             function(x) as.numeric(x[ , 'ag']))

boxplot(age, ylab = "Age", xlab = "Year")

sapply(age, function(x) sum(is.na(x)))

#age is 0 in 2001
sapply(age, function(x) which(x < 5))

# Men plot
age = sapply(menResMat, 
             function(x) as.numeric(x[ , 'ag']))

boxplot(age, ylab = "Age", xlab = "Year")
sapply(age, function(x) sum(is.na(x)))
#age is under 5
sapply(age, function(x) which(x < 5))

convertTime = function(time) {
  timePieces = strsplit(time, ":")
  timePieces = sapply(timePieces, as.numeric)
  sapply(timePieces, function(x) {
    if (length(x) == 2) x[1] + x[2]/60
    else 60*x[1] + x[2] + x[3]/60
  })
}

createDF = function(Res, year, sex) 
{
  # Determine which time to use
  if ( !is.na(Res[1, 'net']) ) useTime = Res[ , 'net']
  else if ( !is.na(Res[1, 'gun']) ) useTime = Res[ , 'gun']
  else useTime = Res[ , 'time']
  
  # Remove # and * and blanks from time
  useTime = gsub("[#\\*[:blank:]]", "", useTime)
  runTime = convertTime(useTime[ useTime != "" ])
  
  # Drop rows with no time
  Res = Res[ useTime != "", ]
  
  Results = data.frame(year = rep(year, nrow(Res)),
                       sex = rep(sex, nrow(Res)),
                       name = Res[ , 'name'], home = Res[ , 'home'],
                       age = as.numeric(Res[, 'ag']), 
                       runTime = runTime,
                       stringsAsFactors = FALSE)
  invisible(Results)
}

womenDF = mapply(createDF, womenResMat, year = 1999:2012,
                 sex = rep("W", 14), SIMPLIFY = FALSE)

sapply(womenDF, function(x) sum(is.na(x$runTime)))

cbWomen = do.call(rbind, womenDF)
save(cbWomen, file = "cbWomen.rda")
dim(cbWomen)
summary(cbWomen)

menDF = mapply(createDF, menResMat, year = 1999:2012,
               sex = rep("m", 14), SIMPLIFY = FALSE)

sapply(menDF, function(x) sum(is.na(x$runTime)))

cbmen = do.call(rbind, menDF)
save(cbmen, file = "cbmen.rda")
dim(cbmen)
summary(cbmen)


separatorIdx = grep("^===", menFiles[["2006"]])
separatorRow = menFiles[['2006']][separatorIdx]
separatorRowX = paste(substring(separatorRow, 1, 63), " ", 
                      substring(separatorRow, 65, nchar(separatorRow)), 
                      sep = "")
menFiles[['2006']][separatorIdx] = separatorRowX

menResMat = sapply(menFiles, extractVariables)
menDF = mapply(createDF, menResMat, year = 1999:2012,
               sex = rep("M", 14), SIMPLIFY = FALSE)

separatorIdx = grep("^===", womenFiles[["2006"]])
separatorRow = womenFiles[['2006']][separatorIdx]
separatorRowX = paste(substring(separatorRow, 1, 63), " ",
                      substring(separatorRow, 65, nchar(separatorRow)),
                      sep = "")
womenFiles[['2006']][separatorIdx] = separatorRowX

womenResMat = sapply(womenFiles, extractVariables)
womenDF = mapply(createDF, womenResMat, year = 1999:2012,
               sex = rep("W", 14), SIMPLIFY = FALSE)

cbmen = do.call(rbind, menDF)
save(cbmen, file = "cbmen.rda")
dim(cbmen)
summary(cbmen)

cbWomen = do.call(rbind, womenDF)
save(cbWomen, file = "cbWomen.rda")
dim(cbWomen)
summary(cbWomen)