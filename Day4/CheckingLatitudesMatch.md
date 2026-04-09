## Checking latitudes are the same


Firstly, remove the elevation file
```{r}
ff = ff[!is.na(dt)]
```

Let's read each file.
```{r}
v = lapply(ff, readFile)
class(v)
length(v)
table(sapply(v, class))
table(sapply(v, dim))
```

So we have the correct structure.
But what about the values?


Let's confirm the longitudes and latitudes are the same in all data.frames.

```{r}
lg = lapply(v, `[[`, "longitude")
table( sapply(lg, identical, lg[[1]]))
```

```{r}
lt = lapply(v, `[[`, "latitude")
table( sapply(lt, identical, lt[[1]]))
```
