readFile = 
function(filename, na.strings = "....")
{
   lines = readLines(filename)
   tb = read.table(textConnection(lines[-(1:7)]), na.strings = na.strings)
   
   ans = data.frame(values = unlist(tb[, -(1:3) ]))
   long = getLongitudes(lines[6])
   lat = fixLatitudes(tb[,1])
   # Don't like hard-coding 24 here.
   ans$latitude = rep(lat, 24)
   ans$longitude = rep(long, each = 24)
   ans$date = getTime(lines)
   ans
}


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



