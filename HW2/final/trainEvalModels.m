function trainEvalModels()

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
    
    piVal = [pi1,pi2,pi3];
    
    model1 = struct('pi',piVal,'m1',mean1,'m2',mean2,'m3',mean3,'S1',cov1,'S2',cov2,'S3',cov3);
    
    count1 = calculateAccuracy(testSet1,1,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count2 = calculateAccuracy(testSet2,2,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count3 = calculateAccuracy(testSet3,3,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    
    accuracy1 = (count1+count2+count3)/8750*100;
    
    EqualCov = ((length(set1)*cov1) + (length(set2)*cov2) + (length(set3)*cov3))/(length(set1)+length(set2)+length(set3))
    
    model2 = struct('pi',piVal,'m1',mean1,'m2',mean2,'m3',mean3,'S',EqualCov);
        
    count1 = calculateAccuracy(testSet1,1,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    count2 = calculateAccuracy(testSet2,2,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    count3 = calculateAccuracy(testSet3,3,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    
    accuracy2 = (count1+count2+count3)/8750*100
    

    te1 = ones(1000,1);
    te2 = ones(1000,1)*2;
    te3 = ones(1500,1)*3;
    x = vertcat(set1,set2,set3);
    y=vertcat(te1,te2,te3);
    
    b = mnrfit(x,y);
    
    value1 = getmnrval(testSet1,1,b);
    value2 = getmnrval(testSet2,2,b);
    value3 = getmnrval(testSet3,3,b);
    
    accurancy3 = (value1+value2+value3)/8750*100
    
    model3 = struct('w',[b zeros(size(b,1),1)]);
    
    plotBoarder(model1, model2, model3, dataTe);
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
    

function value = getmnrval(testSet,dataSet,mnrfitval)
    
value = 0;
for k = 1:length(testSet)
    val = mnrval(mnrfitval,testSet(k,:));
    [a b]=sort(val);
    
    if(b(3)==dataSet)
        value = value+1;
    end
end



end
    
    
    
    %% MLE learning of model2, Gaussian Discriminative Analysis II
    % your code here
    
    %% learning of model3, the MLR classifeir
    % your code here
    
    %% visualize and compare learned models
    % plotBoarder(model1, model2, model3, dataTe)
