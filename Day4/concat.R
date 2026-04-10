
# Bad. No preallocation
N = 100000
x = c()
for(i in 1:N)
    x[i] = i



# Preallocate
N = 100000
x = numeric(N)
for(i in 1:N)
    x[i] = i



# Suppose a, b, and c are data.frames with the same column names.

z = rbind(a, b, c)

# Inefficient
z = a
for(x in list(b, c))
     z = rbind(z, x)

