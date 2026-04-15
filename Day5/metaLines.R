ll = readLines("offline")

# Index in ll of the lines which start with #
i = grep("^#", ll)

# That contain # anywhere in the line, not having to start with #
j = grep("#", ll)

identical(i, j)
# So in this case, all lines that contain # also start with #.

# drop these lines
ll2 = ll[ - i]
# or 
ll2 = ll[ !grepl("^#", ll) ]


# start with # timestamp

i = grep("# timestamp", ll)

# distribution of the number of lines between successive # timestamp lines

table(diff(i))
#  All have 114 lines
#  3  # lines at the top of each and one at the end

# e.g.,
ll[c(1:3, 114)]

# [1] "# timestamp=2006-02-11 08:31:58"                         "# usec=250"                                             
# [3] "# minReadings=110"                                       "# Trace finished: maximum number of polls (110) reached"
