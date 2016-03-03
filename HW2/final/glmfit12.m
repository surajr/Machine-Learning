function glmfit12(trainingFeatures,trainingLabels,testFeatures,testLabels)

    b = glmfit(trainingFeatures,trainingLabels,'normal');
    accuracyTrainData = glmval(b,trainingFeatures,'identity');
    accuracyTestData = glmval(b,testFeatures,'identity');

    display('GLMFIT');
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