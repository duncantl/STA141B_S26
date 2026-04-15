# Text Manipulation, Text Pattern Matching and Regular Expressions

+ [Web log data](https://canvas.ucdavis.edu/courses/1073084/files?preview=30851286)

```
114.188.183.88 - - [01/Nov/2015:03:41:50 -0800] "GET /stat141/Code/Session1.txt HTTP/1.1" 404 223 "https://www.google.co.jp/" "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36"
180.76.15.13 - - [01/Nov/2015:04:23:12 -0800] "GET /stat141/Homeworks.html HTTP/1.1" 200 1432 "-" "Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/search/spider.html)"
```
   + [Parts of the Web log line]()


+ [Wireless data]()
  + [Find the metadata lines](metaLines.R)
  + [Group by `# timestamp`](grouping.md) [group.R](group.R)
     + `split(lines, cumsum(grepl(pattern, lines)))`
  + [Using regular expressions to split all the elements on each line](https://canvas.ucdavis.edu/courses/1073084/files?preview=30864069)
     + On canvas.



+ [R Session](Session)



  
