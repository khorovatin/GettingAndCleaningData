# Getting And Cleaning Data Course Project
My repository for the course project for the "[Getting and Cleaning Data](https://www.coursera.org/course/getdata)" course in Coursera's [Data Science](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripTop) specialization.

## Project Parameters
From the project description on Coursera: "The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis."

The data set used is the "Human Activity Recognition Using Smartphones Dataset", version 1.0, available from the following website:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The dataset has been extracted from a Zip file provided by the course authors and downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and is included in this repository in the `UCI HAR Dataset` folder.

## Steps to Reproduce
1. Download or clone this repository to your local machine (remember to download the dataset folder as well).
2. In R, use the `setwd(dir)` command to set the working directory to the directory you downloaded or cloned the repository to.
3. Run the `run_analysis.R` script by using the R command `source(run_analysis.R)`.

## Output
The `run_analysis.R` script writes its output to the file `study_output.txt`, a tab separated text file containing wide tidy data. Please refer to the file `CodeBook.md` for a description of the data in the output.
