

# city-data.com


## State links

+ https://www.city-data.com/

```
doc = htmlParse(readLines("https://www.city-data.com/"))
```

+ Get links to each state

  + 
```
lnk = getHTMLLinks(doc)
clnk = unique(grep("/city/", lnk, value = TRUE))
clnk = unique(grep("\\.com/city/", lnk, value = TRUE))
```

   + 
```
xp = "//a[contains(@href, 'com/city/')]"
clnk2 = getNodeSet(doc, xp)

h = sapply(clnk2, xmlGetAttr, "href")
names(h) = sapply(clnk2, xmlValue)
```

   + From the dropdown menu Cities
```r
z = getNodeSet(doc, "//a[@class = 'dropdown-toggle' and starts-with(., 'Cities')]/following-sibling::ul//td//a")
```



##  State - city names and links

+ What about All cities, Bigger cities, Smaller cities

+ See if the data are in JSON.
   + No.

+ read the table of city names, populations and links.

```r
uc = "https://www.city-data.com/city/California.html"
cit = htmlParse(readLines(uc))
tbls = readHTMLTable(cit)
length(tbls)
sapply(tbls, dim)
```

We want the 9th.

```r
readHTMLTable()
```
+ 

