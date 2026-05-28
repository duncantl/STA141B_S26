library(XML)
u = "https://sfbay.craigslist.org/sfc/apa/d/san-francisco-amazing-1br-apartment-in/7937190800.html"

# View the HTML source

# Some information in JSON in the HTML.

txt = readLines(u)
doc = htmlParse(txt)
sc = getNodeSet(doc, "//script")
length(sc)

getNodeSet(doc, "//script/@type")
# only 2,  not 6 as 4 don't have a type.


# Get the ones w/o a type attribute
sc2 = getNodeSet(doc, "//script[not(@type)]")

# Look at the attributes.
lapply(sc2, xmlAttrs)


# the 2 that have a type attribute are application/ld+json

library(RJSONIO)
js = xpathSApply(doc, "//script[@type]", function(x) fromJSON(xmlValue(x)))

names(js[[2]])

# Can look at js[[1]] but not as useful.



# Some information in the head in <meta>

meta = getNodeSet(doc, "//head/meta")

# Actually want the meta nodes that have a name or property attribute

meta2 = getNodeSet(doc, "//head/meta[@name or @property]")

sapply(meta2, xmlAttrs)


m = as.data.frame(t(sapply(meta2, xmlAttrs)))

# as a named character vector
m2 = structure(m[,2], names = m[,1])

m2["description"]
# Truncated so we will have to get the full version directly.


# Let's get the h1 with class postingtitle

getNodeSet(doc, "//h1[@class = 'postingtitle']")

getNodeSet(doc, "//h1[@class = 'postingtitle']/span[@class = 'price']")
# nothing

getNodeSet(doc, "//h1[@class = 'postingtitle']//span[@class = 'price']")

xpathSApply(doc, "//h1[@class = 'postingtitle']//span[@class = 'price']", xmlValue)

# get the housing span and titletextonly


# street address

xpathSApply(doc, "//h2[@class = 'street-address']", xmlValue)


# Information on the right of the description
#  application fee details
#  broker fee details
#  listed by
#  rent period
# Black bold
#
#  cats are OK
#   ...
#
# blue links
#
# All under <div class = "attrgroup">
#
# Some have the name of the attribute in the class and other just class="attr"

# div @class starts-with "attr "
at = getNodeSet(doc, "//div[@class = 'attrgroup']/div[starts-with(@class, 'attr')]")

# now get the values

sapply(at, xmlValue, trim = TRUE)


# Get the text of the post
# <section id="postingbody">
# Skip the first <div>

b = getNodeSet(doc, "//section[@id = 'postingbody']")
# Get the text
xmlValue(b)

# May want to respect the <br> - break nodes
# In other posts, may have richer HTML content.

# When posted

tm = getNodeSet(doc, "//div[@class = 'postinginfos']//time/@datetime")[[1]]
strptime(tm, "%Y-%m-%dT%H:%M:%S%z")



# Turn each of these into separate functions to get the different parts
# Then write a function to
#  fetch the URL content
#  parse as HTML
#  call these functions to get the parts
#  assemble into a data.frame() or list()


# Then try this on a different post
# Unlikely to work exactly. Need to adapt
#
#  some elements not present
#  slightly different @class values
#  slightly different structure
#
# Adapt functions to handle both
#
# Then try a third page
# Rinse and repeat.
# Gradually find differences
