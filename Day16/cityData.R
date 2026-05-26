
library(XML)

u0 = "https://www.city-data.com/"


"https://www.city-data.com/city/California.html"


# Get the links for all the states

tt = readLines(u0)
doc = htmlParse(tt)



ln = getHTMLLinks(doc)
length(grep("/city/", ln, value = TRUE))
length(unique(grep("https:.*/city/", ln, value = TRUE)))


# Follow one state - California.html

uc = "https://www.city-data.com/city/California.html"


# Get list of all the cities
#  Big cities
#  Small cities
#  All cities


# Name, Population, Link/URL

cit = htmlParse(readLines(uc))
tbl = readHTMLTable(cit)
length(tbl)
sapply(tbl, nrow)
city = readHTMLTable(cit, which = 9)


# Clean the population
city$Population = as.integer(gsub(",", "", city$Population))

# Remove the trailing ', CA' from Name
city$Name = gsub(", CA$", "", city$Name)


# Need the URLs for the cities
# Got get the 9th table and the links in the second column


u = getNodeSet(cit, "//descendant::table[position() = 9]//tr//descendant::td[2]//@href")
u = getNodeSet(cit, "((//table)[9]//tr//td[2])")
u = getNodeSet(cit, "((//table)[9]//tr//td[2]//a/@href)")

u = unlist(u)
ucs = getRelativeURL(u, uc)
#errors
# javascript:l("Acalanes-Ridge")

# So clean these
# Some are regular URLs
# Others have javascript
# Different size cities have different formatting

# Acalanes-Ridge maps to https://www.city-data.com/city/Acalanes-Ridge-California.html
# So map javascript:1("Acalanes-Ridge") to https://www.city-data.com/city/Acalanes-Ridge-California.html


u3 = gsub('javascript:l\\("([^"]+)"\\);', "\\1-California.html", u)
ucs = getRelativeURL(u2, uc)

# Have all the cities, not just the Bigger ones.
# The Web page is dynamically displaying only the selected subset,
# but the table contains the entire set of cities.


###
# For each city, get all the information


doc = htmlParse(readLines("https://www.city-data.com/city/Davis-California.html"))
#Inspect
# or XPath to find node.


# Found section id="population-by-sex"
# Find all section with id node

s = getNodeSet(doc, "//section[@id]")
sids = sapply(s, xmlGetAttr, "id")
names(s) = sids

z = s[["elevation"]]
e = xmlValue(z, trim = TRUE)
as.integer(gsub("Elevation:|feet", "", e))

# alternatively
e = xpathSApply(z, ".//p/text()", xmlValue)
as.integer(gsub("feet", "", e))


# 
s[["city-population"]]

s[["population-by-sex"]]

s[["races-graph"]]



# Can painstakingly go through each section and convert it.
# Write functions to handle different cases.
# Hopefully, can reuse these for similarly structured sections

cbind(
  f0(s[["elevation"]]),
  f1(s[["city-population"]]),
  f2(s[["population-by-sex"]]),
  f1(s[["races-graph"]])
  ...
)


# Alternatively, write code that recognizes the structure
# e.g. procStructure()
# Then can call 
tmp = lapply(s, procSection)
do.call(rbind, tmp)


# Now to write procStructure()


