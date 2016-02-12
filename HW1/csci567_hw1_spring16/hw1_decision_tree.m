[train_data,train_label] = preparation('hw1_train.data');
[new_data,new_label] = preparation('hw1_test.data');
[newt_data,newt_label] = preparation('hw1_valid.data');

for i = [1:10]
    [accuracy] = decision_tree(train_data, train_label, new_data, new_label)
  
end
