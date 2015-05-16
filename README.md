# Coursera: Getting and Cleaning Data

[This Coursera course](https://class.coursera.org/getdata-014) is the third part in the Data Science Specialisation.

The script run_analysis.R includes a function that merges, tidies and summarises data collected from the accelerometers from the Samsung Galaxy S smartphone for 30 different people. 

The data comes from here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The function downloads a zip file and takes out the relevant data from the test and training datasets.

Then it merges these data to create one large dataset which can then be analysed.

It also tidies up the data by attaching variable names and keeping only data on the variables which calculate mean and standard deviation.

Then a text file is created which finds the average value for each variable for each subject in each different activity state.
