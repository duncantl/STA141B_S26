
+ Many different ways to do this with regular expressions.
  + Could also split by space and "fix" things assuming regularity to structure of content.
    + Doesn't necessarily work, generally.
	
	
+ Iteratively build a regular expression
  + match the IP address
  + then the - 
  + then login - or a sequence of characters or perhaps more general
  + the time stamp between the []
  + the " for the "GET ..."
  + the HTTP command
  + the file path - can it contain spaces?
  + HTTP
  + protocal version 
  + "
  + status
  + number of bytes or -
  + referrer URL in ""
  + the browser information in ""


+ How to match an IP address?
  + or maybe just anything but a space
  + or maybe anything followed by a " -".  But that could greedily match up to the - after a
    redirection, i.e., where no bytes were returned so the number of bytes is -
	
+ 
```
rx = "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} "
w = grepl(rx, ll)
table(w)
```

+ Now add the login field

```
rx = "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z]+) "
w = grepl(rx, ll)
table(w)
```

+ Matched all but 35.  
  + Examine these - `ll[!w]`
  + The login may also  contain numbers

```
rx = "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) "
w = grepl(rx, ll)
table(w)
```
  + Matched them all.

+ Now the time stamp


```
rx = "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\]"
w = grepl(rx, ll)
table(w)
```

+ Let's check this date value
```
rx = "^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) (\\[[^]]+\\]) .*"
d = gsub(rx, "\\2", ll)
head(d)
```
  + note the " .*" at the end of the regex
  + let's parse them
```
tm = as.POSIXct(strptime(d, "[%d/%b/%Y:%H:%M:%S -0800]"))
table(is.na(tm))
```
  + so they all have the format we expected.

+ HTTP command, file path and HTTP/version
  + We can get each element, or
  + we could get the entire contents within the ""
     + for this, there is a common idiom
```
"[^"]+"
```
     +  a double quote followed by one or more characters that are not a double quote followed by a
        double quote
	 + or *" and everything after this up to the next "*
```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([^"]+)" .*'
d = gsub(rx, "\\2", ll)
head(d)
```  
   + Note I switched to '' for the regular expression string. This allows us to easily have " in the string.
   + Are these all of the same format - command file-path HTTP/version ?
```
els = strsplit(d, "[ /]")
table(sapply(els, length))
```
    + so the number of elements is between 5 and 10
```
d[sapply(els, length) == 10]
```
	+ Can't split on / for the HTTP/1.1 because also splits the file path.

```
els = strsplit(d, " ")
table(sapply(els, length))
```
    + All have 3 elements
    + Check the 3rd element of each is of the form HTTP/1.1 or HTTP/1.0
```
p = sapply(els, `[`, 3)
table(grepl("^HTTP/1.[01]$", p) )
```
    + all match
	+ Could then split the third element at / and 
	
	
+ Back to getting the command, path and protocol and version separately

```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "[A-Z]+ [^ ]+ HTTP/1.[01]"'
table(grepl(rx, ll))
head(d)
```

+ Let's check the commands
```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" .*'
table(gsub(rx, "\\2", ll))
```
   + What are the HBESPY and WFZWXO
```
ll[ gsub(rx, "\\2", ll) %in% c("HBESPY", "WFZWXO")]
# or
grep('"HBESPY|WFZWXO ', ll, value = TRUE)
```
  + Note the path is / for these. Also, the IP address is the same.  But they are 2 days apart.


+ The status and the number of bytes

```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} [0-9]+'
table(w <- grepl(rx, ll))
```
   + Lot's of non-matches
   + `head(ll[!w])`
      + See 304 -
   + So allow for number of bytes also being -
   
```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} ([0-9]+|-)'
table(w <- grepl(rx, ll))
```   
    + all match


+ The referral URL 
  + " up to the next "

```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} ([0-9]+|-) "[^"]"'
table(w <- grepl(rx, ll))
```   
   + Lot's of non-matches
```
head(ll[!w])
head(ll[w])
```
    + Only matching "-".
    	+ Makese sense since `"[^"]"` matches this.
    + Should have `"[^"]+"` - add + after character set to allow 1 or more.

```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} ([0-9]+|-) "[^"]+"'
table(w <- grepl(rx, ll))
```
    + 1 line doesn't match
```
ll[!w]
```
```
[1] "41.220.68.249 - - [03/Nov/2015:02:41:58 -0800] \"GET /stat141/Lectures/Day1.pdf HTTP/1.1\" 200 116340 \"\" \"Mozilla/5.0 (Linux; Android 4.2.2; en-us; SAMSUNG GT-I9192 Build/JDQ39) AppleWebKit/535.19 (KHTML, like Gecko) Version/1.0 Chrome/18.0.1025.308 Mobile Safari/535.19\""
```
    + This is the empty string, not `"-"` !!!
	+ Okay, allow for 0 or more elements
	   + Change + to a *
```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} ([0-9]+|-) "[^"]*"'
table(w <- grepl(rx, ll))
```


+ The browser

```
rx = '^[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3} - (-|[a-z0-9]+) \\[[^]]+\\] "([A-Z]+) [^ ]+ HTTP/1.[01]" [0-9]{3} ([0-9]+|-) "[^"]*" "[^"]*"'
table(w <- grepl(rx, ll))
```


# Extracting the elements

+ put capture groups on each element we want
  + Approach 1
     + `gregexpr(rx, ll, perl = TRUE)`
     + extract the 

```
rx = '^([0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}) - (-|[a-z0-9]+) \\[([^]]+)\\] "([A-Z]+) ([^ ]+) HTTP/1.([01])" ([0-9]{3}) ([0-9]+|-) "([^"]*)" "([^"]*)"'
                 1                                        2               3            4         5            6          7        8           9        10
```
      + 10 is a problem - \\10 means \\1 followed by 0
