
getCapture =
    #
    # Given a string and the corresponding element (m) from gregexpr(rx, vector, perl = TRUE)
    # this uses the capture.start and capture.length to get the contents of all the capture groups.
    # This returns either a character vector or a data.frame.
    # If the capture groups have names in the regex, we use these as the column names for the data.frame
    #
function(str, m, asDataFrame = FALSE)
{
    st = attr(m, "capture.start");
    ans = substring(str, st, st + attr(m, "capture.length") - 1L)
    if(asDataFrame)
        structure(as.data.frame(as.list(ans), stringsAsFactors = FALSE, make.names = FALSE),
                  names = attr(m, "capture.names"))
    else
        ans
}
