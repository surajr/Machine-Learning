
function ln(trainingLabels, testLabels)


% bglm = glmfit(trainingLabels, (testLabels), 'binomial', 'link', 'logit');
% tpred = glmval(bglm, trainingLabels,'logit');
% taccuracy = calcaccuracy(testLabels, tpred);


accuracy = newton(trainingLabels, testLabels);
x = 1:length(accuracy);
plot(x,accuracy);
title('Newton Method'),xlabel('Number of iterations'),ylabel('Accuracy');
end

function accuracy = newton(x,y)
b = ones(length(x(1,:)),1);
accuracy = zeros(1,100);
h = zeros(length(x(1,:)),length(x(1,:)));
grad = zeros(length(x(1,:)));

for i = 1:100
    for j = 1:length(x(:,1))
        sigmoid = (1./(1+exp(-x(j,:)*b)));
        h = h + (sigmoid*(1-sigmoid)*x(j,:)'*x(j,:));
        grad = grad + (sigmoid - y(i))*x(j,:);
    end
    b = b - 0.1*(h\grad);
    predictVal = newVal(b,x);
    accuracy(1,i)=calculateAccuracy(num2cell(y),predictVal);
end
end

function predictVal = newVal(b,x)
    predictVal = 1./(1+exp(-x*b));
end

function accuracy = calculateAccuracy(actual,predict)
total = length(actual);
cpredict = 0;
for i = 1:length(actual)
    if(actual{i} == round(predict(i)))
        cpredict = cpredict + 1;
    end
end
accuracy = cpredict/total;
end



