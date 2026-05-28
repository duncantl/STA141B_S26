getTable =
    # getTable(x$crime)
    # getTable(x$foreign, header = FALSE)
function(x, ...)    
{
    # get the table
    tblNode = getNodeSet(x, ".//table")[[1]]
    readHTMLTable(tblNode, ...)
}

elevation =
function(sec)
{
    e = xmlValue(sec, trim = TRUE)
    as.integer(gsub("Elevation:|feet", "", e))    
}


getTextP =
    # <section id="median-rent" class="median-rent">
    #   <p><b>Median gross rent in 2024:</b> $2,248.</p>
    # </section> 
    #
function(x)
{
    #    xmlValue(getNodeSet(x, ".//p/text()")[[1]])
    xpathSApply(x, ".//p/text()", xmlValue)
}

getTextTop =
function(x)
    xpathSApply(x, "./text()", xmlValue, trim = TRUE)


crime =
function(x)
{
    ans = getTable(x)

    # Get the footer <tfoot> at the bottom of the table.
    idx = xpathSApply(x, ".//table//tfoot//td", xmlValue)
    
    # per thousand
    ans2 = ans
    ans2[-1] = lapply(ans[-1], function(x) mkNumeric(gsub("^[0-9,]+\\(([0-9,.]+)\\)", "\\1", x)))

    # clean the answer
    ans[-1] = lapply(ans[-1], function(x) mkInteger(gsub("\\(.*", "", x)))

    
    list(counts = rbind(ans, idx), perThousand = rbind(ans2, idx))
}

mkInteger =
function(x, cvt = as.integer)
    cvt( gsub(",", "", x) )

mkNumeric =
function(x)
    mkInteger(x, as.numeric)



#######

schools =
function(s)
{
    h = getNodeSet(s, ".//h3")
    ul = getNodeSet(s, ".//ul")
    ul2 = lapply(h, function(x) getNodeSet(x, ".//following-sibling::ul")[[1]])

    schools = lapply(ul, mkSchoolList)
    names(schools) = sapply(h, xmlValue, trim = TRUE)

    fixSchools(schools)
}


fixSchools =
  # Now post-process text to get final ()
  # Extract name: val    
function(schools)
{
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

  y
}

# for each ul, get each li and process it
mkSchoolList =
function(u)
{
    xpathSApply(u, ".//li", xmlValue)
}



###
airports =
function(x)    
{
    name = xpathSApply(x, ".//li/a[starts-with(@href, '/airports')]/@href")
    a2 = unlist(xpathSApply(x, ".//li/a[not(starts-with(@href, '/airports'))]/@href"))

    # &amp; converted to &
    lat = gsub(".*lat=([0-9.]+)&.*", "\\1", a2)
    long = gsub(".*lng=([-0-9.]+)$", "\\1", a2)    
    
    data.frame(name = name, lat = as.numeric(lat), long = as.numeric(long))
}



####
population =
function(x)
{
    v = xpathSApply(x$"city-population", ".//text()[normalize-space(.) != '']", xmlValue)
    # still have the "\n "

    # might assume same for all cities and get 2nd and 4th elements
    ans = structure(v[c(2, 4)], names = gsub(":$", "", v[c(1, 3)]))

    # Clean number and %
    # separate urban and rural

    ans
}


###

householdStats =
function(x)
{
    tbl = xpathApply(x, ".//table", readHTMLTable, header = FALSE)
    ti = xpathSApply(x, ".//table/preceding-sibling::b", xmlValue)
    names(tbl) = ti
    tbl
}


educationInfo =
    # need to arrange and convert results from character vector.
function(x)
{
    # new line text after <li> before <b> so need to skip this
    # v = xpathSApply(x, ".//li/text()", xmlValue, trim = TRUE)
    # So this instead
    v = xpathSApply(x, ".//li/b/following-sibling::text()", xmlValue, trim = TRUE)
    names(v) = xpathSApply(x, ".//li/b", xmlValue, trim = TRUE)
    v
}


edGini =
function(x)
{
    tb = getNodeSet(x, ".//div[@class = 'hgraph']//table")
    readHTMLTable(tb[[1]], header = FALSE)
}


# poverty-link

povertyURL =
function(x)
{
    u = getNodeSet(x, ".//a/@href")[[1]]
    getRelativeURL(u, "https://www.city-data.com/city")
}

poverty =
function(u,     doc = htmlParse( readLines(u) ))
{
    # all of these give the same result
    # getNodeSet(doc, "//text()[contains(., 'Breakdown by')]/../../..")
    # getNodeSet(doc, "//text()[contains(., 'Breakdown by')]/ancestor::ul")
    # First Breakdown by. Then look at the missing "tables" and see "Breakdown of"
    u = getNodeSet(doc, "//ul[contains(., 'Breakdown by') or contains(., 'Breakdown of')]")
    u = getPovertyULs(doc)

    e = lapply(u, procListGroup)
    names(e) = sapply(u, function(x) xpathSApply(x, "./li/b", xmlValue))

    c(e, bTables(doc), povertyUnnamed(doc))
}

procListGroup =
    function(x)
{
    v = xpathSApply(x, ".//li[@class = 'list-group-item']/span", xmlValue)
    names(v) = xpathSApply(x, ".//li[@class = 'list-group-item']/text()", xmlValue)
    v
}

getPovertyULs =
function(doc)    
{
    ti = c("Breakdown by", "Breakdown of", "Owners below poverty level", "Owners above poverty level")
    xp = sprintf("//ul[%s]", paste(sprintf("contains(., '%s')", ti), collapse = " or "))
    getNodeSet(doc, xp)
}


bTables =
function(doc)
{
    d = getNodeSet(doc, "//div[./b and ./b/following-sibling::div[./table]]")
    lapply(d, procBTable)
}

procBTable =
function(x)
{
    # avoid the <b> within the table's td
    ti = xpathSApply(x, ".//b[not(ancestor::table)]", xmlValue)
    # gives 6 rather than 5 because of
    # Hope this works for 
    ti = ti[-5]
    
    tb = xpathApply(x, ".//table", readHTMLTable, header = FALSE)
    names(tb) = ti
    tb
}


povertyUnnamed =
function(doc)
{
    g = xpathApply(doc, "//ul[contains(@class, 'list-group') and not(.//b)]", procListGroup)
    ti = unlist(getNodeSet(doc, "//ul[contains(@class, 'list-group') and not(.//b)]//preceding-sibling::img/@alt"))
    names(g) = ti
    g
}
