
# For the offline date, look for # timestamp to start each group
# See metaLines.R also.

# Concept is
# have a character vector of n elements
# 
# #
#
#

ll = readLines("offline")
w = grepl("# timestamp", ll)
g = cumsum(w)
table(g)
split(ll, g)
