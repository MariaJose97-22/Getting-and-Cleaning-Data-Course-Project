
##First, the information needed must be read from "the UCI HAR Dataset file"##
##Reading Subject data ##
subject_test<-read.table("./Final Assignment/UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("./Final Assignment/UCI HAR Dataset/train/subject_train.txt")
##Reading  test and train data##
X_train<-read.table("./Final Assignment/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("./Final Assignment/UCI HAR Dataset/train/Y_train.txt")
X_test<-read.table("./Final Assignment/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./Final Assignment/UCI HAR Dataset/test/Y_test.txt")

##Merging all subject data##
subject_data<-rbind(subject_test,subject_train)
##Merging all activity data##
activity_data<-rbind(Y_test,Y_train)
##Merging all features data##
features_data<-rbind(X_test,X_train)
##The names of the different data frames must be more ilustrative, so we change them ##
names(subject_data)<-c("Subject")
names(activity_data)<-c("Activity")
##However, there is a .txt file that contains the real names of the different features, so we change them##
features_names<-read.table("./Final Assignment/UCI HAR Dataset/features.txt", header = FALSE)
names(features_data)<- features_names$V2

##Here we unite the subject data with the activity and features data to create one big data set called "merge_data"##
data<- cbind(subject_data,activity_data)
names(data)<- c("Subject","Activity")
merge_data<- cbind(data,features_data)

##We need to extract only the mean and standard deviation from "merge_data" into a new data set called "Data"##
##First we must look out for "mean" and "std" in the data set##
extract_info<-features_data[grep("mean\\(\\)|std\\(\\)", features_names$V2)]
## Then create "Data" with the subject and activity information as well## 
Data<-cbind(extract_info,merge_data$Subject,merge_data$Activity)

library(dplyr)

names(Data)[names(Data) == "merge_data$Subject"] <- "Subject"
names(Data)[names(Data) == "merge_data$Activity"] <- "Activity"

## To use more descriptive activity names on the data set , we first read from "the UCI HAR Dataset file" the activity labels##
activity_labels<-read.table("./Final Assignment/UCI HAR Dataset/activity_labels.txt",header = FALSE)
##Then we assign every value a activity label##
Data$Activity[Data$Activity=="1"]<-"WALKING"
Data$Activity[Data$Activity=="2"]<-"WALKING_UPSTAIRS"
Data$Activity[Data$Activity=="3"]<-"WALKING_DOWNSTAIRS"
Data$Activity[Data$Activity=="4"]<-"SITTING"
Data$Activity[Data$Activity=="5"]<-"STANDING"
Data$Activity[Data$Activity=="6"]<-"LAYING"

## features_info provides the meaning of the variable names but we must made the data set "Data" more readible to the public by changing the names of the variables using the gsub replacement function##
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

##Now , we are creating a new tidy data set with the average of each variable for each activity and subject##
library(dplyr)
Grouped<-group_by(Data,Subject,Activity)
Data2<-summarise_all(Grouped,funs(mean))
##Finally, we made the data set created ("Data2") a .txt document to submit the assignment##
write.table(Data2,"./Final Assignment/Final_Data.txt", row.name=FALSE)

