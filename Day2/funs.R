getTime =
function(ll)
{
    tmp = strsplit(ll[5], " :")[[1]][2]
    as.Date(strptime(tmp, "%d-%B-%Y %H:%M"))
}
