##  Longitude

Next we want to explore the longitude values.
In our cloudhigh1.txt file, these are on the 6th line.
Ideally, these are on the 6th line for all of our .txt files.
Furthermore, we would like that they are the same values for each file.
We want this so that we can have the same `month, latitude, longitude` triples for each variable 
so we can match rows across the 7 variables.

We need to verify this.
We have 2 questions 
 
1. Does the 6th line contain the longitude values in each .txt file?
2. Are the longitude values the same for all files?


There are 2 approaches to answering these questions.

1. Process the 6th line in each file, extracting the values and seeing if they are the same
2. Check if the 6th line is identical across all files.


2. is the simplest and if it is true, we have the answer to both questions.
If it is not true, we have to use approach 1 which involves more code.
However, we will use that same code to extract the values anyway.

Let's start with approach 2.
```{r}
l6 = sapply(lines, `[`, 6)
length( unique(l6) )
```
So all line 6s are the same and we know from cloudhigh1.txt that this is the longitude values.



### Computing the longitude values

The next step is to compute the longitude values.
The line is
```
          113.8W 111.2W 108.8W 106.2W 103.8W 101.2W 98.8W  96.2W  93.8W  91.2W  88.8W  86.2W  83.8W  81.2W  78.8W  76.2W  73.8W  71.2W  68.8W  66.2W  63.8W  61.2W  58.8W  56.2W  
```

We can 

+ split the terms by the space character, and 
+ remove the "" elements

We then have terms such as 113.8W, 111.2W, ....

We need to convert these to -113.8 and -111.2 since West is conventionally negative.


We'll write a function to do all of these computations 
```{r}
getLongitudes =
function(x)
{
   els = strsplit(x, " ")[[1]]
   els = els[ els != "" ]
   fixLongitudes(els)
}
````

We referred to a function `fixLongitudes()` which takes each string such as `"113.8W"` and 

+ removes the W 
+ determines whether the value is West or East
+ multiplies the West values by -1

We have to write that function, something like the following:
```{r}
fixLongitudes =
function(x)
{
   we = substring(x, nchar(x))
   vals = as.numeric( substring(x, 1, nchar(x) - 1L))
   west = we == "W"
   vals[west] = -1*vals[west]
   vals
}
```

We need to test these 2 functions

```{r}
fixLongitudes("133.8W")
fixLongitudes(c("133.8W", "111.3W"))
```

We might use `stopifnot()` to signal an error if the results don't correspond to our expectations
```{r}
stopifnot( identical( fixLongitudes("133.8W"), -133.8) )
stopifnot( identical( fixLongitudes(c("133.8W", "111.3W")), c(-133.8, -111.3)))
```

We should also test with East values.

Next, we verify the `getLongitudes()` function

```{r}
long = getLongitudes(lines[[1]][6])

 [1] -113.8 -111.2 -108.8 -106.2 -103.8 -101.2  -98.8  -96.2  -93.8  -91.2  -88.8  -86.2  -83.8  -81.2  -78.8  -76.2  -73.8  -71.2
[19]  -68.8  -66.2  -63.8  -61.2  -58.8  -56.2
```

We can verify these values "by eye". This is tedious and hence error-prone.

However, we can also compute the difference between successive values.

```{r}
diff(getLongitudes(lines[[1]][6]))
 [1] 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6 2.4 2.6
```

So this not a regular, equally-spaced grid but there are only 2 different values - 2.4 and 2.6.  
So the results seem reasonable.


An alternative to the lines
```{r}
   els = strsplit(x, " ")[[1]]
   els = els[ els != "" ]
```
in `getLongitudes()` is

```{r}
scan(textConnection(x), "character")
```

In this case, it is marginally more convenient. If these were already numbers, this would be more convenient
as we could use 
```{r}
scan(textConnection(x), "numeric")
```
and `scan()` would take care of NAs, etc.


The key idea here is that we have the content to processed as a string, not the name of a file.
`scan()` ordinarily takes the name of a file. If we pass it the text/content, it gets confused.
By using `textConnection(x)`, we are creating a file-like source of content. In other words,
the text-connection indicates to `scan()` that it should read the content of the string and not treat it as the name of a file.

