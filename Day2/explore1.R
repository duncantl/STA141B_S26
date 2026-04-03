ff = list.files("~/Data/NASA", pattern = "\\.txt", full = TRUE)

# Check the results of each computation to ensure it is what you expect
class(ff)
length(ff)
# 0!!!


ff = list.files("~/Data/NASAWeather", pattern = "\\.txt", full = TRUE)
class(ff)
length(ff)
head(ff)
tail(ff)

txt = lapply(ff, readLines)
names(txt) = ff


# Check line 5 in each file
l5 = sapply(txt, `[`, 5)
head(l5)
table(grepl("TIME", l5))

