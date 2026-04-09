## Combining variables

We can simply bind the columns from each of the 7 data.frames

```{r}
df = do.call(cbind, dfv)
class(df)
dim(df)
names(df)
```

We can remove the duplicated latitude, longitude, date columns.
There are many ways to do this and each has pros and cons.

I think the safest is 
+ take the first data.frame
+ loop over the others to get the values
+ combine these
+ change the column names where the column name is "values" to vars
   + event better - set names of dfv to vars and use that vector of names

```{r}
xx = cbind(dfv[[1]], lapply(dfv[-1], `[`, 1))
class(xx)
dim(xx)
names(xx)
```
So this has 10 columns and latitude, longitude and date are not repeated.
However, there are 7 columns named "values".

We set the names of the columns to reflect the variable names, leaving
latitude, longitude and date as they are:
```{r}
w = names(xx) == "values"
names(xx)[ w ] = vars
```

And we check:
```{r}
names(xx)
```


Next, we do a quick sanity check on the values in each column
```{r}
summary(xx)
```
cloudlow is a character vector!!


```{r}
length(unique(xx$cloudlow))
```

```{r}
unique(xx$cloudlow)
```

Note the `"...."`


We skipped over checking the cloudlow or any of the variables and possible NA values.


We can go back to how we read each file and recognize ... as NA.
We can use `read.table(, na.strings = "....")` in `readFile()`


We now have to repeat all the computations to read each file, stack them, combine columns and change the names.
We should have a function to do this to make redoing these computations simple and error-free.


So let's add an argument to `readFile()` to specify the NA strings.
With that addition and all the repeated calculations

```{r}
summary(xx)
```
```
   cloudhigh       latitude        longitude           date               cloudmid        cloudlow         ozone        temperature       surftemp        pressure     
 Min.   : 0.0   Min.   :-21.20   Min.   :-113.8   Min.   :1995-01-16   Min.   : 0.00   Min.   : 0.50   Min.   :232.0   Min.   :269.1   Min.   :266.0   Min.   : 615.0  
 1st Qu.: 1.5   1st Qu.: -6.85   1st Qu.: -99.4   1st Qu.:1996-07-08   1st Qu.: 7.50   1st Qu.:15.00   1st Qu.:254.0   1st Qu.:295.5   1st Qu.:294.1   1st Qu.: 995.0  
 Median : 8.5   Median :  7.50   Median : -85.0   Median :1997-12-31   Median :14.00   Median :23.50   Median :264.0   Median :299.2   Median :296.9   Median :1000.0  
 Mean   :12.0   Mean   :  7.50   Mean   : -85.0   Mean   :1997-12-30   Mean   :15.27   Mean   :26.24   Mean   :267.2   Mean   :297.9   Mean   :296.2   Mean   : 985.4  
 3rd Qu.:18.5   3rd Qu.: 21.85   3rd Qu.: -70.6   3rd Qu.:1999-06-23   3rd Qu.:22.00   3rd Qu.:34.50   3rd Qu.:276.0   3rd Qu.:301.4   3rd Qu.:299.2   3rd Qu.:1000.0  
 Max.   :62.5   Max.   : 36.20   Max.   : -56.2   Max.   :2000-12-16   Max.   :83.50   Max.   :84.50   Max.   :390.0   Max.   :310.0   Max.   :314.9   Max.   :1000.0  
                                                                                       NA's   :110                                                                     
```
So we have 110 NAs for cloudlow, but not for any other variables. 

