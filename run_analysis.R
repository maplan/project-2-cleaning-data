#download data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
unzip("getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",  exdir="./data")
#install data.table library
library(data.table)
#read activity labels factor 6 levels
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")[,2]
#read features factor 477 levels
features<-read.table("./data/UCI HAR Dataset/features.txt")[,2]
#test values
#read subject test 2947 obs
subject_test<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
#read X-test data 2947 obs 561 var
X_test<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
#put names in vars X_test
names(X_test)<-features
#subset X-test containing mean or std 79 vars
extract_features<-grepl("mean|std", features)
X_test<-X_test[, extract_features]
#read y_test data 2947 observations 1 var
y_test<-read.table("./data/UCI HAR Dataset/test/y_test.txt")
#add activity labels to y_test and name columns
y_test[,2]<-activity_labels[y_test[,1]]
names(y_test)<-c("Activity_ID", "Activity_label")
#add names to subject_test
names(subject_test)<-"subject"
#arrange train data in the same manner as test data
subject_train<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
names(X_train)<-features
X_train<-X_train[,extract_features]
y_train<-read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_train[,2]<-activity_labels[y_train[,1]]
names(y_train)<-c("Activity_ID", "Activity_label")
names(subject_train)<-"subject"
#collect test data
test_data<-cbind(subject_test, y_test, X_test)
#collect train data
train_data<-cbind(subject_train, y_train, X_train)
#all data in a table
data<-rbind(test_data, train_data)
#reshape data,select id.vars, measure.vars
library(reshape2)
id_column<-c("subject", "Activity_ID", "Activity_label")
data2<-melt(data, id=id_column)
clean_data = dcast(data2, subject + Activity_label ~ variable, mean)
write.table(clean_data, file = "./data/clean_data.txt")