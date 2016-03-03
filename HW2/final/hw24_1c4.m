
function hw24_1c4


    features=zeros(57,1);
    for i=1:57
        features(i,1)=i;
    end
    
    mutualInfo = mi;
    pcc=pcc1;
    

    subplot(1,2,1), plot(features,mutualInfo), title('Mutual Information'),xlabel('Features'),ylabel('Mutual Info');
    subplot(1,2,2), plot(features,pcc), title('PCC'),xlabel('Features'),ylabel('Pcc');
    
    [trainingLabels, trainingFeatures, testLabels, testFeatures] = readFile;


    [value posMI]=sort(mi,'descend');
    

    A=zeros(2301,19); B=zeros(2300,19);
    normalizedTrain=funNormalizeData(trainingFeatures);
    normalizedTest=funNormalizeData(testFeatures);

    %Normalizing the data
    for index=1:19
        A(:,index)=normalizedTrain(:,(posMI(index)));
    end

    %Calculating the estimates using standard Logistic regression model for
    %trainigLables
    estimates=glmfit(A,trainingLabels,'normal');

    %normalizing the test data
    for index=1:19
        B(:,index)=normalizedTest(:,posMI(index));
    end

    %calculating the glmval
    accuracyTestData=glmval(estimates,B,'identity');
    accuracyTrainData=glmval(estimates,A,'identity');
    accuracyTest=0; accuracyTrain=0;
    [accuracyTest, accuracyTrain] = findAccuracy(accuracyTestData, accuracyTrainData, testLabels, trainingLabels);

end

%finding the accuracy
function [accuracyTest, accuracyTrain] = findAccuracy(accuracyTestData, accuracyTrainData, testLabels, trainingLabels)
        for index=1:2300
               if  accuracyTestData(index)>=0.50
                   accuracyTestData(index)=1;
               else
                   accuracyTestData(index)=0;
               end
        end

    for index=1:2301
       if  accuracyTrainData(index)>=0.50
           accuracyTrainData(index)=1;
       else
           accuracyTrainData(index)=0;
       end
    end

    countTest=0;
    countTrain=0;

        for index=1:2300
            if accuracyTestData(index)==testLabels(index)
            countTest=countTest+1;
            end
        end

    accuracyTest=(countTest/2300)*100

        for index=1:2300
            if accuracyTrainData(index)==trainingLabels(index)
            countTrain=countTrain+1;
            end
        end

    accuracyTrain=(countTrain/2301)*100
end



    
    
    
    
    
