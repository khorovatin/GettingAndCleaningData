suppressMessages(library(plyr)); suppressMessages(library(dplyr))
library(reshape2)

# Load activity name labels
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", 
                         sep="", 
                         header=FALSE, 
                         stringsAsFactors=FALSE)

# Replace the underscores in the activity name labels and force to lower case
activity.labels$V2 <- tolower(gsub("_", " ", activity.labels$V2))

# Capitalize the first letter of each word in the activity name labels
activity.labels$V2 <- gsub("(^|\\s+)(\\w)","\\1\\U\\2", 
                           activity.labels$V2, perl=TRUE)

# Load measurement names (called "features" in the data set)
features <- read.table("./UCI HAR Dataset/features.txt", 
                  sep="", 
                  header=FALSE,
                  stringsAsFactors=FALSE)

# Coerce the measurement names into R-compatible, unique names
x.colnames <- make.names(features$V2, unique=TRUE)

# Load the Training set data
x.train <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                 sep="", 
                 header=FALSE)

# Set the Training set data column names
colnames(x.train) <- x.colnames

# Load the Training labels
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                 sep="", 
                 header=FALSE,
                 colClasses="factor",
                 col.names="activity")

# Load the subjects for the Training data
subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                       sep="",
                       header=FALSE,
                       colClasses="factor",
                       col.names="subject")

# Load the Test set data
x.test <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                sep="", 
                header=FALSE)

# Set the Test set data column names
colnames(x.test) <- x.colnames

# Load the Test labels
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                sep="", 
                header=FALSE,
                colClasses="factor",
                col.names="activity")

# Load the subjects for the Test data
subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                      sep="",
                      header=FALSE,
                      colClasses="factor",
                      col.names="subject")

# Combine the Test and Training subject data by rows
subject <- rbind(subject.test, subject.train)

# Combine the Test and Training set data by rows
x <- rbind(x.test, x.train)

# Combine the Test and Training labels by rows
y <- rbind(y.test, y.train)

# Update the "activity" column values to their equivalent text names
y$activity <- mapvalues(y$activity, from = activity.labels$V1, 
                        to = activity.labels$V2)

# Create a new data set combining activity, subject, and test data columns
#   that have names that include "mean.." or "std.." as part of their names
study <- cbind(y, 
               subject, 
               x[, grep("\\.mean\\.\\.|\\.std\\.\\.", names(x), perl=TRUE)])

# Group and summarize the data
studygrouped <- group_by(melt(study, id=c("activity", "subject")), 
                         activity, subject, variable)
studymean <- summarize(studygrouped, mean=mean(value))

# Turn the cryptic feature names into more understandable names
studymean$variable <- gsub("^t", "averageTime", studymean$variable)
studymean$variable <- gsub("^f", "averageFrequency", studymean$variable)
studymean$variable <- gsub("Acc", "Acceleration", studymean$variable)
studymean$variable <- gsub("Gyro", "Gyroscope", studymean$variable)
studymean$variable <- gsub("Mag", "Magnitude", studymean$variable)
studymean$variable <- gsub("\\.mean\\.\\.", "Mean", studymean$variable)
studymean$variable <- gsub("\\.std\\.\\.", "StandardDeviation", studymean$variable)
studymean$variable <- gsub("\\.", "", studymean$variable)

# Reshape the data into a wide tidy data set
studyoutput <- dcast(studymean, activity + subject ~ variable, value.var="mean")

# Write out study results
write.table(studyoutput, file="./study_output.txt", sep="\t", row.name=FALSE)
