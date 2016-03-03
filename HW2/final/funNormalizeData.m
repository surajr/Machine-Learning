

function normalize= funNormalizeData(data)
    %data = load('spambase.data');
    mean1 = mean(data);
    stdDev = std(data);

    normalize = zeros(length(data),58);
    for i = 1:length(data)
        normalize(i,1:57) = (data(i,1:57) - mean1)./ stdDev;
    end
 end