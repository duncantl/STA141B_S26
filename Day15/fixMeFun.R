if(FALSE) {
    vars = names(tt)
    lapply(r, fixMe, vars)
}

fixMe =
function(x, varNames)    
{
    m = setdiff(varNames, names(x))
    if(length(m) > 0)
        x[ m ] = NA

    tmp = as.list(x)
    tmp2 = lapply(tmp[varNames], orNA)
    as.data.frame(tmp2)
}



