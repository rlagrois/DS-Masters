txt = readLines ("D:/SMU/qtw/case3/offline.final.trace.txt")
#Check data
sum(substr(txt, 1, 1) == "#")
length(txt)
# Number of lines with # is 5,312
# Number of lines total is 151,392
# 151,392 - 5,312 = 146,080 (lines expected); file is validated

# Check data format by splitting on semicolon for first line
strsplit(txt[4], ";")[[1]]

# Further split data by running function to split at = then ,
unlist(lapply(strsplit(txt[4], ";")[[1]], 
              function(x) 
                sapply(strsplit(x, "=")[[1]], strsplit,",")))


# Simplify above code by splitting at any ';', '=', or ','
tokens = strsplit(txt[4], "[;=,]")[[1]]

# Data elements
tokens[1:10]
# Extracted data elements
tokens[c(2, 4, 6:8, 10)]
# Signal Elements
tokens[-(1:10)]

# Create a matrix of signal elements
tmp = matrix(tokens[ - (1:10)], ncol = 4, byrow = TRUE)

tmp

# Create matrix of data elements and bind signal elments matrix to it
mat = cbind(matrix(tokens[c(2, 4, 6:8, 10)], nrow = nrow(tmp), 
                   ncol = 6, byrow = TRUE), 
            tmp)
dim(mat)

mat


# Create a function with prior code to run for each row in offline data file
processLine = function(x) 
{
  tokens = strsplit(x, "[;=,]")[[1]]
  if (length(tokens) == 10)
    return(NULL) 
  
  tmp = matrix(tokens[ - (1:10)],, 4, byrow = TRUE)
  cbind(matrix(tokens[c(2, 4, 6:8, 10)], nrow(tmp), 6,
               byrow = TRUE), tmp)
}

# Run function for first 17 observations of offline data file
tmp = lapply(txt[4:20], processLine)

# Check number of rows (signals) detected for each entry
sapply(tmp, nrow)

# Use do.call to apply rbind to all values in temp
offline = as.data.frame(do.call("rbind", tmp))

dim(offline)

# Remove lines starting with #
lines = txt[ substr(txt, 1, 1) != "#"]

#Apply function to entire offline data set
tmp = lapply(lines, processLine)

# Set options to handle errors and change warnings into errors
#options(error = recover, warn = 2)

tmp = lapply(lines, processLine)

# Update function to delete the 6 observations with missing data

# Reset options to default
options(error = recover, warn = 1) 

tmp = lapply(lines, processLine)

# Create 'offline' data frame to combine all processed matrices from processLine function
offline = as.data.frame(do.call("rbind", tmp), 
                        stringsAsFactors = FALSE)

dim(offline)

# Create names for offline data frame variables
names(offline) = c("time", "scanMac", "posX", "posY", "posZ", "orientation", "mac", "signal", "channel", "type")

# Define a vector containing numeric variables
numVars = c("time", "posX", "posY", "posZ", "orientation", "signal") 

# Change variable types to numeric for those defined in numvars vector
offline[ numVars] = lapply(offline[ numVars], as.numeric)

# Drop all type 1 'type' entries, which are 'Ad Hoc', as we are only analyzing access points
offline = offline[ offline$type == "3",] 

# Remove the now unnecessary 'type' column
offline = offline[, "type" != names(offline)] 

dim(offline)

# Time is in milliseconds, create a copy as raw time
offline$rawTime = offline$time 

# Convert time from miliseconds to seconds
offline$time = offline$time/1000 

# Change format time variable to YY-MM-DD HH:MM:SS
class(offline$time) = c("POSIXt", "POSIXct")

# Check variable types
unlist(lapply(offline, class))

# Verify numeric data
summary(offline[, numVars])

# Convert character variables to factors and verify
summary(sapply(offline[, c("mac", "channel", "scanMac")], 
               as.factor))

# Drop scanMac and posZ variables. There is no change in height and the reading device is always the same.
offline = offline[, !(names(offline) %in% c("scanMac", "posZ"))]

# Check the number of unique orientations, which should be 8
length(unique(offline$orientation))

# Plot orientations
plot(ecdf(offline$orientation))

# Create function to return measurements to the proper 45 degree values
roundOrientation = function(angles) {
  refs = seq(0, by = 45, length = 9)
  q = sapply(angles, function(o) which.min(abs(o - refs)))
  c(refs[1:8], 0)[q] 
}

# Run the function and output to a new 'angle' variable
offline$angle = roundOrientation(offline$orientation)

# Create boxplot of new angles
with(offline, boxplot(orientation ~ angle,
                      xlab = "nearest 45 degree angle", 
                      ylab="orientation"))

# Check number of mac addresses vs channels (should be the same)
c(length(unique(offline$mac)), length(unique(offline$channel)))

# View mac addresses and number of observations at each
table(offline$mac)

# Keep top 7 mac addresses, dropping the rest
subMacs = names(sort(table(offline$mac), decreasing = TRUE))[1:7]
offline = offline[ offline$mac %in% subMacs,]

# Check number of mac addresses vs channels (should be the same)
c(length(unique(offline$mac)), length(unique(offline$channel)))

# Check that each unique mac address has a unique channel
macChannel = with(offline, table(mac, channel)) 
apply(macChannel, 1, function(x) sum(x > 0))

# Remove channel from offline data set
offline = offline[, "channel" != names(offline)]

# Create a list of data frames, where each data frame is a unique x,y combination
locDF = with(offline, by(offline, list(posX, posY), function(x) x)) 
length(locDF)

# Check number of null values
sum(sapply(locDF, is.null))

# Drop all null values, keeping only x,y pairs (locations) which were observed
locDF = locDF[ !sapply(locDF, is.null)]
length(locDF)

# Determine number of observations at each location by creating a matrix
locCounts = sapply(locDF, function(df) c(df[1, c("posX", "posY")], count = nrow(df)))

class(locCounts)
dim(locCounts)
locCounts[, 1:8]

# Create a plot of locations, where each point is labeled by the number of observations at that point
locCounts = t(locCounts)
plot(locCounts, type = "n", xlab ="", ylab ="")
text(locCounts, labels = locCounts[,3], cex = .8, srt = 45)


readData = 
  function(filename = "D:/SMU/qtw/case3/offline.final.trace.txt", 
           subMacs = c("00:0f:a3:39:e1:c0", "00:0f:a3:39:dd:cd", "00:14:bf:b1:97:8a",
                       "00:14:bf:3b:c7:c6", "00:14:bf:b1:97:90", "00:14:bf:b1:97:8d",
                       "00:14:bf:b1:97:81"))
  {
    txt = readLines(filename)
    lines = txt[ substr(txt, 1, 1) != "#" ]
    tmp = lapply(lines, processLine)
    offline = as.data.frame(do.call("rbind", tmp), 
                            stringsAsFactors= FALSE) 
    
    names(offline) = c("time", "scanMac", 
                       "posX", "posY", "posZ", "orientation", 
                       "mac", "signal", "channel", "type")
    
    # keep only signals from access points
    offline = offline[ offline$type == "3", ]
    
    # drop scanMac, posZ, channel, and type - no info in them
    dropVars = c("scanMac", "posZ", "channel", "type")
    offline = offline[ , !( names(offline) %in% dropVars ) ]
    
    # drop more unwanted access points
    offline = offline[ offline$mac %in% subMacs, ]
    
    # convert numeric values
    numVars = c("time", "posX", "posY", "orientation", "signal")
    offline[ numVars ] = lapply(offline[ numVars ], as.numeric)
    
    # convert time to POSIX
    offline$rawTime = offline$time
    offline$time = offline$time/1000
    class(offline$time) = c("POSIXt", "POSIXct")
    
    # round orientations to nearest 45
    offline$angle = roundOrientation(offline$orientation)
    
    return(offline)
  }

offlineRedo = readData()

identical(offline, offlineRedo)


#######
######
# End Cleaning and Exploration
######
#######


## Analyzing Signal Strength

# Check for package, if not downloaded, download;if not installed, install
if(!require(lattice)){
  install.packages("lattice")
  library(lattice)
}

# Create boxplots of signal strengths per orientation at each mac address (excluding one)
bwplot(signal ~ factor(angle) | mac, data = offline,
       subset = posX == 2 & posY == 12
                & mac != "00:0f:a3:39:dd:cd", 
       layout = c(2,3))

# Summary statistics of the signal variable
summary(offline$signal)

# Create a density plot at location 23,4 of signal strength vs angle (each angle for each mac address should have about 110 observations)
densityplot( ~ signal | mac + factor(angle), data = offline,
             subset = posX == 24 & posY == 4 &
                         mac != "00:0f:a3:39:dd:cd", 
             bw = 0.5, plot.points = FALSE)

# Create variable for location
offline$posXY = paste(offline$posX, offline$posY, sep = "-")

# Create a list of data frames for every combination ofr location (x,y), angle, and mac address
byLocAngleAP = with(offline,
                    by(offline, list(posXY, angle, mac), 
                       function(x) x))

# Calculate summary statistics on each data frame
signalSummary = 
  lapply(byLocAngleAP,
         function(oneLoc) { 
           ans = oneLoc[1,]
           ans$medSignal = median(oneLoc$signal)
           ans$avgSignal = mean(oneLoc$signal)
           ans$num = length(oneLoc$signal) 
           ans$sdSignal = sd(oneLoc$signal)
           ans$iqrSignal = IQR(oneLoc$signal)
           ans 
           }) 

# Convert list of dataframes into a singular data frame
offlineSummary = do.call("rbind", signalSummary)

# Create boxplot charts of average standard deviations
breaks = seq(-90, -30, by = 5) 
bwplot(sdSignal ~ cut(avgSignal, breaks = breaks),
       data = offlineSummary,
       subset = mac != "00:0f:a3:39:dd:cd", 
       xlab = "Mean Signal", ylab = "SD Signal")

# Plot the difference between mean and median to view the skewness of data
with(offlineSummary,
     smoothScatter((avgSignal - medSignal) ~ num,
                   xlab = "Number of Observations",
                   ylab = "mean - median")) 
abline(h = 0, col = "#984ea3", lwd = 2)

# Smooth the difference between mean and median and make an object based on the local polynomial regression fitting
lo.obj = 
  with(offlineSummary, 
       loess(diff ~ num, data = data.frame(diff = (avgSignal - medSignal),
                                           num = num)))

# Use the object to overlay smoothed values (???)
lo.obj.pr = predict(lo.obj, newdata = data.frame(num = (70:120))) 
lines(x = 70:120, y = lo.obj.pr, col = "#4daf4a", lwd = 2)


## Analyzing Signal and Distance with fixed mac and angle

# Select one mac address and angle
oneAPAngle = subset(offline, mac == subMacs[5] & angle == 0)

# Select one mac address and angle from summary data 
oneAPAngle = subset(offlineSummary, mac == subMacs[5] & angle == 0)

if(!require(fields)){
  install.packages("fields")
  library(fields)
}

# Fit smooth surface to mean signal strength
smoothSS = Tps(oneAPAngle[, c("posX","posY")], oneAPAngle$avgSignal)

# Predict values for fitted smooth surface at grids ("posX","posY") from prior line
vizSmooth = predictSurface(smoothSS)

# Plot predicted signal strength values
plot.surface(vizSmooth, type = "C")

# Add measurement locations
points(oneAPAngle$posX, oneAPAngle$posY, pch=19, cex = 0.5)

# Create SurfaceSS function which does everything above
surfaceSS = function(data, mac, angle = 45) {
  require(fields)
  oneAPAngle = data[ data$mac == mac & data$angle == angle, ]
  smoothSS = Tps(oneAPAngle[, c("posX","posY")], 
                 oneAPAngle$avgSignal)
  vizSmooth = predictSurface(smoothSS)
  plot.surface(vizSmooth, type = "C", 
               xlab = "", ylab = "", xaxt = "n", yaxt = "n")
  points(oneAPAngle$posX, oneAPAngle$posY, pch=19, cex = 0.5) 
}

# Edit plot parameters to show 2 x 2 and shrink size of margins to allow bigger plots
parCur = par(mfrow = c(2,2), mar = rep(1, 4))

# Plot multiple plots, where the top two are the first entry and the left 2 are the first entry
mapply(surfaceSS, mac = subMacs[ rep(c(2, 1), each = 2)],
       angle = rep(c(0, 180), 2), 
       data = list(data = offlineSummary))

# Reset plotting parameters
par(parCur)

# IMPORTANT macs 1 and 2 are at the same spot.
# Subset the summary data frame to exclude the second mac address.

# Create a matrix to contain location of each access point, as estimated by heatmap locations
AP = matrix( c( 7.5, 6.3, 2.5, -.8, 12.8, -2.8, 1, 14, 33.5, 9.3, 33.5, 2.8),
             ncol = 2, byrow = TRUE, 
             dimnames = list(subMacs[ -2], c("x", "y")))
AP

# Find the difference between reader locations and access points
diffs = offlineSummary[, c("posX", "posY")] - AP[ offlineSummary$mac,]

# Output euclidean distance to dist variable
offlineSummary$dist = sqrt(diffs[, 1]^2 + diffs[, 2]^2)

# Plot signal strength vs distance to all access points
xyplot(signal ~ dist | factor(mac) + factor(angle), 
       data = offlineSummary, pch = 19, 
       cex = 0.3, xlab ="distance")

#######
######
# Using KNN
######
#######

###
### Creating a training data set
###


# Read online data
macs = unique(offlineSummary$mac)
online = readData("D:/SMU/qtw/case3/online.final.trace.txt", subMacs = macs)

# Create loation variable for online data using x,y and check number of unique locaitons
online$posXY = paste(online$posX, online$posY, sep = "-")
length(unique(online$posXY))

# Check number of signals at each location
tabonlineXYA = table(online$posXY, online$angle)
tabonlineXYA[1:6, ]

# Create onlineSummary data, turning each mac address into a variable with signal strength to the access point as the value
keepVars = c("posXY", "posX","posY", "orientation", "angle")
byLoc = with(online, 
             by(online, list(posXY), 
                function(x) {
                  ans = x[1, keepVars]
                  avgSS = tapply(x$signal, x$mac, mean)
                  y = matrix(avgSS, nrow = 1, ncol = 6,
                             dimnames = list(ans$posXY, names(avgSS)))
                  cbind(ans, y)
                }))

onlineSummary = do.call("rbind", byLoc) 

dim(onlineSummary)

names(onlineSummary)

# Prime new variables, where m = number of orientations and angleNewObs is the angle
m = 3; angleNewObs = 230

# Create a reference list of valid angles
refs = seq(0, by = 45, length  = 8)
# Round anglenewObs to nearest 45 degree angle
nearestAngle = roundOrientation(angleNewObs)


# Create code for training KNN by selecting number of nearest orientations based on K
if (m %% 2 == 1) {
  angles = seq(-45 * (m - 1) /2, 45 * (m - 1) /2, length = m)
} else {
  m = m + 1
  angles = seq(-45 * (m - 1) /2, 45 * (m - 1) /2, length = m)
  if (sign(angleNewObs - nearestAngle) > -1) 
    angles = angles[ -1 ]
  else 
    angles = angles[ -m ]
}
# Adjust negative angles
angles = angles + nearestAngle
angles[angles < 0] = angles[ angles < 0 ] + 360
angles[angles > 360] = angles[ angles > 360 ] - 360

# Subset offline data set that only contain data for the three orientations of the nearest angle to anglenewobs
offlineSubset = 
  offlineSummary[ offlineSummary$angle %in% angles, ]

# Create function to reshape data in a similar fashion to onlineSummary, in which the 6 access points' signal strengths are variables
reshapeSS = function(data, varSignal = "signal", 
                     keepVars = c("posXY", "posX","posY")) {
  byLocation =
    with(data, by(data, list(posXY), 
                  function(x) {
                    ans = x[1, keepVars]
                    avgSS = tapply(x[ , varSignal ], x$mac, mean)
                    y = matrix(avgSS, nrow = 1, ncol = 6,
                               dimnames = list(ans$posXY,
                                               names(avgSS)))
                    cbind(ans, y)
                  }))
  
  newDataSS = do.call("rbind", byLocation)
  return(newDataSS)
}

# Call the reshapeSS function and use avgsignal
trainSS = reshapeSS(offlineSubset, varSignal = "avgSignal")


# Create a function which combines all prior KNN code
selectTrain = function(angleNewObs, signals = NULL, m = 1){
  # m is the number of angles to keep between 1 and 5
  refs = seq(0, by = 45, length  = 8)
  nearestAngle = roundOrientation(angleNewObs)
  
  if (m %% 2 == 1) 
    angles = seq(-45 * (m - 1) /2, 45 * (m - 1) /2, length = m)
  else {
    m = m + 1
    angles = seq(-45 * (m - 1) /2, 45 * (m - 1) /2, length = m)
    if (sign(angleNewObs - nearestAngle) > -1) 
      angles = angles[ -1 ]
    else 
      angles = angles[ -m ]
  }
  angles = angles + nearestAngle
  angles[angles < 0] = angles[ angles < 0 ] + 360
  angles[angles > 360] = angles[ angles > 360 ] - 360
  angles = sort(angles) 
  
  offlineSubset = signals[ signals$angle %in% angles, ]
  reshapeSS(offlineSubset, varSignal = "avgSignal")
}

train130 = selectTrain(130, offlineSummary, m = 3)

head(train130)

length(train130[[1]])


###
### Using Training Data Set for Prediction with KNN
###

# Create a function which finds the distance from a new point to all observations in the training data set
# "The parameters to this function are a numeric vector of 6 new signal strengths and the return value from selectTrain()."

findNN = function(newSignal, trainSubset) {
  diffs = apply(trainSubset[ , 4:9], 1, 
                function(x) x - newSignal)
  dists = apply(diffs, 2, function(x) sqrt(sum(x^2)) )
  closest = order(dists)
  return(trainSubset[closest, 1:3 ])
}

# Create a function called predxy which estimates the location of new signals, taking as input new signals, the angles at which thise signals are taken,
#the train data, the number of angles around the initial, and the number of nearest neighbors
predXY = function(newSignals, newAngles, trainData, 
                  numAngles = 1, k = 3){
  
  closeXY = list(length = nrow(newSignals))
  
  for (i in 1:nrow(newSignals)) {
    trainSS = selectTrain(newAngles[i], trainData, m = numAngles)
    closeXY[[i]] = 
      findNN(newSignal = as.numeric(newSignals[i, ]), trainSS)
  }
  
  estXY = lapply(closeXY, 
                 function(x) sapply(x[ , 2:3], 
                                    function(x) mean(x[1:k])))
  estXY = do.call("rbind", estXY)
  return(estXY)
}

# Use predxy to estimate the online summary data
estXYk3 = predXY(newSignals = onlineSummary[, 6:11], 
                 newAngles = onlineSummary[, 4], 
                 offlineSummary, numAngles = 3, k = 3)

# Again, with one nearest neighbor
estXYk1 = predXY(newSignals = onlineSummary[ , 6:11], 
                 newAngles = onlineSummary[ , 4], 
                 offlineSummary, numAngles = 3, k = 1)

# Create a floor error map function
floorErrorMap = function(estXY, actualXY, trainPoints = NULL, AP = NULL){
  
  plot(0, 0, xlim = c(0, 35), ylim = c(-3, 15), type = "n",
       xlab = "", ylab = "", axes = FALSE)
  box()
  if ( !is.null(AP) ) points(AP, pch = 15)
  if ( !is.null(trainPoints) )
    points(trainPoints, pch = 19, col="grey", cex = 0.6)
  
  points(x = actualXY[, 1], y = actualXY[, 2], 
         pch = 19, cex = 0.8 )
  points(x = estXY[, 1], y = estXY[, 2], 
         pch = 8, cex = 0.8 )
  segments(x0 = estXY[, 1], y0 = estXY[, 2],
           x1 = actualXY[, 1], y1 = actualXY[ , 2],
           lwd = 2, col = "red")
}

# Create data frame of all training points on the floor
trainPoints = offlineSummary[ offlineSummary$angle == 0 & 
                                offlineSummary$mac == "00:0f:a3:39:e1:c0" ,
                              c("posX", "posY")]

# Call floorErrorMap function and output as a pdf file to designated location
# Stars are the estimated locations, black dots are the actual signal locations
# Red lines are the distance between the actual and estimated points
pdf(file="D:/SMU/qtw/case3/GEO_FloorPlanK3Errors.pdf", width = 10, height = 7)
oldPar = par(mar = c(1, 1, 1, 1))
floorErrorMap(estXYk3, onlineSummary[ , c("posX","posY")], 
              trainPoints = trainPoints, AP = AP)
par(oldPar)
dev.off()

pdf(file="D:/SMU/qtw/case3/GEO_FloorPlanK1Errors.pdf", width = 10, height = 7)
oldPar = par(mar = c(1, 1, 1, 1))
floorErrorMap(estXYk1, onlineSummary[ , c("posX","posY")], 
              trainPoints = trainPoints, AP = AP)
par(oldPar)
dev.off()

# Create a function which calculates the error of the KNN based on the cumulative distance between estimated and actual points (red lines)
calcError = 
  function(estXY, actualXY) 
    sum( rowSums( (estXY - actualXY)^2) )

# Use the calcError function and return the sum of square errors for both the K1 and K3 runs
actualXY = onlineSummary[ , c("posX", "posY")]
sapply(list(estXYk1, estXYk3), calcError, actualXY)

###
### Cross validating with K(V)-Fold CV
###

# Create a fold for cross validation (CV)
onlineFold = subset(offlineSummary, posXY %in% permuteLocs[ , 1])

# Modify reshapeSS function to only return one angle (orientation)
reshapeSS = function(data, varSignal = "signal", 
                     keepVars = c("posXY", "posX","posY"),
                     sampleAngle = FALSE, 
                     refs = seq(0, 315, by = 45)) {
  byLocation =
    with(data, by(data, list(posXY), 
                  function(x) {
                    if (sampleAngle) {
                      x = x[x$angle == sample(refs, size = 1), ]}
                    ans = x[1, keepVars]
                    avgSS = tapply(x[ , varSignal ], x$mac, mean)
                    y = matrix(avgSS, nrow = 1, ncol = 6,
                               dimnames = list(ans$posXY,
                                               names(avgSS)))
                    cbind(ans, y)
                  }))
  
  newDataSS = do.call("rbind", byLocation)
  return(newDataSS)
}

# Omit the 7th mac address from the data set
offline = offline[ offline$mac != "00:0f:a3:39:dd:cd", ]

# Define a list of variables to keep
keepVars = c("posXY", "posX","posY", "orientation", "angle")

# Create a data frame by running the new reshapeSS function
onlineCVSummary = reshapeSS(offline, keepVars = keepVars, 
                            sampleAngle = TRUE)

# Create the first fold with the newly formatted data
onlineFold = subset(onlineCVSummary, 
                    posXY %in% permuteLocs[ , 1])

# Select training data for the new fold
offlineFold = subset(offlineSummary,
                     posXY %in% permuteLocs[ , -1])

# Use the predxy function to run 3-KNN with different training and test data
estFold = predXY(newSignals = onlineFold[ , 6:11], 
                 newAngles = onlineFold[ , 4], 
                 offlineFold, numAngles = 3, k = 3)

# Calculate the sum of squares error for this first fold
actualFold = onlineFold[ , c("posX", "posY")]
calcError(estFold, actualFold)

# Establish variables for upcoming for loop
K = 20
err = rep(0, K)

# Create a for loop in which the CV is run
for (j in 1:v) {
  onlineFold = subset(onlineCVSummary, 
                      posXY %in% permuteLocs[ , j])
  offlineFold = subset(offlineSummary,
                       posXY %in% permuteLocs[ , -j])
  actualFold = onlineFold[ , c("posX", "posY")]
  
  for (k in 1:K) {
    estFold = predXY(newSignals = onlineFold[ , 6:11],
                     newAngles = onlineFold[ , 4], 
                     offlineFold, numAngles = 3, k = k)
    err[k] = err[k] + calcError(estFold, actualFold)
  }
}

# Create a plot of SSE vs # of Neighbors
pdf(file = "D:/SMU/qtw/case3/Geo_CVChoiceOfK.pdf", width = 10, height = 6)
oldPar = par(mar = c(4, 3, 1, 1))
plot(y = err, x = (1:K),  type = "l", lwd= 2,
     ylim = c(1200, 2100),
     xlab = "Number of Neighbors",
     ylab = "Sum of Square Errors")

rmseMin = min(err)
kMin = which(err == rmseMin)[1]
segments(x0 = 0, x1 = kMin, y0 = rmseMin, col = gray(0.4), 
         lty = 2, lwd = 2)
segments(x0 = kMin, x1 = kMin, y0 = 1100,  y1 = rmseMin, 
         col = grey(0.4), lty = 2, lwd = 2)

#mtext(kMin, side = 1, line = 1, at = kMin, col = grey(0.4))
text(x = kMin - 2, y = rmseMin + 40, 
     label = as.character(round(rmseMin)), col = grey(0.4))
par(oldPar)
dev.off()

# Run the KNN estimation with 9 neighbors, as it has the least SSE based on the prior plot
estXYk9 = predXY(newSignals = onlineSummary[ , 6:11], 
                 newAngles = onlineSummary[ , 4], 
                 offlineSummary, numAngles = 3, k = 9)

calcError(estXYk9, actualXY)

# Plot
pdf(file="D:/SMU/qtw/case3/GEO_FloorPlanK9Errors.pdf", width = 10, height = 7)
oldPar = par(mar = c(1, 1, 1, 1))
floorErrorMap(estXYk9, onlineSummary[ , c("posX","posY")], 
              trainPoints = trainPoints, AP = AP)
par(oldPar)
dev.off()

# Run the KNN estimation with 5 neighbors, as the book does it
estXYk5 = predXY(newSignals = onlineSummary[ , 6:11], 
                 newAngles = onlineSummary[ , 4], 
                 offlineSummary, numAngles = 3, k = 5)

calcError(estXYk5, actualXY)

# Plot
pdf(file="D:/SMU/qtw/case3/GEO_FloorPlanK5Errors.pdf", width = 10, height = 7)
oldPar = par(mar = c(1, 1, 1, 1))
floorErrorMap(estXYk5, onlineSummary[ , c("posX","posY")], 
              trainPoints = trainPoints, AP = AP)
par(oldPar)
dev.off()

# 5NN actually has a lower SSE than 9NN, however, the cross validation showed that 9NN has the least SSE when cross validated with the offline data
# What could have caused the discrepancy between CV and actual prediction?







