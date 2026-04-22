# This shares a lot of code with usingGetCapture.R
# The only difference is between the lines #<DIFF> and #</DIFF>
# Because there are 11 capture groups, we can't get them all without extra work.
# We can only get 0 through 9. So we lose the referrer and browser.
# But this approach works when there are fewer than 10 capture groups or if we can
# not number a capture group.
#
#  The getCapture() approach is more general.
#
ll = readLines("../../Data/eeyore.log")
rx = '^(([0-9]{1,3}\\.?){4}) - (-|[a-z0-9]+) \\[([^]]+)\\] "(GET|POST|OPTION|HEAD|[A-Z]+) (.*) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) "(-?|[^"]+)" "(.*)"'


#<DIFF>
# We can't reference the 10th capture group.  It would be \\10 which is interpreted as \\1 followed by the literal 0.
tmp = gsub(rx, "\\1;;\\3;;\\4;;\\5;;\\6;;\\7;;\\8;;\\9", ll)
els = strsplit(tmp, ";;")
df = as.data.frame(matrix(unlist(els), , 8, byrow = TRUE))
names(df) = c("IP", "login", "time", "operation", "path", "httpVersion", "status", "bytes")
#</DIFF>


dim(df)
sapply(df, class)
rownames(df) = NULL
df = df[, -2]
df$httpVersion = as.numeric(df$httpVersion)
df$status = as.integer(df$status)
df$bytes = as.integer(df$bytes)

table(df$status)
summary(df$bytes)

table(df$httpVersion)

