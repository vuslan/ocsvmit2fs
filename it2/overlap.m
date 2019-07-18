% lower MF parameters

function [lowerstd1,lowerstd2,lowermean] = overlap(numInp,cnum,clmin,clmean,clmax)

lowerpoints = []; % lower MF parameters
upperpoints = []; % upper MF parameters

fprintf('find left and right stddev for the given MFs\n');

for i=1:numInp

    for j=1:cnum        
        
        allpoints = [];
        for j2=1:cnum

            allpoints = [allpoints clmin(j2,i) clmean(j2,i) clmax(j2,i)];

        end        
               
        inclpoints = [clmin(j,i) clmean(j,i) clmax(j,i)];
        outclpoints = setdiff(allpoints,inclpoints);
        
        lefttemp1 = find(outclpoints>clmin(j,i));
        lefttemp2 = find(outclpoints<clmean(j,i));        
        leftoverlapidx=intersect(lefttemp1,lefttemp2);
        leftpoints = (outclpoints(leftoverlapidx));
        lwmin(j,i) = clmin(j,i);        
        if ~isempty(leftpoints)
            leftpoints = sort(leftpoints);
            lwmin(j,i) = leftpoints(1);
        end
        lowerpoints(i,(j-1)*3+1) = lwmin(j,i);
        upperpoints(i,(j-1)*3+1) = clmin(j,i);
        
        %leftstd
        tmfp = [lwmin(j,i) clmean(j,i) clmean(j,i) + abs(clmean(j,i)-lwmin(j,i))];
        gmfp  = mf2mf(tmfp,'trimf','gaussmf'); % convert trimf to gaussmf
        lstd = gmfp(1);        
        
        % fixed mean
        lowerpoints(i,(j-1)*3+2) = clmean(j,i);
        upperpoints(i,(j-1)*3+2) = clmean(j,i);       
        
        righttemp1 = find(outclpoints>clmean(j,i));
        righttemp2 = find(outclpoints<clmax(j,i));        
        rightoverlapidx=intersect(righttemp1,righttemp2);
        rightpoints = (outclpoints(rightoverlapidx));
        lwmax(j,i) = clmax(j,i);     
        if ~isempty(rightpoints)
            rightpoints = sort(rightpoints);
            lwmax(j,i) = rightpoints(1);
        end
        lowerpoints(i,(j-1)*3+3) = lwmax(j,i);        
        upperpoints(i,(j-1)*3+3) = clmax(j,i);
        
        %rightstd
        tmfp = [clmean(j,i) - abs(clmean(j,i)-lwmax(j,i)) clmean(j,i) lwmax(j,i)];
        gmfp  = mf2mf(tmfp,'trimf','gaussmf'); % convert trimf to gaussmf
        rstd = gmfp(1);
        
        lowerstd1(j,i) = nonzero(lstd); % left stddev     
        lowerstd2(j,i) = nonzero(rstd); % right stddev
        lowermean(j,i) = clmean(j,i);        
                
    end % for j=1:cnum
    
end % for i=1:numInp

function [nzvalue] = nonzero(value)
nzvalue = value;
if value <= 1 * 1e-12;
    nzvalue = 1 * 1e-12;
end

