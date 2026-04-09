## Verifying the Results


We start by checking the structure:
```
class(xx)
dim(xx)
names(xx)
sapply(xx, class)
```



We can check individual values.
```
i = sample(nrow(xx), 4)
xx[i,]
```

Here it is helpful if we had the file name for each row.
We could have added that in `readFile()`.
However, we can find which files these correspond to by matching the date:
```
dt = structure(sapply(lines, getTime), class = "Date")
j = match(xx$date[i], dt)
names(lines)[j]
```
So we have the file index/number (e.g., 16) for each variable



Next, we look at the content:
```
summary(xx)
```

cloudlow is the only variable with NAs.
How would we check this is correct?

Let's look in the text for each file (`lines`) for the literal string `....`
```
w = sapply(lines, function(x) any(grepl("....", x, fixed = TRUE)))
table(w)
```
```
basename(names(lines[w]))
```
By eye, these are all cloudlow.  It would be better to check this programmatically:
```
table(gsub("[0-9]+\\.txt", "", basename(names(lines[w]))))
```
This uses regular expressions to remove the, e.g., 61.txt at the end of each file name.


Let's look at the values of date.
```
table(xx$date)
table(table(xx$date))
```
So there are 576 = 24 * 24 values for each date, as we expect.

Are there any NAs for date?
```
table(is.na(xx$date))
```

Let's plot date against index/row number.
```
plot(xx$date)
```
The values at the bottom of the plot raise concerns. We need to investigate more.

```
unique(xx$date)
diff(unique(xx$date))
```
So these aren't arranged in increasing order of date. Let's plot them in order
```
plot(xx[order(xx$date),]$date)
```
This looks correct.


We've looked at the univariate summary for each variable.
Let's look at plots of the univariate distributions
```
par(mfrow = c(2, 4))
lapply(xx[vars], function(x) plot(density(x)))
```
This gives an error. This is because cloudlow has NAs.
So let's filter those:
```
par(mfrow = c(2, 4))
lapply(xx[vars], function(x) plot(density(x[!is.na(x)])))
```

We need the variable name on each plot
```
par(mfrow = c(2, 4))
lapply(vars, function(var) { x = xx[[var]]; plot(density(x[!is.na(x)]), main = var) })
```

These look reasonable. However, pressure is different from the others.
There is a very long tail on the low side.
Most of the values are around 1000.
Curiously, the maximum is exactly 1000 and many values are exactly 1000.
This seems like a limit rather than the actual value.


### Bivariate

Next, we look at bivariate relationships.

First, let's check the latitude and longitude.
```
par(mfrow = c(1, 1))
with(xx, plot(longitude, latitude))
```
This seems very regular. We can't see how many observations are at each location.
However, a two-way frequency table shows us:
```
with(xx, table(longitude, latitude))
table(with(xx, table(longitude, latitude)))
```

How do surface and near-surface air temperature relate to each other?
```
with(xx, plot(surftemp, temperature))
```

How does temperature vary with location? date?

```
with(xx, plot(date, surftemp))
```
This shows low values in January, rising through the middle of the year and
then cooling again.

What about cloud coverage and date?
```
with(xx, plot(date, cloudlow))
```
Does this make sense?



How do cloud high and mid relate to each other?
```
with(xx, plot(cloudhigh, cloudmid))
```

Before looking at each plot, specify what are your expectations
and then see if they are correct.
This is more valuable than simply looking at the distribution and
trying to come up with reasons why it makes sense.

In some contexts, we won't have reasonable expectations or intuition.
It is helpful to think hard or ask others for background knowledge.


Ozone and date
```
with(xx, plot(date, ozone))
```
And ozone and surface temperature
```
with(xx, plot(ozone, surftemp))
```
