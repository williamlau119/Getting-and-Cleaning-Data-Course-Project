#Introduction#
This Codebook describes the data used in this project, as well as the processing required to create the resulting tidy data set.

#Overview# 
With the incrreasing interest in wearable computing, data science is emerging in this     field. For this exercise, tidying data set from experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were collected from accelerometer and gyroscope from the Samsung Galaxy S II. 

#Description of script#
The run_analysis.R script performs preparation and tidying of dataset as required in the course assignment:

#Step 1 : Load the library and Downloading the data#
 - Load the library - "dplyr"
 - filename <- "Week4Assignment.zip"
 - fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Step 2: Unzip the downloaded file and assign data frame to variables#
< variable <- unzipped file >
 - features <- features.txt
 - subject_test <- subject_test.txt
 - x_test <- X_test.txt
 - y_test <- y_test.txt
 - subject_train <- subject_train.txt
 - x_train <- X_train.txt
 - y_train <- y_train.txt
 - activity_labels <- activity_labels.txt

#Step 3: Merge the training and the test sets to create one data set#
 - merge x_train and x_test and assign it to variable X using rbind
 - merge y_train and y_test and assign it to variable Y using rbind
 - merge subject_test and subject_train and assign it to Subject using rbind
 - Merge all data; i.e. Merge Subject, Y and X and assign it to MergedDataSet using cbind

#Step 4: Extracts only the measurements on the mean and standard deviation for each measurement#
  - Select only "subject" and "code" columns from subsetting MergedDataSet. 
  - Perform function to extract the mean and standard deviation of each measurement. 
  
#Step 5: Uses descriptive activity names to name the activities in the data set; using activity_labels#
  - Read activity_labels.txt and replace every code numbers with the corresponding activities (6 activities)
  
#Step 6: Appropriately labels the data set with descriptive variable names.# 
The following are the renaming correspondence:
  - All "Acc" will be renamed to "Accelerometer"
  - All "Gyro" will be renamed to "Gyroscope"
  - All "BodyBody" will be renamed to "Body"
  - All "Mag" will be renamed to  "Magnitude"
  - All starting character t in column’s name replaced by Time
  - All starting character f in column’s name replaced by Frequency
  - Column 2 rename to "Activity"
  - Column 1 rename to " Subject"
  - All "tBody" will be renamed to "TimeBody"
  - All "angle" will be renamed to "Angle"
  - All "gravity" will be renamed to "Gravity"
  
#Step 7: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject#
  - Data3 is created by aggregating ProcessedDataSet and taking mean of each variable     for each activities an each subject after     groupping them by Subject and Activity.
   - Data3.txt is exported using write.table() with row.name=False
  
  -end-
