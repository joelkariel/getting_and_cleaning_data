run_analysis<-function(){

      # Set working directory as root
      setwd("~/")
      
      # Check if 'zipdir' exists in working directory - if not, create it
      if(!file.exists("zipdir")){
       dir.create("zipdir") 
      }
      
      # Store zip location as object
      zip_location<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      
      # Download the zip into 'zipdir' if it isn't already there
      if(!file.exists("zipdir/data.zip")){
        download.file(zip_location, destfile="~/data.zip", method="curl")
      }
      
      # Unzip data.zip into zipdir
      if(!file.exists("zipdir/UCI HAR Dataset")){
        unzip("zipdir/data.zip", exdir="zipdir")
      }
      
      # Set working directory as UCI HAR Dataset
      setwd("zipdir/UCI HAR Dataset")
      
      # Read in test data
      subject_test<-read.table("test/subject_test.txt")
      x_test<-read.table("test/X_test.txt")
      y_test<-read.table("test/y_test.txt")
      
      # Read in train data
      subject_train<-read.table("train/subject_train.txt")
      x_train<-read.table("train/X_train.txt")
      y_train<-read.table("train/y_train.txt")
      
      # Read in lookup data and rename variables
      features<-read.table("features.txt")
      names(features)<-c("featureID","featureType")
      
      activity_labels<-read.table("activity_labels.txt")
      names(activity_labels)<-c("activityID","activityType")
      
      # Make object of featureIDs for those with 'mean' or 'std' in the respective featureType
      included_features<-grep("-mean\\(\\)|-std\\(\\)", features$featureType, ignore.case=TRUE)
      
      # Merge the subject test and train data
      subject<-rbind(subject_train, subject_test)
      names(subject)<-c("subjectID")
      
      # Merge the x test and train data
      x<-rbind(x_train, x_test)
      feature_vector<-as.vector(features$featureType) # Make a vector of features to place as variable names in x
      
      # Clean up feature names
      feature_vector<-gsub("\\(|\\)","",feature_vector) # Remove brackets from feature names
      feature_vector<-gsub("^t","time-",feature_vector)
      feature_vector<-gsub("^f","freq-",feature_vector)
      feature_vector<-gsub("\\-BodyBody","-Body",feature_vector)
      
      # Make features the column names for x
      names(x)<-c(feature_vector) 
      x<-x[, included_features] # This keeps only columns in included_features
      
      # Merge the y test and train data
      y<-rbind(y_train, y_test)
      y$order<-1:nrow(y) # Create 'order' variable to re-order this df later on
      names(y)<-c("activityID","order")
      y<-merge(y, activity_labels, by="activityID") # Merge with activity labels
      y<-y[order(y$order),] # Use 'order' varibale to re-order y
      y<-y$activityType # Only keep activityType variable
      
      # Merge three dataframes
      data<-cbind(y,x,subject)
      colnames(data)[1]<-"activityType" # Rename activityType variable
      
      # Find mean of each variable for each subjectID for each activityType
      data<-aggregate(data, by=list(subject = data$subjectID, activity = data$activityType), FUN=mean, na.rm=TRUE)
      drops<-(c("subjectID","activityType"))
      data<-data[,!(names(data) %in% drops)]
      
      # Set working directory as root
      setwd("~/")
      
      # Save as a txt file
      write.table(data, file="tidyData.txt",row.names=FALSE)
}

run_analysis()
