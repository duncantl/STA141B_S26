## Reading the individual variables

```
vars = c("cloudhigh", "cloudmid", "cloudlow", "ozone", "temperature", "surftemp", "pressure")
ffv = lapply(vars, function(v) list.files("NASAWeather", pattern = v, full = TRUE))
sapply(ffv, length)
```


```
tmp = lapply(ffv, function(ffs) lapply(ffs, readFile))

sapply(tmp, class)
sapply(tmp, length)
sapply(tmp, function(x) table(sapply(x, class)))
sapply(tmp, function(x) table(sapply(x, nrow)))
```


Now let's stack each variable into a 72 * 24 * 24 data.frame
```
dfv = lapply(tmp, function(x) do.call(rbind, x))
class(dfv)
sapply(dfv, class)
sapply(dfv, nrow)
```


Now let's check the date column is the same for all 7 data.frames.

```
d = lapply(dfv, `[[`, "date")
sapply(d, identical, d[[1]])
```

We do the same for longitude and latitude
```
o = lapply(c("latitude", "longitude"), 
           function(v) {
              d = lapply(dfv, `[[`, v)
              sapply(d, identical, d[[1]])
		   })
sapply(o, all)
```

So the date, longitude, latitude columns are all the same.
We can now combine these

