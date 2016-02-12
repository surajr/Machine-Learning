function lrTemplate()
    load demoSynLR.mat
    

    
    %%
    % your codes here
    
    %%
    %     demo of TA's plot functions
         figureLR = figure(1);
         
         
         w1A = lrFit(data1.x,data1.y);
         w1B = lrFit(data1.x(1:(end-1),:),data1.y(1:(end-1),:));
         
         w2A = lrFit(data2.x,data2.y);
         w2B = lrFit(data2.x(1:(end-1),:),data2.y(1:(end-1),:));
         
         w3A = lrFit(data3.x,data3.y);
         w3B = lrFit(data3.x(1:(end-1),:),data3.y(1:(end-1),:));
         
         w4A = lrFit(data4.x,data4.y);
         w4B = lrFit(data4.x(1:(end-1),:),data4.y(1:(end-1),:));
         
         set(figureLR,'Position',[100, 100, 1000, 800]);
         plotLRline(figureLR, 1, w1A, w1B, data1.x, data1.y);
         plotLRline(figureLR, 2, w2A, w2B, data2.x, data2.y);
         plotLRline(figureLR, 3, w3A, w3B, data3.x, data3.y);
         plotLRline(figureLR, 4, w4A, w4B, data4.x, data4.y);
         
         h1 = leverage(data1.x);
         h2 = leverage(data2.x);
         h3 = leverage(data3.x);
         h4 = leverage(data4.x);
         
         t1 = studentized(data1.x,data1.y,w1A,h1);
         t2 = studentized(data2.x,data2.y,w2A,h2);
         t3 = studentized(data3.x,data3.y,w3A,h3);
         t4 = studentized(data4.x,data4.y,w4A,h4);
         
         d1 = cookDist(h1,t1,2);
         d2 = cookDist(h2,t2,2);
         d3 = cookDist(h3,t3,2);
         d4 = cookDist(h4,t4,2);
         
         figureSample = figure(2);
         set(figureSample,'Position',[100, 100, 1000, 800]);
         plotSamples(figureSample, 1, data1.x, data1.y, h1, t1, d1);
         plotSamples(figureSample, 2, data2.x, data2.y, h2, t2, d2);
         plotSamples(figureSample, 3, data3.x, data3.y, h3, t3, d3);
         plotSamples(figureSample, 4, data4.x, data4.y, h4, t4, d4);
         
         beta1_1 = ridgeFit(data1.x,data1.y,0.1);
         beta1_2 = ridgeFit(data1.x,data1.y,1);
         beta1_3 = ridgeFit(data1.x,data1.y,10);
         
         beta2_1 = ridgeFit(data2.x,data2.y,0.1);
         beta2_2 = ridgeFit(data2.x,data2.y,1);
         beta2_3 = ridgeFit(data2.x,data2.y,10);
         
         beta3_1 = ridgeFit(data3.x,data3.y,0.1);
         beta3_2 = ridgeFit(data3.x,data3.y,1);
         beta3_3 = ridgeFit(data3.x,data3.y,10);
         
         beta4_1 = ridgeFit(data4.x,data4.y,0.1);
         beta4_2 = ridgeFit(data4.x,data4.y,1);
         beta4_3 = ridgeFit(data4.x,data4.y,10);
         
         figureLR = figure(3);
         set(figureLR,'Position',[100, 100, 1000, 800]);
         plotLRline1(figureLR, 1, beta1_1, beta1_2, beta1_3, data1.x, data1.y);
         plotLRline1(figureLR, 2, beta2_1, beta2_2, beta2_3, data2.x, data2.y);
         plotLRline1(figureLR, 3, beta3_1, beta3_2, beta3_3, data3.x, data3.y);
         plotLRline1(figureLR, 4, beta4_1, beta4_2, beta4_3, data4.x, data4.y);
         
         
end

function beta = ridgeFit(dataX,dataY,lambda)
%code
i = eye(size(dataX,2));
beta = pinv(dataX'*dataX + lambda*i)* dataX'*dataY;
%ridge = zeros(size(dataX,1),1);
%for i = 1:size(dataX,1)
 %   ridge(i,1) = dataY(i,1) - (dataX(i,:)*beta);
%
end

function r = heldoutResidual(w, dataValX, dataValY)
% evaluate/calculate the residual on heldout data
% your code here
r = dataValY - w'*dataValX;
%
end

function w = lrFit(dataX,dataY)
% fit the linear regression parameters    
% your code here
%size(dataX)
%size(dataY)
w = zeros(size(dataX,2),1);

w = pinv(dataX' * dataX)*dataX' * dataY;
%
end

function h = leverage(dataX)
% calculate leverage of every sample    
% your code here
%size(dataX)
arr = zeros(size(dataX,1),size(dataX,1));

arr = dataX * pinv(dataX' * dataX) * dataX';

h=zeros(1,size(arr,1));
for i = 1:size(arr,1)
    h(i) = arr(i,i);
end
%
end

function t = studentized(dataX,dataY,w,h)
% calculate studentized residual for every sample
% your code here
%size(dataX)
%size(dataY)
%size(w)
%size(h)
residual = zeros(size(dataY,1),1);
for i = 1:size(dataY,1)
    residual(i,1) = dataY(i,1) - (dataX(i,:)*w);
end
t = zeros(size(dataY,1),1);
temp = 0;
for x = 1:size(residual,1)
    temp = temp + (residual(x,1)-mean(residual))^2;
end
s = temp/(size(dataY,1)-size(w,1));
for i=1:size(dataY,1)
    t(i,1) = residual(i,1)/(s*sqrt(1-h(1,i)));
end
%
end

function d = cookDist(h,t,k)
% calculate cook's distance for every sample
% your code here
%size(h)
%size(t)
d = zeros(size(h,2),1);
for i = 1:size(h,2)
    d(i,1) = (h(1,i)/(1-h(1,i)))*(t(i,1)^2/(1+k))
end

%
end

function plotLRline(figureLR, subPID, w1, w2, dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    hleg = legend('majority','leverage','outlier','LR');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end

function plotLRline1(figureLR, subPID, w1, w2, w3,dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    w3 = transpose(w3(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    plot([bl(1), ur(1)], [w3*[1;bl(1)], w3*[1;ur(1)]],'c-','lineWidth',3);
    
    hleg = legend('majority','leverage','outlier','LR');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end

function plotSamples(figureLR, subPID, dataX, dataY, h, t, d)
% h, t, d: 
%   leverage, studentized_residual, cook's distance of samples
    [~, idxH] = max(h);
    [~, idxT] = max(t);
    [~, idxD] = max(d);
    
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot(dataX(idxH(1),2), dataY(idxH(1)), 'cd','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxT(1),2), dataY(idxT(1)), 'ms','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxD(1),2), dataY(idxD(1)), 'k>','MarkerSize',12,'LineWidth',3);
    hleg = legend('majority','leverage','outlier','max-H','max-T','max-Cook');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(', num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
    
end
