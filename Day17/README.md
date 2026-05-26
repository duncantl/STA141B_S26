# Day17

+ Getting the URLs from each state
   + readHTMLTable()
   + get URL for links in second column on city names
   + fixing the hrefs of the form `javascript:l("Adin");`

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
