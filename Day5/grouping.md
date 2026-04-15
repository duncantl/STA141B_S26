
## A useful idiom/approach
## Grouping contiguous elements of a character vector by a start-of-group pattern.

Goal: Have a  pattern that identifies the start of each group and
    separate the contiguous elements into a list with an element for each group.



Start with a character vector:
```
# timestamp=...
# usec=250
# mindReadings=110
lines of data 
...
lines of data
# Trace finished: maximum number of polls (110) reached"
# timestamp=...
# usec=250
# mindReadings=110
lines of data 
...
lines of data
# Trace finished: maximum number of polls (110) reached"
# timestamp=...
....
```

Create a parallel vector (`g) identifying which group each line belongs to, e.g., group number 1, 2, 3, ...

```
1 # timestamp=...
1 # usec=250
1 # mindReadings=110
1 lines of data 
1 ...
1 lines of data
1 # Trace finished: maximum number of polls (110) reached"
2 # timestamp=...
2 # usec=250
2 # mindReadings=110
2 lines of data 
2 ...
2 lines of data
2 # Trace finished: maximum number of polls (110) reached"
3 # timestamp=...
3 ....
```

If we had this group identifier vector, we can use
```
split(lines, g)
```


How do we get the group identifier vector `g`?
```
w = grepl("# timestamp", ll)
cumsum(w)
```

Importantly, `w` looks like

```
TRUE 1  # timestamp=...
FALSE 1 # usec=250
FALSE 1 # mindReadings=110
FALSE 1 lines of data 
FALSE 1 ...
FALSE 1 lines of data
FALSE 1 # Trace finished: maximum number of polls (110) reached"
TRUE 2  # timestamp=...
FALSE 2 # usec=250
FALSE 2 # mindReadings=110
FALSE 2 lines of data 
FALSE 2 ...
FALSE 2 lines of data
FALSE 2 # Trace finished: maximum number of polls (110) reached"
TRUE 3  # timestamp=...
FALSE 3 ....

```

Since TRUE corresponds to 1 and FALSE to 0 when R converts a logical vector to an integer for
`cumsum()`, we get 
So the cumsum is 
```
1 TRUE 1  # timestamp=...
1 FALSE 1 # usec=250
1 FALSE 1 # mindReadings=110
1 FALSE 1 lines of data 
1 FALSE 1 ...
1 FALSE 1 lines of data
1 FALSE 1 # Trace finished: maximum number of polls (110) reached"
2 TRUE 2  # timestamp=...
2 FALSE 2 # usec=250
2 FALSE 2 # mindReadings=110
2 FALSE 2 lines of data 
2 FALSE 2 ...
2 FALSE 2 lines of data
2 FALSE 2 # Trace finished: maximum number of polls (110) reached"
3 TRUE 3  # timestamp=...
3 FALSE 3 ... 
```
And that is the group identifier vector.


So the full code is
```
split(ll, cumsum(grepl("# timestamp", ll)))
```
