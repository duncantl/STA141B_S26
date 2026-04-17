rx11 = "(.*) - ([^ ]+) \\[([^]]+)\\] \"([A-Z]+) ([^\"]+) (HTTP|FTP)/(1.[01])?\" ([0-9]+) (-|[0-9]+) \"([^\"]*)\" \"([^\"]+)\""

m = gregexpr(rx11, ll, perl = TRUE)
substring(ll[1], attr(m[[1]], "capture.start"), attr(m[[1]], "capture.start") + attr(m[[1]], "capture.length") - 1L)



rxn = "(?<ip>.*) - (?<login>[^ ]+) \\[(?<timestamp>[^]]+)\\] \"(?<operation>[A-Z]+) (?<file>[^\"]+) (?<protocol>HTTP|FTP)/(?<protVersion>1.[01])?\" (?<status>[0-9]+) (?<bytes>-|[0-9]+) \"(?<refer>[^\"]*)\" \"(?<agent>[^\"]+)\""
# getCaptures.R  F20

getCapture =
function(str, m, asDataFrame = FALSE)
{
    st = attr(m, "capture.start");
    ans =  substring(str, st, st + attr(m, "capture.length") - 1L)
    if(asDataFrame)
        structure(as.data.frame(as.list(ans), stringsAsFactors = FALSE, make.names = FALSE),
                  names = attr(m, "capture.names"))
    else
        ans
}

m = gregexpr(rxn, ll, perl = TRUE)
