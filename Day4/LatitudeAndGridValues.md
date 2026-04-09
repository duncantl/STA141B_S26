## Latitude

The next step is to compute the latitude values.

One approach is to 

+ get all the lines from line 8 to the end of the file
+ split the elements by space
+ remove the "" elements
+ get the first element from each line
+ convert the North and South to numbers, removing that identifier and multiply the S elements by -1

This is quite similar to the `getLongitudes()` and `fixLongitude()` functions but

+ operates on multiple lines
+ uses only the first element of each line
+ handles N/S rather than W/E


We could implement that approach as, e.g., `getLatitudes()`.
However, we can save some work by recognizing that the lines we are processing are a 24 x 27 grid
and contain the 

+ latitudes and
+ the values in the grid for the variable.


To read all of these, we could use the `strsplit()` approach and convert the values again for latitude and the cell values.
However, `read.table()` knows how to do this and will 

+ drop the "" elements
+ analyze and convert columns to the appropriate type, e.g., numbers

So we could use either of 
```{r}
t1 = read.table(ff[1], skip = 7)
t2 = read.table(textConnection(lines[[1]][-(1:7) ]))
```
The first uses the file name and skips the first 7 lines; the second
uses the lines we already read from the file and drops the first 7 lines.
The second approach can be helpful so we avoid re-reading the contents of the file.
It won't make much of a speed difference in our case.


```{r}
class(t2)
[1] "data.frame"

sapply(t2, class)

         V1          V2          V3          V4          V5          V6          V7          V8          V9         V10 
"character" "character" "character"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric" 
        V11         V12         V13         V14         V15         V16         V17         V18         V19         V20 
  "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric" 
        V21         V22         V23         V24         V25         V26         V27 
  "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric"   "numeric" 
```

```
      V1 V2  V3   V4   V5   V6   V7   V8   V9  V10  V11  V12  V13  V14  V15  V16  V17  V18  V19  V20  V21  V22  V23  V24  V25  V26  V27
1  36.2N  / 51: 26.0 23.0 23.0 17.0 19.5 17.0 16.0 16.0 16.0 19.0 18.0 19.0 19.5 19.5 18.0 16.0 14.0 14.0 14.0 18.0 20.5 22.0 25.5 25.5
2  33.8N  / 50: 20.0 20.0 18.5 16.5 18.0 15.0 15.0 15.0 16.0 15.0 15.0 17.5 17.0 17.0 17.0 17.5 17.5 18.0 19.0 19.0 20.0 22.0 23.5 23.5
3  31.2N  / 49: 16.0 16.0 14.0 12.5 13.5 14.5 13.5 13.5 13.5 13.0 13.0 16.5 18.5 20.0 21.0 21.0 21.0 20.5 20.5 19.5 19.0 19.0 19.0 20.5
4  28.8N  / 48: 13.0 11.0 11.0 11.0 14.0 13.5 11.5 12.0 15.0 18.0 18.0 18.5 20.5 20.5 18.5 18.0 17.0 15.0 15.0 14.0 13.0 13.0 13.5 12.5
5  26.2N  / 47:  7.5  8.0 10.5 10.5 15.0 16.5 19.5 20.0 20.5 19.5 17.0 16.0 16.0 16.0 12.5  9.5  8.5  7.5  5.5  4.5  4.5  6.5  6.5 10.0
6  23.8N  / 46:  8.0 11.0 13.0 19.5 19.5 26.0 27.5 25.5 20.0 14.0  9.5  8.5 10.0  8.0  4.5  5.0  5.0  4.5  3.5  2.5  2.5  4.0  8.0 12.5
7  21.2N  / 45: 14.5 13.5 15.0 19.5 28.0 28.0 23.0 14.0  6.0  3.5  3.5  3.0  3.0  3.5  3.0  2.5  1.5  1.5  1.0  1.5  2.5  3.5  4.0  7.0
8  18.8N  / 44: 19.5 19.5 24.0 24.5 24.0 21.5 14.5  7.5  3.0  1.0  0.5  0.5  1.0  2.5  1.5  1.5  1.5  1.0  1.0  1.0  1.5  1.5  1.5  2.5
9  16.2N  / 43: 22.5 26.0 24.0 18.0 13.0  7.5  4.0  2.0  2.0  1.0  1.0  1.0  0.5  0.5  0.5  1.0  1.0  1.0  0.5  0.0  0.0  1.0  1.0  1.0
10 13.8N  / 42: 21.0 26.5 25.5 20.0 12.0  6.0  3.0  2.0  1.5  1.5  1.0  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5  0.5
11 11.2N  / 41: 19.0 20.0 21.0 14.0  8.5  5.5  3.0  1.5  1.5  1.0  1.0  1.5  2.0  3.0  1.0  1.0  1.5  1.0  0.5  0.5  0.0  1.0  1.0  0.5
12  8.8N  / 40: 16.5 16.5 15.0 10.0  8.0  7.5  5.0  3.0  3.0  2.5  2.5  2.0  1.5  1.5  1.5  1.5  3.5  4.0  2.0  1.5  1.0  1.5  1.5  1.0
13  6.2N  / 39: 17.5 15.0 15.0 16.5 12.5 11.5 13.0 13.0 12.0 10.5  9.0  9.0  6.0  3.0  5.5 12.0  8.0  3.0  2.0  3.5  3.0  2.5  2.0  1.5
14  3.8N  / 38:  5.5  4.5  5.0  5.5 11.0 11.5 15.5 17.5 17.0 16.0 19.0 22.0 12.0  6.5 16.5 13.5  4.0  5.5  9.0  9.0  5.0  2.0  2.0  3.5
15  1.2N  / 37:  0.5  0.5  0.0  0.0  1.0  3.0  5.0  8.0  8.0  8.0  7.5  5.0  4.5 11.5 15.0  9.0  8.5 13.0 18.5 15.5  7.0  5.0  5.5  7.5
16  1.2S  / 36:  0.0  0.0  0.0  0.0  0.0  0.5  1.5  3.5  3.0  1.5  1.0  0.0  0.5  3.5  7.5 11.5 15.0 20.5 21.5 20.0 14.5 13.5 15.5 21.0
17  3.8S  / 35:  0.5  0.0  0.0  0.0  0.5  1.0  1.5  3.0  3.5  1.5  0.5  0.0  0.0  1.0  7.0 13.5 21.5 25.5 27.5 29.0 26.5 26.5 29.5 32.0
18  6.2S  / 34:  1.5  1.0  1.0  0.5  0.5  1.0  2.5  3.0  2.0  2.0  1.0  0.5  0.5  1.0  5.5 11.5 17.5 28.5 32.0 35.5 35.0 36.5 39.5 41.0
19  8.8S  / 33:  1.5  3.0  1.5  1.0  1.5  1.5  2.5  2.5  2.5  2.5  2.5  2.5  1.5  1.0  3.0 21.0 21.5 26.5 33.5 40.5 43.0 44.5 42.5 46.0
20 11.2S  / 32:  2.0  3.0  4.0  3.5  2.0  1.0  1.0  1.5  2.5  2.5  2.0  2.0  1.0  1.5 14.5 36.5 30.0 30.0 36.0 38.5 41.5 44.0 44.0 47.5
21 13.8S  / 31:  4.0  3.0  3.0  3.5  3.0  2.5  1.5  1.0  2.0  2.0  2.0  1.5  1.0  1.5  4.5 27.0 41.0 42.5 32.0 33.0 39.0 43.0 48.0 45.5
22 16.2S  / 30:  3.5  3.0  1.5  1.0  3.0  2.5  1.5  1.5  1.0  1.0  1.0  0.5  1.0  2.5  4.0  7.0 16.0 28.5 35.5 39.0 34.0 31.0 39.0 45.0
23 18.8S  / 29:  2.5  2.5  2.5  1.5  1.0  0.5  0.5  0.5  0.5  0.5  0.5  1.5  2.5  3.0  3.0  3.0  3.0 13.5 31.0 31.0 31.5 26.5 36.0 36.5
24 21.2S  / 28:  0.5  1.5  1.5  1.0  0.5  0.0  0.0  0.0  0.5  1.0  1.0  1.0  1.5  2.5  1.5  1.0  1.0  1.5 14.0 29.5 22.5 24.0 36.0 36.5
```

To get the latitude values, we subset the first column
```{r}
t2[,1]
```
We have to convert these values to numbers as we did with `fixLongitude()`, but we have the elements.


To get the measured values for the variable (e.g., cloudhigh), we can drop the first 3 columns
and then unravel/unlist the remaining values into a 24 x 24 vector
```{r}
v = unlist(t2[, -(1:3)])
length(v)
[1] 576
class(v)
[1] "numeric"
```

These are organized by column, i.e., the first column of values, followed by the second column, third column, ..., 24th column.
