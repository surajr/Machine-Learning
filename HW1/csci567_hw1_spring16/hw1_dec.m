[trainData,trainLabel] = preparation('hw1_train.data');
[testData,testLabel] = preparation('hw1_test.data');
[validData,validLabel] = preparation('hw1_validation.data');

for i = [1:10]
    [new_accu_1] = decision_tree(trainData, trainLabel, testData, testLabel)
end