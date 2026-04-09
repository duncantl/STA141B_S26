## Day 4

This assembles material from days 3 and 4.

See [Day2](../Day2) for an introduction and computing the date in each file.


+ [Checking and Computing Longitudes](Longitude.md)

+ [Latitude and Grid Values](LatitudeAndGridValues.md)

+ [data.frame for each file](DataFrameSingleFile.md)

+ [Checking latitudes match for all files](CheckingLatitudesMatch.md)

+ [Reading all files for a single variable](ReadingSingleVariable.md)

+ [Combining Variables](CombiningVariables.md)

```{r}

vars = c("cloudhigh", "cloudmid", "cloudlow", "ozone", "temperature", "surftemp", "pressure")
xx = combineVars(vars)
```


+ [Verifying the results](Verifying.md)

