% [trainData,trainLabel] = preparation('hw1_train.data');
% [testData,testLabel] = preparation('hw1_test.data');
% [validData,validLabel] = preparation('hw1_validation.data');
% 
% for i = [1:10]
%     [new_accu_1, train_accu_1, new_accu_2, train_accu_2] = decision_tree(trainData, trainLabel, testData, testLabel, i)
%    
% end

function[accuracy]= decision_tree(traindata, trainlab, newdata,newlab)


for num=1:10
dt=ClassificationTree.fit(traindata,trainlab, 'MinLeaf', num, 'Prune','off','SplitCriterion','deviance')
%view(dt,'Mode','Graph')
[predict_label] = predict(dt,newdata)


diff=predict_label-newlab;
predict_size=size(predict_label,1);

error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
accuracy(num)=1-error/predict_size;
end