function[] = draw_knn(train_data, train_label, k)
%[D,I] = pdist2(train_data,train_label,'Smallest',k)
[trow, tcol]=size(train_data);
%[nrow, ncol]=size(new_data);

for i=0:1/100:1
    for j=0:1/100:1
        point=[i,j];
        %plot(point)
        for num=1:trow
            distance(num,1)=norm(point-train_data(num,:));
        end
       
        [sortedValues,sortIndex] = sort(distance,'ascend')
        MinIndex(1:k) = sortIndex(1:k); %get index of the smallest k distances for new_data entry i
        
        plus=0;
        minus=0;
        for m=1:k %count the frequency of labels among the k smallest distances
            index=MinIndex(m);
            label=train_label(index);
            if(label==1)
                plus=plus+1;
            else
                minus=minus+1;
            end
        end
        if(plus>minus)
            plot(i,j, 'r*');
            hold on;            
        else
            plot(i,j, 'o');
            hold on;     
        end
        
    end
end
