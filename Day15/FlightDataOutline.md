
## flightaware.com

+ In the Web browser, open the Network tab in the developer tools and visit flightware.com
  + Scroll down to the map and click "Track Now"
  + Collect the HTTP requests by moving the map, zooming, etc.

+ find the data
  + numerous JSON files
     + returned as html in the content-type  (odd)

+ They look like
  + https://www.flightaware.com/ajax/vicinity_airports.rvt?minLon=70.52686805371195&minLat=-12.3046875&maxLon=180&maxLat=90

+ We can get the information from the HAR file.

```
h = readHAR("www.flightaware.com_Archive [26-05-15 19-55-30].har")
i = grep("vicinity_airports", h$url)
```

+ We can parse the JSON
```r
j = lapply(h$content[i], fromJSON)
```

+ Would have to do this manually in the browser to get updated data, i.e., get a new HAR file.

+ Instead, make the HTTP queries to get the JSON directly  from R

```r
u = "https://www.flightaware.com/ajax/vicinity_airports.rvt?minLon=70.52686805371195&minLat=-12.3046875&maxLon=180&maxLat=90"
tt = readLines(u)
```

or 
```
out = tempfile()
download.file(u, out)
```

+  No need to customize/control the HTTP request.






IATA - international air transport association
ICAO - international civil aviation organization


---


# Lookup IATA codes

+ Get database
   + Publically available or purchase?


+ Web pages for single queries

https://www.iata.org/en/publications/directories/code-search/?airport.search=SFO

+ Enter code and send query
  + Watch the network queries

```
https://www.iata.org/PublicationDetails/Search/?currentBlock=314384&currentPage=12572&airport.search=OAK
```

+ query string added to the URL - OAK

+ Simple HTTP request wth no additional information.

```
ll = readLines("https://www.iata.org/PublicationDetails/Search/?currentBlock=314384&currentPage=12572&airport.search=OAK")
```

+ Get HTML as response

```
cat(ll, sep = "\n")
```

+ Could use regular expressions, but don't


```
doc = htmlParse(ll)
n = getNodeSet(doc, "//tr")
lapply(n, xmlSApply, xmlValue, trim = TRUE)
```




+ Alternatively,
  + https://www.world-airport-codes.com/
  + https://scm-en.ecer.com/airport.html


+ Both have search facilities and we can use that.


+ world-airport-codes.com has a list of all the airports by code
   + Alphabetically - A, B, C, ...
   + Many pages for each letter


