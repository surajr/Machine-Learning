function linearGradient(trainingLabels, testLabels)
accuracies = linearGrad(trainingLabels, testLabels);
trainingLabels = 1:length(accuracies);
plot(trainingLabels,accuracies);
title('Linear Gradiant'),xlabel('No of Iterations'), ylabel('Accuracy');
end

function accuracy = linearGrad(x,y)
b = zeros(length(x(1,:)),1);
accuracy = zeros(1,100);

for i = 1:100
    for j=1:length(x(:,1))
        sigmoid = 1./(1+exp(-x(j,1)*b));
        b = b - 1.5 * x(j,:)*(sigmoid - y(i));
      
    end
    predict = gradiantValue(b,x);
    accuracy(i) = calculateAccuracy(y,predict);
end
end


function accuracy = calculateAccuracy(actual, predict)
    total = length(actual);
    count = 0;
    for i=1:length(actual)
        if(actual(i)>=round(predict(i)))
            count = count+1;
        end
    end
    accuracy = count/total;
end


function predict = gradiantValue(b,x)
    predict = 1./(1+exp(-1*x*b));
end

