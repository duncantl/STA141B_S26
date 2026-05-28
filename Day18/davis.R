
# We get this from the table of cities in California.
# See ../Day16/cityData.R

u = "https://www.city-data.com/city/Davis-California.html"
doc = htmlParse(readLines(u))

# Get all the <section> nodes

secs = getNodeSet(doc, "//section")
sids = sapply(secs, xmlGetAttr, "id")
names(secs) = sids

length(secs)

# A lot more than for Adin-California.html
u2 = "https://www.city-data.com/city/Adin-California.html"
doc2 = htmlParse(readLines(u2))

secs2 = getNodeSet(doc2, "//section")
sids2 = sapply(secs2, xmlGetAttr, "id")
names(secs2) = sids2

# Way too much copying and editing code.
# Easy to make a mistake.
# Write functions - sectionFuns.R
source("cityDataFuns.R")


adin = cityParse("Adin")
sa = getSections(adin)

davis = cityParse("Davis")
sd = getSections(davis)

length(sa)
length(sd)

# 59 and 97

setdiff(names(sa), names(sd))
# character() so sections for Adin is a subset of those for Davis.
setdiff(names(sd), names(sa))

acr = cityParse("Acalanes-Ridge")
sac = getSections(acr)

setdiff(names(sac), names(sd))
# [1] "migrations"    "forum-archive"
# so not a subset of davis.


x = sd
nm = lapply(x, function(x) xpathSApply(x, ".//*", xmlName))
sort(table(unlist(nm)))
table(sapply(nm, contains, "table"))

# where do all the tables come from?
table(sapply(x, function(x) length(getNodeSet(x, ".//table"))))
nt = sapply(x, function(x) length(getNodeSet(x, ".//table")))
which.max(nt) 


##
# city-population
x$"city-population"

xpathSApply(x$"city-population", ".//b", xmlValue)

# No

xpathSApply(x$"city-population", ".//text()", xmlValue)

v = xpathSApply(x$"city-population", ".//text()[normalize-space(.) != '']", xmlValue)
# still have the "\n "

# might assume same for all cities and get 2nd and 4th elements
ans = structure(v[c(2, 4)], names = gsub(":$", "", v[c(1, 3)]))

# Convert to numbers
# Get % urban and rural


## crime

length(getNodeSet(x$crime, ".//table"))
cr = readHTMLTable(getNodeSet(x$crime, ".//table")[[1]])

# Didn't get the final row.
# tfoot

idx = xpathSApply(x$crime, ".//table//tfoot//td", xmlValue)
rbind(cr, idx)


## race

r = x$'races-graph'
v = xpathSApply(r, ".//li[@class = 'list-group-item']/*", xmlValue)
race = as.data.frame(matrix(v, , 3, byrow = TRUE))

names(race) = c("count", "percent", "race")
race$percent = gsub("%$", "", race$percent)
race$count = as.integer(gsub(",", "", race$count))


## median-rent

r = x$"median-rent"
v = xmlValue(r)
v = currency(gsub(".*:", "", v))

# Could also just get the $2,248

v = xmlValue(getNodeSet(r, ".//p/text()")[[1]])
currency(v)


currency =
function(x)    
{
    as.numeric(gsub("[$€£,]", "", x))
}


## median-income
x$"median-income"
# Table

getTable =
function(x)    
{
    readHTMLTable(getNodeSet(x, ".//table")[[1]])
}


####XXX
# schools
s = x$schools
s
h = getNodeSet(s, ".//h3")
ul = getNodeSet(s, ".//ul")
ul2 = lapply(h, function(x) getNodeSet(x, ".//following-sibling::ul")[[1]])

# for each ul, get each li and process it
mkSchoolList =
function(u)
{
    xpathSApply(u, ".//li", xmlValue)
}

mkSchoolInfo =
function(x)
{
   x
}

schools = lapply(ul, mkSchoolList)
names(schools) = sapply(h, xmlValue, trim = TRUE)

# Now post-process text to get final ()
# Extract name: val

y = data.frame(desc = unlist(schools),
               category = rep(names(schools), sapply(schools, length)))

yy = gsub("(.*)\\(.*\\)$", "\\1", y$desc)
p = gsub("(.*)\\((.*)\\)$", "\\2", y$desc)
y$desc = trimws(yy)
els = strsplit(p, "(, ?|;)")

nm = lapply(els, function(x) grep(":", x, value = TRUE))

nm2 = lapply(nm, function(x) structure( gsub("^.*: ", "", x), names = gsub(":.*", "", x)))

stu = sapply(nm2, function(x) x["Students"])
w = is.na(stu)
stu[w] = sapply(nm2[w], function(x) orNA(x[grep("enrollment", names(x))]))

grades = sapply(nm2, function(x) orNA(x["Grades"]))

y$numStudents = as.integer(stu)
y$grades = grades



## elevation

z = x$elevation
e = xmlValue(z, trim = TRUE)
as.integer(gsub("Elevation:|feet", "", e))




#######

ca = getStateCities("California")
ca.docs = vector("list", nrow(ca))
names(ca.docs) = ca$url
for(u in ca$url) {
    Sys.sleep(10)
    message(u)
    ca.docs[[u]] = cityParse(, url = u)
}
#ca.docs = lapply(ca$url, function(u) { Sys.sleep(10); message(u); cityParse(, url = u)})
#names(ca.docs) = ca$url

# Takes a while -
# A lot of time in the HTTP requests.
# want to cache these so we don't have to get them again.

ca.xml = structure(sapply(ca.docs, saveXML), names = ca$url)
saveRDS(ca.xml, "ca.xml.rds")


# Exploring manually, we saw some with the data in a <table>
# How many are like ths



