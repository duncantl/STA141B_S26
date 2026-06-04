
## Phone Numbers
Find all phone numbers

+ 555 212 3126
+ (555) 212 3126
+ (555) 212-3126
+ 212 3126
+ 212-3126


Let's create an example

"We have 2 o212-3126, 212-3125



x = " A is 555 212 3126 and b could be (555) 212 3126, while c might be (555) 212-3126 but d is 212 3126, and a variant of that is 212-3126, covering all phone numbers!"


rx = "\\([0-9]{3}\\) [0-9]{3}-?[0-9]{4}"
gregexpr(rx, x)


rx = "\\([0-9]{3}\\) [0-9]{3}( |-?)[0-9]{4}"
regmatches(x, gregexpr(rx, x))

rx = "\\([0-9]{3}\\) [0-9]{3}( |-)[0-9]{4}|[0-9]{3}( |-)[0-9]{4}"
regmatches(x, gregexpr(rx, x))

+ Not quite -  matches too much 





##  Remember finding IP addresses

123.45.1.234

"([0-9]{1,3}\\.?){4}"
"([0-9]{1,3}\\.){3}[0-9]{1,3}"



## Find dates with different formats

2026/6/3
2026-6-3
3/6/2026


Write regular expressions to identify each format.
We can then subset those and convert them to dates.

x = c("2026/6/3", "2026-6-3", "3/6/2026")
dt = as.Date(rep(NA, length(x)))

w = grepl("^20[0-9]{2}/[0-9]+/[0-9]+$", x)
dt[w] = as.Date(x[w], "%Y/%m/%d")

w = grepl("^20[0-9]{2}[/-][0-9]+[/-][0-9]+$", x)
dt[w] = as.Date(x[w], "%Y/%m/%d")

This doesn't work due to conversion since there  are - characters and 
our format for as.Date() has / separators.

We could first convert - to / and then use the first regexp

So, starting again

```{r}
x = c("2026/6/3", "2026-6-3", "3/6/2026")
dt = as.Date(rep(NA, length(x)))

x = gsub("-", "/", x)
w = grepl("^20[0-9]{2}/[0-9]+/[0-9]+$", x)
dt[w] = as.Date(x[w], "%Y/%m/%d")

dt
```

Now do the 3/6/2026 format

```r
w = grepl("^[0-9]+/[0-9]+/20[0-9]{2}$", x)
dt[w] = as.Date(x[w], "%m/%d/%Y")

dt
```

All done.
