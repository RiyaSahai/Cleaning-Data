#part1

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./a1")
unzip("a1")
 xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
 xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
 ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
 ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
 features <- read.table("./UCI HAR Dataset/features.txt")
 activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
 subte <- read.table("./UCI HAR Dataset/test/subject_test.txt")
 subtr <- read.table("./UCI HAR Dataset/train/subject_train.txt")
 
 
 colnames(xtest) <- features[ ,2]
 colnames(xtrain) <- features[ ,2]
 ans <- rbind(xtrain, xtest)
 subf <- rbind(subte, subtr)
 colnames(subf) <- "id"
 yf <- rbind(ytest, ytrain)
 ansf <- cbind(ans, yf, subf)
 
 colnames(activities) <- "id"
 
 df<-merge(ansf, activities,by.x = 'V1',by.y = 'id')
 colnames(df)[564] <- "activity"
 
 #part2
 
x <- grep("mean", colnames(df))
y <- grep("std", colnames(df))


x1 <- as.data.frame(x)
y1 <- as.data.frame(y)
colnames(x1) <- "index"
colnames(y1) <- "index"
z <- rbind(x1,y1)                       #now z has all indexes that need to be extracted
final <- df[ ,z[ ,1]]                   #this has all mean and standard deviation observations
cbind(final, df$id, df$activity)
final

 #part 3

colnames(final) <- gsub("^t", "time", colnames(final))
colnames(final) <- gsub("^f", "frequency", colnames(final))
colnames(final) <- gsub("Acc", "Accelerometer", colnames(final))
colnames(final) <- gsub("Gyro", "Gyroscope", colnames(final))
colnames(final) <- gsub("Mag", "Magnitude", colnames(final))

  #part 5

data <- aggregate(.~id + activity, df, mean)
write.table(data, file = "tidydata.txt",row.name=FALSE)


 
