# CorseraCleaningDataAssignment
How the Script works

The script is broken into a few sections:

1. This section is meant to read in all 8 data files
2. This section creates the training data by adding activity labels to IDs and then appending columns of all the training data sets
3. This section creates the trest data by adding activity labels to IDs and then appending columns of all the test data sets
4. This section removes unnecessary data from the environment
5. This section stacks the training and test data
6. This section removes all columns not relating to Std(), Mean(), Subject, or Activity
7. This section reshapes the data for the mean calculations. Fiest it makes the data long, then it computes averages along three variables
8. This section outputs the data to a csv file
