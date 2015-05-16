# Set working directory as root
setwd("~/")

# Check if 'zipdir' exists in working directory - if not, create it
if(!file.exists("zipdir")){
 dir.create("zipdir") 
}

# Store zip location in object
zip_location<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the zip into 'zipdir' if it isn't already there
if(!file.exists("zipdir/data.zip")){
  download.file(zip_location, destfile="zipdir/data.zip", method="curl")
}

# Unzip data.zip into zipdir
if(!file.exists("zipdir/UCI HAR Dataset")){
  unzip("zipdir/data.zip", exdir="zipdir")
}

# Set working directory as UCI HAR Dataset
setwd("zipdir/UCI HAR Dataset")

# Read in three files for 'test' and merge
subject_test<-read.csv("test/subject_test.txt")
x_test<-read.csv("test/X_test.txt")
y_test<-read.csv("test/y_test.txt")
View(subject_test)
