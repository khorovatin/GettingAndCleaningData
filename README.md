# Getting And Cleaning Data Course Project
My repository for the course project for the "[Getting and Cleaning Data](https://www.coursera.org/course/getdata)" course in Coursera's [Data Science](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripTop) specialization.

## Project Parameters
From the project description on Coursera: "The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis."

The data set used is the "Human Activity Recognition Using Smartphones Dataset", version 1.0, available from the following website:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The dataset has been extracted from a Zip file provided by the course authors, which can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The extracted files are included in this repository in the `UCI HAR Dataset` folder.

## Steps to Reproduce
1. Download or clone this repository to your local machine (remember to download the dataset folder as well).
2. In R, use the `setwd(dir)` command to set the working directory to point to your local download or clone of the repository.
3. Run the `run_analysis.R` script by using the R command `source(run_analysis.R)`.

## Output
The `run_analysis.R` script writes its output to the file `study_output.txt`, a tab separated text file containing wide tidy data. Please refer to the file `CodeBook.md` for a description of the data in the output.
The output data can be read back into R with the command:
```R
data <- read.table("study_output.txt", header=TRUE)
view(data)
```

## Script Description
The script performs the following work on the input data set:

1. Load the activity name labels from `activity_labels.txt` and clean them up by removing underscores and capitalizing each word in the label. This data is held in the `activity.labels` data frame.
2. Load the measurement names (called "features" in the data set) from `features.txt` and make them into unique, R-compatible names. This data is held in the `x.colnames` character vector.
3. Load the Training set data from the file `x_train.txt` and name the columns using the names in the `x.colname` vector. This data is held in the `x.train` data frame.
4. Load the Training set data labels from the file `y_train.txt` and store in the data frame `y.train`.
5. Load the Training set data subjects from the file `subject_train.txt`, storing the data in the data frame `subject.train`.
6. Load the Test set data from the file `x_test.txt` and name the columns using the names in the `x.colname` vector. The resulting data is held in the `x.test` data frame.
7. Load the Test set data labels from the file `y_test.txt` and store in the data frame `y.test`.
8. Load the Test set data subjects from the file `subject_test.txt`, storing the data in the data frame `subject.test`.
9. Use `rbind` to combine the Test and Training data subjects by rows into one data frame named `subject`.
10. Use `rbind` to combine the Test and Training data by rows into one data frame named `x`.
11. Use `rbind` to combine the Test and Training data labels by rows into one data frame named `y`.
12. Update the "activity" column of `y` to a more understandable value by using `mapvalues` to substitute the English activity names loaded in step 1. above in place of the numeric codes in the original data.
13. Use `cbind` to create a new data frame called `study` by combining the activity data from `y`, the subject data from `subject` and all the columns from `x` that have column names containing the equivalent of "mean()" or "std()", by column. (Note that the code matches ".mean.." and ".std.." rather than the original strings because step 2 above replaced all characters that are not compatible with R column names with periods (".")). The project description on the Coursera website asks that we include only "mean" and "std" data in our analysis, which I interpreted as meaning data in columns containing the "mean()" or "std()" strings in their names, but **not** column names containing the word "Mean" without trailing parentheses. 
14. Group the data by reshaping the data into a narrow data frame using the `activity` and `subject` columns as identifiers, and grouping on the `activity`, `subject`, and `variable` columns. Store this in a new data frame named `studygrouped`.
15. Summarize the data in `studygrouped`, taking the mean (average) of the grouped `value` column. Store this in a new data frame named `studymean`.
16. Transform the measurement (feature) names in the `variable` column of the `studymean` data fram into more easily understood names by replacing cryptic abbreviations with their full-length English equivalents (i.e, change "t" to "Time", "f" to "Frequency", "Acc" to "Acceleration", "Gyro" to "Gyroscope", "Mag" to "Magnitude", ".mean.." to "Mean", and ".std.." to "StandardDeviation". Finally remove any remaining dots (".") from the name.
17. Reshapre the data from `studymean` into a wide tidy data frame called `studyoutput`.
18. Write `studyoutput` to a tab-separated file named `study_output.txt`, omitting row numbers as requested in the project description on Coursera.
