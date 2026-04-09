# Approach


## Top-level 

+ Read each file
+ Check 
  + latitude & longitude pairs are the same for all files
  + the set of dates are the same for all variables
+ Combine the data.frames for each variable into a single data.frame
  + lat, long, date, var1, ..., var7, filename



## Read Each File

### Result
  + data.frame 
    + not 24x24 but 5 or 6 columns and 24x24 = 576 rows
    + latitude
	+ longitude
	+ date
	+ the 24x24 values in a single column
	+ filename
    + variable name?

### Steps
+ get date/TIME
   + Convert to a Date object
+ get longitude
+ get latitude
+ get values
+ assemble into data.frame
   + unlist/unravel the 24x24 values
   + match latitude by repeating appropriately
   + match longitude by repeating appropriately   
   + repeat date, filename - invariant within file.
+ discard grid numbers (e.g., 27-50, 50-28)


#### Step 1

+ Could assume TIME is always on the 5 line.
   + Either check this is true, or
   + Find the line with TIME in it
+ 

# Validation

+ Check NAs
+ Check distributions of each variable
+ Check temperature by month
+ Check cloud low by suface temperature
