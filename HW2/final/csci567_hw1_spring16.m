

%Loading the data
%4.1 A
display('Programming 4.1');
display('Reading the file');
[trainingLabels, trainingFeatures, testLabels, testFeatures] = readFile;
display('Done')

%4.1 B
display('Newtons method');
ln(trainingLabels, testLabels) %Newton's Method
display('Done')

display('Linear Gradiant');
linearGradient(trainingLabels, testLabels); %Linear Gradient 
display('Done')

hold on;
display('GLMFIT');
glmfit12(trainingFeatures,trainingLabels,testFeatures,testLabels);
display('Done')

display('Calculating Mutual Information');
mi;
display('Done')

display('Calculating PCC');
pcc1;
display('Done')

hold on;
display('Calculating the plot of MI vs PCC');
display('Selecting 20 features with highest MI'); 
hw24_1c4
display('Done')

display('Programming 4.2');
hold on;
trainEvalModels;
hold on;
accuracy=plotGraph
display('End');


