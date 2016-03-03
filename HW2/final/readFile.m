function [trainingLabels, trainingFeatures, testLabels, testFeatures] = readFile

%spambase.data - input data file from https://archive.ics.uci.edu/ml/machine-learning-databases/spambase
filename='spambase.data';
delimiterIn = ',';
A = importdata(filename,delimiterIn);


%number of rows
rows = length(A);

%number of columns
columns = length(A(1,:));

%input data read from the data file
databody = A(:,1:columns);

%randomize the data into rows
databody = databody(randperm(rows),:);

%divide the set into training and test parts
setsize = int32(rows/2);

%training set
training_set = databody(1:setsize,:);
trainingLabels = training_set(:,columns);
training_set(:,columns) = [];
trainingFeatures = training_set(:,1:columns-1);

%test set
test_set = databody((setsize+1):rows,:);
testLabels = test_set(:,columns);
test_set(:,columns) = [];
testFeatures = test_set(:,1:columns-1);





