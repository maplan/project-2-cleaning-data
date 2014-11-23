Codebook
========
Getting and Cleaning the Data
-----------------------------

To execute the run_analysis.R the “data.table” and the “reshape2” packages ara needed.

Set working directory to source file.

The run_analysis.R performs according to the following steps.

  1. Create a data directory
  2. Donwload and unzip de UCI repository into the data directory.
  3. Merges the training and the test sets to create one data set.
    a. Read the activity_labels.txt to know the descriptive activity names
    b. Read the”features.txt”, to read the list of features’ name
    c. Prepare the test set
      i. Read the “subject_test”, “X_test”, “y_test”
      ii. Put names in variables X_test
      iii. Subset X_test  by names which include target strings including “mean” or “std”.
      iv. Read “y_test” and add descriptive activity names to the data set
      v. Put names to columns of y_test.
      vi. Add names to columns of subject_test
    d. Prepare train set following the same steps as above.
    e. Collect test_data combining “subject_test”, “y_test” and “X_test”
    f. Collect train_data combining “subject_train”, “y_train” and “X_train”
    g. Combine “test_set” and “train_set” to data_set
  4. Create an independent tidy data set with the average of each variable for each activity and each subject
    a. Melt the merged data set with the id of “subject” and “activity”
    b. Then “dcast()“ the melted data where as calculating the mean of each variables in the data set
  5. Write the latest data set to a txt file called "clean_data.txt” 

