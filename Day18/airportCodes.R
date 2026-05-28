library(XML)

if(FALSE) {
u = "https://www.world-airport-codes.com/"
u = sprintf("https://www.world-airport-codes.com/alphabetical/airport-code/%s.html?page=1", letters)
}

if(FALSE) {
    tmp = lapply(letters, getByLetter)
    codes = do.call(rbind, tmp)
    rownames(codes) = NULL
    # 
    codes$IATA = gsub("^IATA: ", "", codes$IATA)
    codes$ICAO = gsub("^ICAO ", "", codes$ICAO)

    # But better
    v = c("Type", "City", "Country", "IATA", "ICAO", "FAA")
    codes[v] = lapply(codes[v], function(x) gsub("^[^:]+:[[:space:]]+", "", x))

    codes[] = lapply(codes, normalizeSpace)
}


getByLetter =
function(letter, url = "https://www.world-airport-codes.com/alphabetical/airport-code/")
{
    nextPage = paste0(url, letter, ".html?page=1")

    df = NULL
    #    browser()
    page = 1L
    while(!is.null(nextPage)) {
        message(letter, " page ", page)
        page = page + 1L
        doc = getPage(nextPage)
        tmp = procPage(doc)
        df = rbind(df, tmp)

        nextPage = computeNextPage(doc)
    }

    df
}


getPage =
function(u)    
{
    ll = readLines(u)
    htmlParse(ll)
}

procPage =
function(doc)
{
    readHTMLTable(doc, which = 1)
}


computeNextPage =
function(doc)
{
    u = getNodeSet(doc, "//link[@rel = 'next']/@href")[[1]]
    # The final page for a letter has a <link rel=next > and the href is back to page 1.
    # So have to check that.
    if(is.null(u) || grepl("page=1$", u))
        return(NULL)

    u
}


normalizeSpace =
function(x)
{
    trimws(gsub("[[:space:]]+", " ", x))
}
