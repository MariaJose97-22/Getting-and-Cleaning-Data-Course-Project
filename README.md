# Getting-and-Cleaning-Data-Course-Project
Final Assignment from the course "Getting and Cleaning Data"

The data was provided "Human Activity Recognition Using Smartphones Dataset" can be find here:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
I create a folder called "Final Assignment" to download the zip file and start working.
There was a folder called "UCI HAR Dataset" in which was all the data, two folders called "test" and "train" and three .txt documents:
1.activity_labels:Contains the name and value for each activity.
2.features:Contains the features selected.
3.features_info:Contains the description of each feature.

# How the script works?

First its necessary to read  "subject_test.txt" on the "test" file and go on and do the same thing with "subject_train.txt" on the "train" file. 
Don't forget to give them proper names, in my case "subject_test" and "subject_train".
Then we read "X_train.txt" and "Y_train.txt" on the "train" file and of course we also read "X_test.txt" and "Y_test.txt" on the "test" file.

1) Merges the training and the test sets to create one data set:
Then we merge "subject_test" and "subject_train" into one data set  called "subject_data", "X_test.txt" and "X_train.txt" into one data set called "features_data" and finally "Y_test.txt" and "Y_train.txt" into one data set called "activity_data".
We need then to read "features.txt" , to extract the features names and assign them to the "features_data" data set.
Finally , we merge all together into a big data set called "merge_data".

2)Extracts only the measurements on the mean and standard deviation for each measurement:
First we must look out for "mean" and "std" in the data set "merge_data", so we use grep() on the features names and create a data set called "extract_info".
Then create a data set called "Data" with the subject and activity information as well (from the data set "merge_data").

3)Uses descriptive activity names to name the activities in the data set:
We open up "activity_labels.txt" and assign to each value in the activity variable the proper name, how is show here:
1  goes by WALKING
2  goes by WALKING_UPSTAIRS
3  goes by WALKING_DOWNSTAIRS
4  goes by SITTING
5  goes by STANDING
6  goes by LAYING

4)Appropriately labels the data set with descriptive variable names:
After reading the "features_info.txt" document ,using gsub() we change "t" with "Time", "f" with "Frequency","Acc" with "Accelerometer", "Gyro" with "Gyroscope","Mag" with "Magnitude" and "BodyBody" with "Body" in the data set called "Data".

5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
First we download the package dplyr and search for it's library.
Then using group_by(), which takes an existing table ("Subject" & "Activity") and converts it into a grouped table where operations are performed "by group".The result data is called "Grouped" and with it we apply summarise_all() with the mean function to create a new data set called "Data2".

# Code book
The data used was:
*subject - ID of participant
*activity - ID of activity type
*Mean and standart deviation for the following features:
  -tBodyAcc-XYZ
  -tGravityAcc-XYZ
  -tBodyAccJerk-XYZ
  -tBodyGyro-XYZ
  -tBodyGyroJerk-XYZ
  -tBodyAccMag
  -tGravityAccMag
  -tBodyAccJerkMag
  -tBodyGyroMag
  -tBodyGyroJerkMag
  -fBodyAcc-XYZ
  -fBodyAccJerk-XYZ
  -fBodyGyro-XYZ
  -fBodyAccMag
  -fBodyAccJerkMag
  -fBodyGyroMag
  -fBodyGyroJerkMag
The features come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
For the activity, as mention before, there is used the activity labels:
1 == WALKING
2 == WALKING_UPSTAIRS
3 == WALKING_DOWNSTAIRS
4 == SITTING
5 == STANDING
6 == LAYING




