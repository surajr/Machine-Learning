function plotBoarder(model1, model2, model3, dataTe)
% readme
% model1, model2 and model3 are three struct that represent
%   1. posterior distribution of Gaussian components WITHOUT assumption of
%   equal covariance
%   2. posterior distribution of Gaussian components WITH assumption of
%   equal covariance
%   3. parameter of multinomial logistic regression
% 

% model1 attributes include prior component probability, mean and covariance of three components:
%     model1.pi: [1x3 double]
%     model1.m1: [2x1 double]
%     model1.m2: [2x1 double]
%     model1.m3: [2x1 double]
%     model1.S1: [2x2 double]
%     model1.S2: [2x2 double]
%     model1.S3: [2x2 double]

% model2 attributes include prior component probability, mean and covariance of three components:
%     model1.pi: [1x1 double]
%     model2.m1: [2x1 double]
%     model2.m2: [2x1 double]
%     model2.m3: [2x1 double]
%     model2.S:  [2x2 double]

% model2 attributes only include parameter of multinomial logistic regression:
%     model3.w: [3x3 double]
%     each row of model3.w corresponds to one class, and in each row
%     the 3rd column is the bias parameter \omega_0

% dataTe is the testing data


%% grids on [-5,5]x[-5,5]
[x, y] = meshgrid(-5:0.02:5, -5:0.02:5);
xy = [x(:) y(:)];
n = size(xy,1);

%% poterior probability model 1. 
prob1 = zeros(n,3); 
% prob1: joint probability matrix
prob1(:,1) = 1/sqrt(det(model1.S1))*exp(-0.5*sum(bsxfun(@minus, xy, model1.m1)/(model1.S1).*bsxfun(@minus, xy, model1.m1),2))*model1.pi(1);
prob1(:,2) = 1/sqrt(det(model1.S2))*exp(-0.5*sum(bsxfun(@minus, xy, model1.m2)/(model1.S2).*bsxfun(@minus, xy, model1.m2),2))*model1.pi(2);
prob1(:,3) = 1/sqrt(det(model1.S3))*exp(-0.5*sum(bsxfun(@minus, xy, model1.m3)/(model1.S3).*bsxfun(@minus, xy, model1.m3),2))*model1.pi(3);
prob1 = bsxfun(@rdivide, prob1, sum(prob1,2));
[post1, pred1] = max(prob1, [], 2);
% post1: posterior probability of model 1
% pred1: prediction of model 1

h = figure;
set(h, 'Position',[100,100,1200,400]);
subplot(1,3,1), imagesc(-5:5,-5:5,reshape(pred1,[size(x,1), size(x,2)]));
cmap = [0.75 0.75 0.75; 0.5 0.5 0.5; 0.25 0.25 0.25];
colormap(cmap);
hold on, plot(dataTe.x1(:,1),dataTe.x1(:,2),'r*','MarkerSize',1)
hold on, plot(dataTe.x2(:,1),dataTe.x2(:,2),'gs','MarkerSize',1)
hold on, plot(dataTe.x3(:,1),dataTe.x3(:,2),'bd','MarkerSize',1)

%% posterior probability model2. 
prob2 = zeros(n,3);
prob2(:,1) = 1/sqrt(det(model2.S))*exp(-0.5*sum(bsxfun(@minus, xy, model2.m1)*inv(model2.S).*bsxfun(@minus, xy, model2.m1),2))*model2.pi(1);
prob2(:,2) = 1/sqrt(det(model2.S))*exp(-0.5*sum(bsxfun(@minus, xy, model2.m2)*inv(model2.S).*bsxfun(@minus, xy, model2.m2),2))*model2.pi(2);
prob2(:,3) = 1/sqrt(det(model2.S))*exp(-0.5*sum(bsxfun(@minus, xy, model2.m3)*inv(model2.S).*bsxfun(@minus, xy, model2.m3),2))*model2.pi(3);
prob2 = bsxfun(@rdivide, prob2, sum(prob2,2));
[post2, pred2] = max(prob2, [], 2);
subplot(1,3,2), imagesc(-5:5,-5:5,reshape(pred2,[size(x,1), size(x,2)]));
% cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1];
colormap(cmap);
hold on, plot(dataTe.x1(:,1),dataTe.x1(:,2),'r*','MarkerSize',1)
hold on, plot(dataTe.x2(:,1),dataTe.x2(:,2),'gs','MarkerSize',1)
hold on, plot(dataTe.x3(:,1),dataTe.x3(:,2),'bd','MarkerSize',1)

energy3 = zeros(n,3); % energy (i.e. log(prob)+const) of 3 classes
energy3 = [xy ones(size(xy,1),1)]*model3.w';
[~, pred3] = max(energy3, [], 2);

% prob3 = zeros(n,3);
% prob3 = [xy ones(size(xy,1),1)]*model3.w';
% prob3 = exp(bsxfun(@minus, prob3, max(prob3,[],2)));
% prob3 = bsxfun(@rdivide, prob3, sum(prob3,2));
% [post3, pred3] = max(prob3, [], 2);
subplot(1,3,3), imagesc(-5:5,-5:5,reshape(pred3,[size(x,1), size(x,2)]));
% cmap = [1 0.8 0.8; 0.95 1 0.95; 0.9 0.9 1];
colormap(cmap);
hold on, plot(dataTe.x1(:,1),dataTe.x1(:,2),'r*','MarkerSize',1)
hold on, plot(dataTe.x2(:,1),dataTe.x2(:,2),'gs','MarkerSize',1)
hold on, plot(dataTe.x3(:,1),dataTe.x3(:,2),'bd','MarkerSize',1)

set(gcf, 'PaperPosition', [0 0 12 4]); %Position plot at left hand corner with width 5 and height 5.
set(gcf, 'PaperSize', [12 4]); %Set the paper to have width 5 and height 5.
saveas(gcf, 'gmmBoarder', 'pdf') %Save figure