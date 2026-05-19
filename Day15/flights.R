library(HAR)
h = readHAR("www.flightaware.com_Archive [26-05-15 19-55-30].har")
i = grep("vicinity_aircraft.rvt", h$url)

table(sapply(h$responseHeaders[i], `[`, "content-type"))

# But the browser displays the response as JSON.

substring(h$content[i][1], 1, 1000)

grepl("FeatureCollection", h$content[i])

library(RJSONIO)
jj = lapply(h$content[i], fromJSON)

sapply(jj, names)

table(unlist(lapply(jj, names)))


f = lapply(jj, `[[`, "features")
sapply(f, length)

f = unlist(f, recursive = FALSE)

tt = table(unlist(lapply(f, names)))

table(sapply(f, `[[`, "type"))

table(sapply(f, function(x) x$geometry[["type"]]))

table(sapply(f, function(x) length(x$properties)))

# So most have 16 elements, but some have 13


sort(table(unlist(lapply(f, function(x) names(x$properties)))))

# So altitude, altitudeChange and groundSpeed do not always appear.


f[[1]]$properties

sapply(f[[1]]$properties, class)


np = sapply(f, function(x) length(x$properties))

i = sapply(f[np == 16], function(x) sapply(x$properties, class))
class(i)
dim(i)
apply(i, 1, unique)

# All but origin and destination are primitive types, hopefully scalars.
# origin and destination are lists


f[[1]]$properties$origin
f[[1]]$properties$destination

# These are lists of scalar values.
# We might assume that all have this form.
# Better to check

table(sapply(f, function(x) all(sapply(x$properties$orgin, length) == 1)))
# Yes
table(sapply(f, function(x) all(sapply(x$properties$destination, length) == 1)))
# No for 1715 of 11237 

w = sapply(f, function(x) all(sapply(x$properties$destination, length) == 1))
f[!w][[1]]$properties$destination

# NULL

# Let's test for NULL or length 1
table(sapply(f, function(x) all(sapply(x$properties$destination, function(x) is.null(x) || length(x) == 1))))
# Looks good.


# So convert the NULL to NA.

# We can convert all the properties into a data.frame by "flattening" the values including the origin and destination




source("funs.R")

z = lapply(f, mkFeatureDF)
table(sapply(z, class))

table(sapply(z, ncol))
table(sapply(z, nrow))

table(sapply( z, function(x) all(names(x) == names(z[[1]]))))

# So wrong order
# Actually, I had spelled groundspeed as groundSpeed

table(sapply(z, length))
# So all the same number of columns

tt = table(unlist(lapply( z, names)))
table(tt)

z2 = lapply(z, function(x, v) x[v], names(z[[1]]))


dd =  do.call(rbind,z)

# Fix the type of the columns

names(dd)[sapply(dd, is.character)]


dd[1, names(dd)[sapply(dd, is.character)]]


# landingTimes appears integer/numeric
table(grepl("^[0-9]+$", dd$landingTimes))

tmp = as.integer(dd$landingTimes)
summary(tmp, useNA = "always")
length(table(tmp))


# origin.isUSAirport, destination.isUSAirport should be logical

v = c("origin.isUSAirport", "destination.isUSAirport")
sapply(dd[v], function(a) table(grepl("^TRUE|FALSE$", a)))
dd[v] = lapply(dd[v], as.logical)



# direction is 0 to 360

# landingTimes looks like seconds
w = dd$landingTimes == 0
lt = structure(as.integer(dd$landingTimes), class = c("POSIXct", "POSIXt"))
lt[w] = NA

summary(lt)
