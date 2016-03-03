
function [accuracy] = plotGraph
    load toyGMM.mat

    %% MLE learning of model1, Gaussian Discriminative Analysis I
    
    set1 = dataTr.x1;
    set2 = dataTr.x2;
    set3 = dataTr.x3;
    
    fprintf('Problem 4.2 D');
    mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 1% training data
    set1 = extract(0.3,dataTr.x1);
    set2 = extract(0.3,dataTr.x2);
    set3 = extract(0.4,dataTr.x3);
    
    accuracy = zeros(5,3);
    
    %fprintf('Problem 4.2 E  with 1% training Data \n ');
    accuracy(1,:) = mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 5% training data
    set1 = extract(1.5,dataTr.x1);
    set2 = extract(1.5,dataTr.x2);
    set3 = extract(2.0,dataTr.x3);
    
    %fprintf('Problem 4.2 E with 5% training Data\n');
    accuracy(2,:) = mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 10% training data
    set1 = extract(3,dataTr.x1);
    set2 = extract(3,dataTr.x2);
    set3 = extract(4,dataTr.x3);
    
    %fprintf('Problem 4.2 E with 10% training Data');
    accuracy(3,:) = mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 25% training data
    set1 = extract(7.5,dataTr.x1);
    set2 = extract(7.5,dataTr.x2);
    set3 = extract(10.0,dataTr.x3);
    
    %fprintf('Problem 4.2 E with 25% training Data');
    accuracy(4,:) = mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 50% training data
    set1 = extract(15,dataTr.x1);
    set2 = extract(15,dataTr.x2);
    set3 = extract(20,dataTr.x3);
    
    %fprintf('Problem 4.2 E with 50% training Data');
    accuracy(5,:) = mainEvalModel(set1, set2, set3);
    
    %hold on;
    %extracting the model with 100% training data
    set1 = extract(30,dataTr.x1);
    set2 = extract(30,dataTr.x2);
    set3 = extract(40,dataTr.x3);
    
    %fprintf('Problem 4.2 E with 100% training Data');
    accuracy(6,:) = mainEvalModel(set1, set2, set3);
    a=[1,5,10,25,50,100];
    a=a';
    
    plot(a,accuracy);title('4.1 E'),xlabel('% of training Samples'),ylabel('Accuracy');legend('Model1','Model2','Model3');
    
    
end

function [accuracy] = mainEvalModel(set1, set2, set3)
            
    load toyGMM.mat
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
    
    %piVal = [pi1,pi2,pi3];
    
    %model1 = struct('pi',piVal,'m1',mean1,'m2',mean2,'m3',mean3,'S1',cov1,'S2',cov2,'S3',cov3);
    
    count1 = calculateAccuracy(testSet1,1,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count2 = calculateAccuracy(testSet2,2,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    count3 = calculateAccuracy(testSet3,3,pi1,pi2,pi3,cov1,cov2,cov3,mean1,mean2,mean3);
    
    accuracy1 = (count1+count2+count3)/8750*100;
    
    EqualCov = ((length(set1)*cov1) + (length(set2)*cov2) + (length(set3)*cov3))/(length(set1)+length(set2)+length(set3));
    
    %model2 = struct('pi',piVal,'m1',mean1,'m2',mean2,'m3',mean3,'S',EqualCov);
        
    count1 = calculateAccuracy(testSet1,1,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    count2 = calculateAccuracy(testSet2,2,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    count3 = calculateAccuracy(testSet3,3,pi1,pi2,pi3,EqualCov,EqualCov,EqualCov,mean1,mean2,mean3);
    
    accuracy2 = (count1+count2+count3)/8750*100;
    

    te1 = ones(length(set1),1);
    te2 = ones(length(set2),1)*2;
    te3 = ones(length(set3),1)*3;
    x = vertcat(set1,set2,set3);
    y=vertcat(te1,te2,te3);
    
    b = mnrfit(x,y);
    
    value1 = getmnrval(testSet1,1,b);
    value2 = getmnrval(testSet2,2,b);
    value3 = getmnrval(testSet3,3,b);
    
    accuracy3 = (value1+value2+value3)/8750*100;
    
    %model3 = struct('w',[b zeros(size(b,1),1)]);
    
    %plotBoarder(model1, model2, model3, dataTe);
    
    accuracy = [accuracy1, accuracy2, accuracy3];

end

%for 1%, 5%,10% of data

function set = extract(percent, testSet)

rows = length(testSet);
rows = round((rows*percent)/100);
set = testSet(randperm(rows),:);

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