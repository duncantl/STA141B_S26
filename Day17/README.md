# Day17

+ Getting the URLs from each state
   + readHTMLTable()
   + get URL for links in second column on city names
   + fixing the hrefs of the form `javascript:l("Adin");`

+  Getting the links via XPath in the second column of the city table for a given state

```r
# Get the href in the second column of each row in the 9th table
u1 = getNodeSet(cit, "//descendant::table[position() = 9]//tr//descendant::td[2]//@href")
# same but with the XPath shorthand
u2 = getNodeSet(cit, "((//table)[9]//tr//td[2]//a/@href)")
```

+ Exploring the data for a city 
   + section nodes
   + id attribute
   + getting all sections

```r
secs = getNodeSet(doc, "//section")
sids = sapply(secs, xmlGetAttr, "id")
# or
sids = unlist(getNodeSet(doc, "//section/@id"))
```
   
+ [code in cityData.R](../Day16/cityData.R)

+ [R session](Rsession)
