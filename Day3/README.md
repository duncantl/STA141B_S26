## Day 3 - Climate Data

We continued reading the climate data from Day 2.

We already wrote a function to get the date/time - `getTime()`.
This takes the lines for a given file and extracts the date from the 5th line.


We start by reading the lines for each file.
Then we apply getTime to the contents of each file:
```
ff = list.files("NASAWeather", full = TRUE, pattern = ".txt")
lines = lapply(ff, readLines)
names(lines) = ff
dt = sapply(lines, getTime)
class(dt)
```
The result was numeric. However, for a single file 
```
class(getTime(ff[1]))
```
the class was `Date`.  `sapply` didn't know to make the result of class `Date`.
We can set the class manually
```
class(dt) = "Date"
```

The Date class allows R to do meaningful computations on the values as dates, e.g., the difference
between two dates, and it will include knowledge of leap years, etc.

Checking the results,
```
range(dt)

[1] NA NA
```

That's not what we expected.
Let's look at `summary()`
```
summary(dt)
```
```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
   9146    9686   10226   10226   10766   11307       1 
```

So there is one NA value.
To which file does this correspond?
```
ff[is.na(dt)]
[1] "NASAWeather/intlvtn.dat"
```
This is the elevation data. It has a different format and even file extension name.
We don't expect it to have the same structure. 
We can look at its contents either by reading the file or 
```
head(lines[ is.na(dt) ] [[ 1 ]])
```
```
[1] "-113.75 -111.25 -108.75 -106.25 -103.75 -101.25 -98.75 -96.25 -93.75 -91.25 -88.75 -86.25 -83.75 -81.25 -78.75 -76.25 -73.75 -71.25 -68.75 -66.25 -63.75 -61.25 -58.75 -56.25"
[2] "36.25 1526.25 1759.56 1948.38 2241.31 1692.75 865.19 472.5 231.69 334.38 82.44 102.56 325.25 459.31 306.19 131.88 0.62 0.19 0 0 0 0 0 0 0"
[3] "33.75 612.94 1079.12 1979.31 1780.56 1370.25 879.81 404.25 174.94 179.62 38.69 101.19 212.31 315.81 97.81 40.06 0.12 0 0 0 0 0 0 0 0"
[4] "31.25 328.62 1228.88 1483.69 1326.06 1117.5 685 437.31 80.31 65.25 34.88 58.44 55.94 86.5 12.190.56 0 0 0 0 0 0 0 0 0"
[5] "28.75 367.81 349.69 1145.25 1698.56 1345.75 675.44 439.12 17.12 2.25 0 0 0 0.38 18.38 0 0 0 0 0 0 0 0 0 0"
[6] "26.25 58.5 122.88 278.12 2151.25 1364.94 1419.69 181.19 0 0 0 0 0 0 0.06 0 0 0 0 0 0 0 0 0 0"
```


## Omit the elevation data

```
lines = lines[ !is.na(dt) ]
```






