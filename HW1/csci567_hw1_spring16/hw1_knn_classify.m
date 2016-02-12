[trainData,trainLabel] = preparation('hw1_train.data');
[testData,testLabel] = preparation('hw1_test.data');
[validData,validLabel] = preparation('hw1_validation.data');

for k = [1:2:15]
    [new_accu, train_accu] = knn_classify(trainData, trainLabel, testData, testLabel, k)
    [new_accu, train_accu] = knn_classify(trainData, trainLabel, validData, validLabel, k)
end
