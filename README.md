This project is created to analyze the data from UCI HAR Dataset.

The following files from the initial dataset is used:
1. features.txt
2. train/X_train.txt
3. test/X_test.txt
4. train/subject_train.txt
5. test/subject_test.txt
6. train/y_train.txt
7. test/y_test.txt

The script performs the following:
1. Downloads the features to be measured.
2. Loads data set for train and test sets.
3. These loaded data sets are then merged to form a complete data set
4. The measurements on mean and standard deviations are extracted as per the criteria.
5. To provide descriptive values for activity labels a new variable "activitylabel" is added to dataset, that is a factor variable with levels mentioned in file activity_labels.txt
6. Created a melted data frame using activity labels and mean is calculated.
7. A tidy data frame is created and written to text file.
