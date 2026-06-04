

# Review

+  Reading non-standard data
    + `strsplit()`
	+ grouping lines/elements - `split(, cumsum(condition))`


+ Validating results
    + Checking results are "sane"


+ Regular Expressions
    + Cleaning data - e.g., remove % from text vector of 
	+ Extracting data - e.g., Web logs
	+ Finding elements, e.g., IP addresses
	+ Special characters - `.`, `^`, `$`, `[]`, `()`
    + Quantifiers - `*`, `?`, `+`, `{m,}`, `{m,n}`, `{,n}`
	+ Character sets - `[a-f]`, `[-,.]`, `[01[:space:]]`
	+ Negated character sets - `[^iou]`
    + Named Character sets - `[:space:]`, `[:punct:]`, `[:digits:]`
	    + used in 

+ SQL
    + Joins - INNER and LEFT
	+ `SELECT WHERE condition`
	+ GROUP BY
	+ ORDER BY
	+ LIMIT
	+ Aggregate functions
	   + `COUNT()`, `SUM()`, `MIN()`, `MAX()`, `AVG()`
	   + `COUNT(DISTINCT )`
	+ JOIN on the same table
	
	
+ XPath	
    + sequence of steps
	+ each step = axis, node test, and optional condition
	   + `/descendant-or-self::div[@class = 'foo']`
    + Various different axes - `//`, `@`, `ancestor-or-self`, `descendant`, ....
    + node test - name of node or, e.g., `text()`, `comment()`
    + condition
	   + =, not, ...
	   + and, or
	   + functions - contains(), starts-with(), 
