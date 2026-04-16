The idea is 
 + match this pattern from where you currently are
 

The regular expression language does all the hard work of looking ahead 
to see if we currently match the pattern from the current position,
and 
+ if not, moving to the next position and searching for a match, or
+ if there is a match, moving to the character immediately after the matched pattern and continuing
  to look for the next pattern specified in the regular expression



## Special/meta characters

+ match literal string patterns
+ `.` - match any character

+ Character sets - 
   + one of any of the following, e.g, an `a` or `b` or  `c` 
   + e.g., `[abcdef]`, `[a-f]`, `[A-Z0-9]`
   + named character sets, e.g., `[[:space:][:punct:]]`  
  + `[abc]`, `[a-z]` 
  + `[[:space:][:digit:]]` - named character sets
  + `[^a-z]` - negation/anything but any of the set of characters


+ `(pat1|pat2)` 
   + either of two patterns
   + this pattern or that pattern
   + Different from character set because specifying entire sub-patterns
   + `(horse|donkey)`

+ `^` - start of string

+ `$` - end of string


+ Quantifiers for indicating how many times to match the previous pattern.
  + refer to the most recent subpattern
   + `?` - 0 or 1 matches
   + `*` - 0 or more matches
   + `+` - 1 or more matches
   + `{n}` - n matches
   + `{m,n}` - betweem m and n matches, inclusive
   + `{m,}` - at least m matches
   + `{,n}` - at most n matches


+ Capture Groups and Backreferences
  + `( patterns )`
  + Can refer to them via \\1, \\2, ...

+ Escape Meta-characters
  + "\\*" - two slashes and character.

+ Other elements
  + `\\s` - any whitespace character
  + `\\w` - any alpha-numeric  character
  + `\\d` - any digit







## R Functions

+ grep(rx, x)  - returns integer vector of the indices of the elements of x that match the pattern.
+ grepl(rx, x) - returns a logical vector with the same length as x and each element is TRUE if the
  pattern was found for that element, or FALSE otherwise.
+ gregexpr(), regexpr(), regexec(), gregexec() - 
    find where in each string (element of x) the pattern matches.
+ regmatches() - get the matches from gregexpr()/regexpr().
+ gsub(), sub() - transform elements of a character vector by 


strsplit() also takes a regular expression for what pattern for splitting.


These functions grep(), etc. work separately on each string, i.e., each element of a character
vector in a single call.


If you want them to treat a collection of strings as a single block, use `paste(strings, collapse =
"")` (or `sep = "\n"`) to make a single string. Then you can find patterns across "lines".


Each function has several arguments/parameters that allow us to control different aspects of the
pattern matching.

### `perl = TRUE` or FALSE

Use standard regular expressions (FALSE) or the extended PERL-compatible regular expression dialect.



# Tutorials/References

+ https://www.regular-expressions.info/tutorial.html
+ [book] Mastering Regular Expressions, Jeffrey Friedl. 
