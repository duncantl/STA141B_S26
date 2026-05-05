# Day 11

+ SQL from within R
  + RSQLite package
  + dbConnect()
  + dbGetQuery()
  + dbListTables()
  + dbListFields()
  + [convenience functions](../Day10/db.R)
  
+ 
```{r}
db = dbConnect("../Day9/cookies3.sqlite")
q = "SELECT * FROM moz_cookies"
ans = dbGetQuery(db, q)
class(ans)
dim(ans)
names(ans)
sapply(ans, class)
```

+ [R functions for working with a database](db.R)

+ [Slides](dbms3.html)
