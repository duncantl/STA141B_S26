library(XML)

cityParse =
    # get the HTML document for the given city and also parse it as an HTML document
function(cityName, state = "California",
        url = sprintf("https://www.city-data.com/city/%s-%s.html", cityName, state))
{
    htmlParse(readLines(url))
}

getSections =
function(doc)
{
    secs = getNodeSet(doc, "//section")
    sids = sapply(secs, xmlGetAttr, "id")
    names(secs) = sids
    secs
}


########

getStateCities =
function(stateName, url = sprintf("https://www.city-data.com/city/%s.html", stateName))
{
    # Not a city but still can use that function.  Should have given it a better name.
    doc = cityParse(url = url)

    cities = readHTMLTable(doc, which = 9)

    href = getNodeSet(doc, "((//table)[9]//tr//td[2]//a/@href)")
    href2 = gsub('javascript:l\\("([^"]+)"\\);', "\\1-California.html", href)
    cities$url = getRelativeURL(href2, url)

    cities$Population = as.integer(gsub(",", "", cities$Population))
    cities
}


