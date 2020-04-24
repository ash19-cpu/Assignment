library(reshape2)

filename <- "getdata_dataset.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract the data on mean and standard deviation
feat_meansd <- grep(".*mean.*|.*std.*", features[,2])
feat_meansd.names <- features[feat_meansd,2]
feat_meansd.names = gsub('-mean', 'Mean', feat_meansd.names)
feat_meansd.names = gsub('-std', 'Std', feat_meansd.names)
feat_meansd.names <- gsub('[-()]', '', feat_meansd.names)


# Loading the train and test datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[feat_meansd]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[feat_meansd]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merging the datasets
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", feat_meansd.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)