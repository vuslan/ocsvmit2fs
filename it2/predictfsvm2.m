% predict interval type-2 fuzzy svm
function [out]=predictfsvm2(X,uM,uS,lM,lS1,lS2,C,bias,q,r)

load('param.mat','taskno');

[L,n]=size(X); % L is the number of data samples ==========================
[m,n]=size(uM); % m is the number of rules ================================

out = [];

A = zeros(L,m*(n+1));

for i=1:L % L is the number of data samples ===============================
    
U=[]; L=[]; % each data sample begins with empty U and L ==================
for j=1:m % m is the number of rules ====================================== 
u=1; l=1; % each rule begins with empty u and l ===========================
    for t=1:n % n is the number of input variables ========================
        
        u=u*(gaussmf(X(i,t),[nonzero(uS(j,t)),uM(j,t)])); % apply product tnorm ====
        if X(i,t) <= lM(j,t)
            l = l * gaussmf(X(i,t), [lS1(j,t), lM(j,t)]);
        else
            l = l * gaussmf(X(i,t), [lS2(j,t), lM(j,t)]);
        end
        
    end
    % weights are found for each rule of the data sample
    if taskno == 4
        U=[U,nonzero(u)];
    else
        U=[U,u];
    end
	L=[L,nonzero(l)];
end

ufa=U/sum(U); % this is the weight (upper)
lfa=L/sum(L); % this is the weight (lower)

% f is the ytsk
% =========================================================================

ufa=ufa';
lfa=lfa';

% compute the consequent ==================================================

c0=C(:,n+1);
for t=1:n
c0=c0+C(:,t)*X(i,t);
end
% =========================================================================

f=q*(ufa'*c0) + r*(lfa'*c0) + bias; % this is the weighted average
out = [out f];

end  % for i=1:L ...

out = out';

function [nzvalue] = nonzero(value)
nzvalue = value;
if value <= 1 * 1e-12;
    nzvalue = 1 * 1e-12;
end






