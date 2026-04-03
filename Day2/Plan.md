+ Data for 
   + 72 months 
   + 7 variables
      + temperature, 
	  + surface temperature
	  + ozone
	  + pressure
	  + cloud cover (%) - 
	     + cloudlow
		 + cloudmid 
		 + cloudhigh

+ Also elevation data

+ Explore a [few files](cloudhigh1.txt) to identify hopefully common structure.

+ Write functions to read each file.
+ Then do this for each file and assemble into final dataset.

+ What should the data structure be for 
  + each file?
  + final result of all data?
     + What are the assumptions?
	 


+ For a single file, we want 
  + a data.frame
  + 1 row for each latitude and longitude pair
  + Columns
     + value for that location
     + the date/time
     + the name of the file
     + the variable name?
     + the latitude
  	 + the longitude
  + So converting the rectangle grid of values in cloudhigh1.txt into 24x24 vector of values
     + matching the latitude and longitude value for each value in the corresponding row of the data frame.

+ For a given variable, e.g., cloudhigh 1 to 72
   + combine the 72 data.frames by stacking them on top of each other (rbind)
   + columns are measuring the same variables - cloudhigh, latitude, longitude, date.


+ Final data
  + A column for each of the 7 variables
  + Latitude and longitude
  + data/time
  + file

+ This assumes that the rows match/"line up" across variables and across different dates.
   + We have to check this.
   + Can check now or after we read all of the files and have the separate datasets.
      + May not be in the same order for each variable?


