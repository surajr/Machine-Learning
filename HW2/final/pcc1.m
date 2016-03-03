function [pcc]= pcc1

pcc=zeros(57,1);
dataSet = load('spambase.data');
meanX=mean(dataSet(:,58));
meanY=zeros(57,1);
for i=1:57
       meanY(i,1)=mean(dataSet(:,i));
end

pcc = calculatePCC(pcc, meanX,meanY,dataSet);
end

function pcc = calculatePCC(pcc, meanX,meanY,dataSet)
    for i=1:57
        C=zeros(57,1);
        D=zeros(57,1);
        E=zeros(57,1);
    
        for index=1:4601
            C(index,1)=(dataSet(index,i)-meanY(i))*(dataSet(index,58)-meanX);
            D(index,1)=(dataSet(index,i)-meanY(i))^2;
            E(index,1)=(dataSet(index,58)-meanX)^2;
        end
        A=sum(D);
        B=sum(C);
        X=sum(E);
    
        rootD=sqrt(A);
        rootE=sqrt(X);
        denom=rootD*rootE;
    
        pcc(i,1)=B/denom;
    end
end
