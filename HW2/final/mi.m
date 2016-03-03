function [mutualInfo] = mi
    data = load('spambase.data');
    columndataSize = size(data,2)-1;
    dataSize= length(data);
    tempReshape = zeros(10,460);
    mutualInfo = zeros(columndataSize,1);

    classifier0 = find(data(:,58)==0);
    classifier1 = find(data(:,58)==1);

    probX = 460/dataSize;
    probY0 = length(classifier0)/dataSize;
    probY1 = length(classifier1)/dataSize;

    for i = 1:columndataSize
       [value, position] = sort(data(:,i));
       tempReshape(:,1:460)=reshape(position(1:4600),10,[]);
       tempReshape(10,461)=position(4601);

       tempMatrix1 = zeros(10,1);
       tempMatrix2 = zeros(10,1);


       for j=1:9
           tempMatrix1(j,1)=size(intersect(classifier0,tempReshape(j,1:460)),1)/4601;
           tempMatrix2(j,1)=size(intersect(classifier1,tempReshape(j,1:460)),1)/4601;
       end
       j=10;
       tempMatrix1(j,1)=size(intersect(classifier0,tempReshape(j,:)),1)/4601;
       tempMatrix2(j,1)=size(intersect(classifier1,tempReshape(j,:)),1)/4601;
       
       mi2 = tempMatrix2 .* log(tempMatrix2 ./ (probX * probY1));
       mutualInfo2 = sum(mi2(:));

       mi1 = tempMatrix1 .* log(tempMatrix1 ./ (probX * probY0));
       mutualInfo1 = sum(mi1(:));

       mutualInfo(i,1) = mutualInfo1 + mutualInfo2;

    end
end
