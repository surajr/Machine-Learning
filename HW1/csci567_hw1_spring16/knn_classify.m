function [new_accu, train_accu] = knn_classify(trainData, trainLabel, newData, newLabel, k)

[rows, columns]=size(trainData);
[rowData, colData]=size(newData);

for i = 1:rowData
    for j=1:rows
        distance(i,j)=norm(newData(i,:)-trainData(j,:));
    end
end

for i = 1:rows
    for j=1:rows
        if(i==j)
            distance_calculate(i,j)=1000000000000000;
        else
            distance_calculate(i,j)=norm(trainData(i,:)-trainData(j,:));
        end
    end
end


for i= 1:rowData
    label_count(1:1,1:100)=0.0;% related to num of features
    [sortedValues,sortIndex] = sort(distance(i,:),'ascend');
    MinIndex(1:k) = sortIndex(1:k); %get index of the smallest k distances for newData entry i 
        
    for m=1:k %count the frequency of labels among the k smallest distances
        index=MinIndex(m);
        label=trainLabel(index);         
        label_count(label)=label_count(label)+1;
    end    
    [L, I]=max(label_count);
    predict_label(i)=I;
    
end


diff=predict_label-newLabel';
predict_size=size(predict_label,2);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
new_accu=1-error/predict_size;


%for train accuracy
prodict_label=0;
for i= 1:rows
    label_count(1:1,1:100)=0.0;% related to num of features
    [sortedValues,sortIndex] = sort(distance_calculate(i,:),'ascend');
    MinIndex(1:k) = sortIndex(1:k); %get index of the smallest k distances for newData entry i 
        
    for m=1:k %count the frequency of labels among the k smallest distances
        index=MinIndex(m);
        label=trainLabel(index);         
        label_count(label)=label_count(label)+1;
    end    
    [L, I]=max(label_count);
    predict_label(i)=I;
    
end


diff=predict_label-trainLabel';
predict_size=size(predict_label,2);
%disp(predict_size);
error=0;
for i=1:predict_size
    if(diff(i)~=0)
        error=error+1;
    end
end
train_accu=1-error/predict_size;





