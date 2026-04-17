# Get all the files whose name ends in .txt
ff = list.files("~/Data/NASAWeather", pattern = "\\.txt$", full = TRUE)

# Get the line with the TIME:   and
# extract just the date part, omitting the TIME   :  and the 00:00


# Get all the TIME lines
tm = sapply(ff, function(x) grep("^ *TIME *:", readLines(x), value = TRUE))

# Then process them all in one call to gsub()
# Want to identify the date part in a captured group, match everything and leave just the captured group.
tm2 = gsub(".* TIME * : ([0-9]{2}-[A-Z]{3}-(19|20)[0-9]{2}) 00:00", "\\1", tm)



# Longitudes

tmp = sapply(ff, function(x) readLines(x)[6])
els = strsplit(tmp, " +")
els[[1]]
