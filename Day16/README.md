# Day 16

## Web Scraping
### HTML and XPath


+ [XPath tutorial](https://www.w3schools.com/xml/xpath_intro.asp)

+ HTML structure
   + Tree of nodes
      + nodes may have 
	     + name (e.g., table, html, tr, a, div)
	     + parent node
		 + children  nodes
		 + attributes, e.g., `<a href="https://www.city-data.com" class="...">text</a>`
		     and href and class are attributes.


+ [city-data.com](https://www.city-data.com)

   + Get the links to the page for each state listing its cities
      + determining if they were in JSON or static HTML
	  + guessing the pattern and making the URLs directly R
      + Getting the links from the HTML document
         + getHTMLLinks() & grep()
         + or `getNodeSet(doc, "//a[contains(@href, '/city/')]")`
		    + XPath expression.
			+ // - descendant-or-self, i.e., don
   + Reading the page listing cities in California
     + [page](https://www.city-data.com/city/California.html)
     + Determining if the information (city name, link, population) is dynamic (JSON or JavaScript data)
       or in HTML
     + readHTMLTable()
	    + 9 tables
		   + we want the 9th based on dimensions.
        + `readHTMLTable(doc, which = 9)`
	    + not quite
		  + gets the city name and population
		  + but not the link to the page for that city.

     + need to do this ourselves with XPath
	    + 2 approaches
		  1. find all the tr nodes in the table with XPath 
		     and manipulate these to get the link, city name and population
             as a triple
          2. use XPath 	to separately get
		      + the city name
			  + the city link
			  + the population
			  
        + Approach 2 can be problematic in general
		   + may get different number of matches for each of the 3 steps
		   and then don't know what values go with what values
		      + e.g., 100 rows and we get 100 values for both city and link but only 98 values for population
			     + we don't know which population goes with which city.


+ [R code for reading city-data front page and state cities list](cityData.R)

+ [R session](Rsession)
