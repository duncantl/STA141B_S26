# Day 14
# Web Scraping - Introduction


+ [New York Times graphic](https://www.nytimes.com/interactive/2015/05/03/upshot/the-best-and-worst-places-to-grow-up-how-your-area-compares.html)
   + Get the data underlying the map
   + Web browser Developer tools
     + Inspect elements in the page
	 + Network requests
   + Find the elements in the HTML/SVG (Scalable Vector Graphics) content
      corresponding to a county in the map
   + Find the request for the CSV

   + We have the CSV in the browser developer tools and can copy that.	 
   + Or can fetch it programmatically
```r
u = "https://static01.nyt.com/newsgraphics/2015/04/21/county-mobility/0360769d17a8ef66ee331b8cf7d1a1f02c88c70b/Countycausalestimates25Apr2015smaller.csv"
d = read.csv(u)
```
   + No cookies or anything needed for the HTTP request to get the CSV file.



+ [Shipping information](https://www.marinetraffic.com)
   + Interactive map
   + Find the data in the HTTP requests
   + JSON content
   + https://www.marinetraffic.com/getData/get_data_json_4/z:2/X:1/Y:0/station:0
   + read.csv() won't work.
   + Separate getting the content from parsing it
   + download.file() ?
     + Needs cookie
	 + RCurl::getURLContent()
	 + Still doesn't work
	 + Security problems with this request.
   + But we have the JSON in the browser developer tools and can copy that.	 

+ HAR file
   + Save the network requests in the developer tools to a HAR file
     + Also JSON format
   + [HAR package](https://github.com/duncantl/HAR) in R to read a HAR file
   + Explore the requests, responses, etc. in R.


```r
library(HAR)
h = readHAR("www.marinetraffic.com_Archive [26-05-14 20-30-33].har")
ty = sapply(h$responseHeaders, `[`, "content-type")
w = grepl("application/json", ty)
unique(h$url[w])
```
