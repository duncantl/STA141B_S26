
# Web log structure

```
                                                                             protocol version  number of bytes returned
																					 |_|      |_|
114.188.183.88 - - [01/Nov/2015:03:41:50 -0800] "GET /stat141/Code/Session1.txt HTTP/1.1" 404 223 "https://www.google.co.jp/" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36"
|____________|   ^ |__________________________|  |_| |________________________| |__| |_|  |_|     |_________________________| |____________________________________________________________________________________________________________|
   IP address   login     timestamp            command   path to requested doc.  protocol  status     referring URL                browser and operating system information.

```


+ We want to read the file into a data.frame
   + a row in the DF for each line in the file
   + Columns
      + IP address - string
	  + login name - string
	  + timestampt - POSIXct
	  + command - string
	  + path - string
	  + protocol - string
	  + version - numeric
	  + status - integer
	  + numBytes - integer
	  + referrer - string
	  + browserInfo - string
	  
	  
+ We'll parse the browser strings separately.	  


+ **Challenge for Thursday's class** - 
   + how to read each line and extract each variable correctly.
      + Can almost do it by splitting on spaces, but have to be very careful.
      + Instead, use a regular expression
        + also have to be very careful.
   + Extract the variables from each line and arrange in a data.frame & then convert each column as necessary.

