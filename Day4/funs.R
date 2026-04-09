getLongitudes =
function(x)
{
   els = strsplit(x, " ")[[1]]
   els = els[ els != "" ]
   fixLongitudes(els)
}

fixLongitudes =
function(x)
{
   we = substring(x, nchar(x))
   vals = as.numeric( substring(x, 1, nchar(x) - 1L))
   west = we == "W"
   vals[west] = -1*vals[west]
   vals
}


fixLatitudes =
function(x)
{
   ns = substring(x, nchar(x))
   vals = as.numeric( substring(x, 1, nchar(x) - 1L))
   south = ns == "S"
   vals[south] = -1*vals[south]
   vals
}

# We should consolidate fixLongitudes and fixLatitudes as they are very similar.


readFile = 
function(filename, na.strings = "....")
{
   lines = readLines(filename)
   tb = read.table(textConnection(lines[-(1:7)]), na.strings = na.strings)
   
   ans = data.frame(values = unlist( tb[, -(1:3) ]) )
   long = getLongitudes(lines[6])
   lat = fixLatitudes(tb[,1])
   ans$latitude = rep(lat, 24)
   ans$longitude = rep(long, each = 24)
   ans$date = getTime(lines)
   ans
}



readVariable =
function(varName, dir = "NASAWeather", files = list.files(dir, pattern = varName, full = TRUE))
{
    v = lapply(files, readFile)
    do.call(rbind, v)
}


combineVars =
function(varNames, dir = "NASAWeather")
{
    dfv = lapply(varNames, readVariable, dir = dir)
    ans = cbind(dfv[[1]], lapply(dfv[-1], `[`, 1))
    w = names(ans) == "values"
    names(ans)[ w ] = varNames
    invisible(ans)
}
