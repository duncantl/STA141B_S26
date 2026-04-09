## data.frame for one file

We are now ready to assemble the data.frame for one file.
We can compute

+ the values
+ the latitudes
+ the longitudes
+ the date


As we saw earlier, the values from the 24x24 grid are in a numeric vector.
This is organized as column 1, column 2, column 3, ... and not by row.

So now we can create a data.frame with 576 (24^2) rows and
repeat the latitude and longitude appropriately so that each value
is associate with the correct latitude and longitude.

```{r}
readFile = 
function(filename)
{
   lines = readLines(filename)
   tb = read.table(textConnection(lines[-(1:7)]))
   
   ans = data.frame(values = unlist( tb[, -(1:3) ]) )
   long = getLongitudes(lines[6])
   lat = fixLatitudes(tb[,1])
   ans$latitude = rep(lat, 24)
   ans$longitude = rep(long, each = 24)
   ans$date = getTime(lines)
   ans
}
```

Now we have to check the function works correctly.

```{r}
z = readFile(ff[1])
```

Check the structure of the result
```{r}
class(z)
dim(z)
names(z)
sapply(z, class)
```

Now check the values.
```{r}
summary(z)


     values         latitude        longitude           date           
 Min.   : 0.00   Min.   :-21.20   Min.   :-113.8   Min.   :1995-01-16  
 1st Qu.: 1.50   1st Qu.: -6.85   1st Qu.: -99.4   1st Qu.:1995-01-16  
 Median : 7.00   Median :  7.50   Median : -85.0   Median :1995-01-16  
 Mean   :10.88   Mean   :  7.50   Mean   : -85.0   Mean   :1995-01-16  
 3rd Qu.:17.50   3rd Qu.: 21.85   3rd Qu.: -70.6   3rd Qu.:1995-01-16  
 Max.   :48.00   Max.   : 36.20   Max.   : -56.2   Max.   :1995-01-16  
```

Do these seem sensible?

+ the values are between 0 and 100, consistent with % values.


We might be better reading surface temperature and looking at its
distribution and how it changes by month and year.
