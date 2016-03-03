function p = convertBin(x,y)
% output:
%   p is array of 57 cells
%   each cell is a 10x2 matrix, p{i}(j,k) is the (approximate) number of samples from
%   class "k" and in bin "j"

    for i = 1:57
        u = unique(x(:,i));
        [a,~] = hist(x(:,i),u);
        a = a(:);
        acum = cumsum(a);
        cumn = 0;
        % figure out which bins one unique feature j belongs to
        count = zeros(11,2);
        for j=1:length(u)
            if j==1
                bin1 = 1;
                bin2 = ceil(acum(j,1)/460);
            else
                bin1 = ceil((acum(j-1,1)+1)/460);
                bin2 = ceil(acum(j)/460);
            end

            n0 = sum(y(x(:,i)==u(j))==0);
            n1 = sum(y(x(:,i)==u(j))==1);

            for binID = bin1:bin2
                % n: number of samples of value "j" and in bin "binID"
                if j==1
                    n = min(460*binID, acum(j))-max(460*(binID-1)+1, 1)+1;
                else
                    n = min(460*binID, acum(j))-max(460*(binID-1)+1, acum(j-1)+1)+1;
                end
                cumn = cumn+n;
                count(binID,1) = count(binID,1)+n*n0/(n0+n1);
                count(binID,2) = count(binID,2)+n*n1/(n0+n1);
            end
            count(10,:) = count(10,:)+count(end,:);
            p{i} = count(1:10,:);
            %keyboard
        end
    end