mkPropsDF = 
function(p)
{
    o = c("origin", "destination")
    
    d = as.data.frame(p[ !(names(p) %in% o) ])

    if(!("altitude" %in% names(d)))
        d[c("altitude", "altitudeChange", "groundspeed")] = NA
    
    tmp = lapply(p[o], fixPos)
    tmp2 = unlist(tmp)
    d[names(tmp2)] = tmp2
    
    d
}

fixPos =
    function(x)
{
    lapply(x, orNA)
}

orNA =
function(x)
{
    if(is.null(x) || length(x) == 0)
        return(NA)

    x
}


mkFeatureDF =
function(f)
{
    df =  mkPropsDF(f$properties)

    pos = f$geometry$coordinates
    df[c("x", "y")] = pos

    df
}

