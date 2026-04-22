# Day 7

+ Process each line once and match all the elements
   + rather than processing each line to get each element separately.
   + the latter approach means you either have to match the previous/earlier elements in the line again to ensure you
     are at the new element, or risk the match including content from previous/earlier element.

+ [R Session](Rsession)
   + Reading the Web log data by 

+ [Annotated description of how to read the Web logs](../Day6/WebLogApproach.md)

+ `getCapture()` function
   + use with `gregexpr(rx, vec, perl = TRUE)`

+ [Using getCapture()](usingGetCapture.R)

+ [Using gsub() and strsplit() to get the capture group information](gsubStrsplit.R)
   + using `strsplit(gsub(rx, "\\1;;\\2;;\\3", ll), ";;")` to transform each 
      overall string into its captured elements separated by a separating string (`;;`)
	   we make up and then split the strings in one operation to get the individual elements for
	   each line.
   + Can't handle more than 9 capture groups without a 2 step process, unlike the `getCapture()` approach.
