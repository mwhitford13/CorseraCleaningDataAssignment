#Author: Mickey Whitford
#Purpose: To clean and merge the data sets for the assignment
#Date: 2/11/2020


######################################################
##              1. IMPORT THE DATA                  ##
######################################################
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")



######################################################
##            2. Create Training Data               ##
######################################################

#Create Training Data
names(X_train) <- features$V2
y_train_full<-merge(x=y_train,y=activity_labels,by="V1",all.x=TRUE,all.y=FALSE)
names(y_train_full)<-c("Activity_ID","Activity_Desc")
names(subject_train)<-"Subj_ID"
training_data <- cbind(subject_train, y_train_full, X_train)


######################################################
##              3. Create Test Data                 ##
######################################################

names(X_test) <- features$V2
y_test_full<-merge(x=y_test,y=activity_labels,by="V1",all.x=TRUE,all.y=FALSE)
names(y_test_full)<-c("Activity_ID","Activity_Desc")
names(subject_test)<-"Subj_ID"
test_data <- cbind(subject_test, y_test_full, X_test)


######################################################
##          4. Remove unnecessary data              ##
######################################################

rm(activity_labels)
rm(subject_train)
rm(X_train)
rm(y_train)
rm(y_train_full)
rm(subject_test)
rm(X_test)
rm(y_test)
rm(y_test_full)
rm(features)



######################################################
##               5. Combine the data                ##
######################################################

#Merge the training and the test sets to create one data set
full_data <- rbind(training_data,test_data)


######################################################
##         6. Keep only necessary columns           ##
######################################################

#Identify columns  with mean/std. Backslashes are to get rid of variables that contain mean but don't represent means (i.e. meanfreq())
keep_cols <- grepl( "mean\\(\\)" , names(full_data)) | grepl("std\\(\\)", names(full_data))

#Identify first 3 columns
keep_cols[1:3] <- TRUE

#Keep only first 3 columns and mean/sd columns
full_data <- full_data[, keep_cols]

rm(training_data)
rm(test_data)
rm(keep_cols)

full_data <- full_data[-2]

#install.packages("reshape2")
#library(reshape2)


######################################################
##     7. Reshape data for final calculations       ##
######################################################

#Make data long
long_data <- melt(full_data, id=c("Subj_ID","Activity_Desc"))

#Get mean of each variable by subject and activity
tidy_data <- dcast(long_data, Subj_ID + Activity_Desc ~ variable, mean)


######################################################
##              8. Export data to csv               ##
######################################################

#Export Tidy Data
write.table(tidy_data, "tidy_data.csv",row.names=FALSE)
