setwd("D:/SMU/qtw/case4")
getwd()

els = readLines("WomenTxt/2012.txt")
els[1:10]

els2011 = readLines("WomenTxt/2011.txt")
els2011[1:10]

eqIndex = grep("^===", els)
eqIndex

spacerRow = els[eqIndex]
headerRow = els[eqIndex - 1]
body = els[ -(1:eqIndex) ]

headerRow = tolower(headerRow)

ageStart = regexpr("ag", headerRow)
ageStart

age = substr(body, start = ageStart, stop = ageStart + 1)
head(age)
summary(as.numeric(age))

blankLocs = gregexpr(" ", spacerRow)
blankLocs

searchLocs = c(0, blankLocs[[1]])
searchLocs

Values = mapply(substr, list(body),
                start = searchLocs[ -length(searchLocs)] + 1,
                stop = searchLocs[ -1 ] - 1)

findColLocs = function(spacerRow) {
  spaceLocs = gregexpr(" ", spacerRow)[[1]]
  rowLength = nchar(spacerRow)
  
  if (substring(spacerRow, rowLength, rowLength) != " ")
    return( c(0, spaceLocs, rowLength + 1))
  else return(c(0, spaceLocs))
}

selectCols =
  function(colNames, headerRow, searchLocs)
  {
    sapply(colNames,
           function(name, headerRow, searchLocs)
           {
             startPos = regexpr(name, headerRow)[[1]]
             if (startPos == -1)
               return( c(NA, NA) )
             
             index = sum(startPos >= searchLocs)
             c(searchLocs[index] + 1, searchLocs[index + 1] - 1)
           },
           headerRow = headerRow, searchLocs = searchLocs )
  }

searchLocs = findColLocs(spacerRow)
ageLoc = selectCols("ag", headerRow, searchLocs)
ages = mapply(substr, list(body),
              start = ageLoc[1,], stop = ageLoc[2, ])

shortColNames = c("name", "home", "ag", "gun", "net", "time")

locCols = selectCols(shortColNames, headerRow, searchLocs)

Values = mapply(substr, list(body), start = locCols[1, ],
                stop = locCols[2, ])

class(Values)

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
    
    # Obtain the starting and ending positions of variables
    searchLocs = findColLocs(spacerRow)
    locCols = selectCols(varNames, headerRow, searchLocs)
    
    Values = mapply(substr, list(body), start = locCols[1, ], 
                    stop = locCols[2, ])
    colnames(Values) = varNames
    
    invisible(Values)
  }

wfilenames = paste("WomenTxt/", 1999:2012, ".txt", sep = "")
womenFiles = lapply(wfilenames, readLines)
names(womenFiles) = 1999:2012

mfilenames = paste("MenTxt/", 1999:2012, ".txt", sep = "")
menFiles = lapply(mfilenames, readLines)
names(menFiles) = 1999:2012

menResMat = lapply(menFiles, extractVariables)
length(menResMat)

womenResMat = lapply(womenFiles, extractVariables)
length(womenResMat)

womenFiles[['2001']][1:15]

men2001 = readLines("MenTxt/2001.txt")
men2001[1:15]

womenFiles[['2001']][9:10] = men2001[12:13]
womenFiles[['2001']][1:15]

womenResMat = lapply(womenFiles, extractVariables)
length(womenResMat)

sapply(womenResMat, nrow)

womenFiles[['2000']][-(1:11)] = paste("", womenFiles[['2000']][-(1:11)])
womenFiles[['2000']][1:20]

selectCols = function(shortColNames, headerRow, searchLocs) {
  sapply(shortColNames, function(shortName, headerRow, searchLocs){
    startPos = regexpr(shortName, headerRow)[[1]]
    if (startPos == -1) return( c(NA, NA) )
    index = sum(startPos >= searchLocs)
    c(searchLocs[index] + 1, searchLocs[index + 1])
  }, headerRow = headerRow, searchLocs = searchLocs )
}

womenResMat = lapply(womenFiles, extractVariables)

age = sapply(womenResMat, 
             function(x) as.numeric(x[ , 'ag']))

boxplot(age, ylab = "Age", xlab = "Year")

sapply(age, function(x) sum(is.na(x)))

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

womenResMat = lapply(womenFiles, extractVariables)

age = sapply(womenResMat, 
             function(x) as.numeric(x[ , 'ag']))
sapply(age, function(x) sum(is.na(x)))

menResMat = lapply(menFiles, extractVariables)

age = sapply(menResMat, 
             function(x) as.numeric(x[ , 'ag']))
sapply(age, function(x) sum(is.na(x)))

charTime = womenResMat[['2012']][, 'time']
head(charTime, 5)
tail(charTime, 5)

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

cbWomen = do.call(rbind, womenDF)
save(cbWomen, file = "cbWomen.rda")
dim(cbWomen)
summary(cbWomen)

menDF = mapply(createDF, menResMat, year = 1999:2012,
                 sex = rep("m", 14), SIMPLIFY = FALSE)

cbmen = do.call(rbind, menDF)
save(cbmen, file = "cbmen.rda")
dim(cbmen)
summary(cbmen)