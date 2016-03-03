function train

    load toyGMM.mat

    %% MLE learning of model1, Gaussian Discriminative Analysis I
    
    set1 = dataTr.x1;
    set2 = dataTr.x2;
    set3 = dataTr.x3;
    
    testSet1 = dataTe.x1;
    testSet2 = dataTe.x2;
    testSet3 = dataTe.x3;
    
    mean1 = mean(set1);
    mean2 = mean(set2);
    mean3 = mean(set3);
    
    cov1 = cov(set1);
    cov2 = cov(set2);
    cov3 = cov(set3);
    
    pi1 = length(set1)/(length(set1)+length(set2)+length(set3));
    pi2 = length(set2)/(length(set1)+length(set2)+length(set3));
    pi3 = length(set3)/(length(set1)+length(set2)+length(set3));
    
    
    count1 = calculateAccuracy(testSet1,1,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count2 = calculateAccuracy(testSet2,2,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count3 = calculateAccuracy(testSet3,3,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    
    accuracy = (count1+count2+count3)/8750*100;
    
    trainReg();
    
end



function count = calculateAccuracy(testSet,dataSet,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3)
    count = 0;
    for i = 1:length(testSet)
        res(i,1) = pi1*(1/(2*pi*det(cov1)))*exp(-0.5*(testSet(i,:)'-mean1')'*(inv(cov1))*(testSet(i,:)'-mean1'));
        res(i,2) = pi2*(1/(2*pi*det(cov2)))*exp(-0.5*(testSet(i,:)'-mean2')'*(inv(cov2))*(testSet(i,:)'-mean2'));
        res(i,3) = pi3*(1/(2*pi*det(cov3)))*exp(-0.5*(testSet(i,:)'-mean3')'*(inv(cov3))*(testSet(i,:)'-mean3'));
        
        [a b] = sort(res(i,:));
        
        if (b(3)==dataSet)
            count=count+1;
        end
        
    end
end




   