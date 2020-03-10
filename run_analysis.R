# Loading libraries
library(dplyr)

# Download the dataset
filename <- "Week4Assignment.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists(filename)){
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename, method="curl")
}

# Unzip the file
unzip(filename)

# Assigning data frame variable from unzipped files
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Check data frames
View(features)
View(subject_test)
View(subject_train)
View(x_test)
View(y_train)
View(y_test)
View(x_train)

# Step 1: Merge the test and train dataset

# Merge X datasets
X <- rbind(x_train, x_test)

# Merge Y datasets
Y <- rbind(y_train, y_test)

# View Merged rows of X and Y
View(X)
View(Y)

# Merge Subject datasets
Subject <- rbind(subject_test, subject_train)
View(Subject)

# Merge all into one data set
MergedDataSet <- cbind(Subject, Y, X)

# View Merged Data set
MergedDataSet
View(MergedDataSet)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
ProcessedDataSet <- MergedDataSet %>% select(subject, code, contains("mean"), contains("std"))
View(ProcessedDataSet)

# Step 3: Uses descriptive activity names to name the activities in the data set; using activity_labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)
View(activityLabels)
ProcessedDataSet$code <- activityLabels[ProcessedDataSet$code, 2]
View(ProcessedDataSet)
names(ProcessedDataSet)[2] = "activity"
View(ProcessedDataSet)

# Step 4: Appropriately labels the data set with descriptive variable names.
names(ProcessedDataSet)<-gsub("Acc", "Accelerometer", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("Gyro", "Gyroscope", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("BodyBody", "Body", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("Mag", "Magnitude", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("^f", "Frequency", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("^t", "Time", names(ProcessedDataSet))
names(ProcessedDataSet)[2] = "Activity"
names(ProcessedDataSet)[1] = "Subject"
names(ProcessedDataSet)<-gsub("tBody", "TimeBody", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("angle", "Angle", names(ProcessedDataSet))
names(ProcessedDataSet)<-gsub("gravity", "Gravity", names(ProcessedDataSet))

#check variable names
names(ProcessedDataSet)
View(ProcessedDataSet)

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Data3<-aggregate(. ~Subject + Activity, ProcessedDataSet, mean)
View(Data3)
Data3 <- Data3[order(Data3$Subject,Data3$Activity),]
write.table(Data3, file = "Data3.txt",row.name=FALSE)

# Check Data
str(Data3)
Data3

#Save history
savehistory("C:/Users/edwinlau/Desktop/Run.analysisTest.txt")
