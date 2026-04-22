ll = readLines("../../Data/eeyore.log")
rx = '^(([0-9]{1,3}\\.?){4}) - (-|[a-z0-9]+) \\[([^]]+)\\] "(GET|POST|OPTION|HEAD|[A-Z]+) (.*) HTTP/(1\\.[01])" ([0-9]+) (-|[0-9]+) "(-?|[^"]+)" "(.*)"'

m = gregexpr(rx, ll, perl = TRUE)
tmp = mapply(getCapture, ll, m, FALSE)
df = as.data.frame(t(tmp))
dim(df)
names(df) = c("IP", "other", "login", "time", "operation", "path", "httpVersion", "status", "bytes", "referrer", "browserInfo")
# other corresponds to the 4 elements of the IP address at the start in the 2nd capture group.
sapply(df, class)
rownames(df) = NULL
df = df[, -2]
df$httpVersion = as.numeric(df$httpVersion)
df$status = as.integer(df$status)
df$bytes = as.integer(df$bytes)

table(df$status)
summary(df$bytes)

table(df$httpVersion)

