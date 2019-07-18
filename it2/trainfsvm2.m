% train interval type-2 fuzzy svm
function [C,bias]=trainfsvm2(X,D,uM,uS,lM,lS1,lS2,ker,svrc,svrp,q,r)

load('param.mat','taskno');

[L,n]=size(X); % L is the number of data samples ==========================
[m,n]=size(uM); % m is the number of rules ================================

trn_labels = D;
trnA = zeros(L,m*(n+1));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
for i=1:L % L is the number of data samples ===============================
    
U=[]; L=[]; % each data sample begins with empty U and L ==================
for j=1:m % m is the number of rules ====================================== 
    u=1; l=1; % each rule begins with empty u and l =======================
    for t=1:n % n is the number of input variables ========================
        grade = gaussmf(X(i,t),[nonzero(uS(j,t)),uM(j,t)]);
        u=u*grade; % apply product tnorm
        if X(i,t) <= lM(j,t)
            grade = gaussmf(X(i,t), [lS1(j,t), lM(j,t)]);
            l = l * grade;
        else
            grade = gaussmf(X(i,t), [lS2(j,t), lM(j,t)]);         
            l = l * grade;
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

uxtemp = ufa*[X(i,:) 1]*q;
lxtemp = lfa*[X(i,:) 1]*r;

xtemp = uxtemp + lxtemp;

xtemp = reshape(xtemp',1,m*(n+1));
trnA(i,:) = xtemp;

end  % for i=1:L ...
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trn_features = trnA;
trn_features_sparse = sparse(trn_features);
libsvmwrite('trn.dat',trn_labels,trn_features_sparse);

% Linear Kernel
[mg_trn_label, mg_trn_inst] = libsvmread('trn.dat');
param = ['-s 3 -t 0 -c ' num2str(svrc) ' -p ' num2str(svrp(1))];
model = libsvmtrain(mg_trn_label, mg_trn_inst, param);

w = model.SVs' * model.sv_coef;
b = -model.rho;

C = reshape(w,n+1,m)';
bias = b;

function [nzvalue] = nonzero(value)
nzvalue = value;
if value <= 1 * 1e-12;
    nzvalue = 1 * 1e-12;
end







