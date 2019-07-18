%% INITIAL PARAMS

clc; clear; close;
addpath('assess','data','mex','it2');

%% DATA (The input is min-max normalized)

load('data.mat','trnin','chkin','datout','chkout','features','numInp');

%% FEATURE SELECTION

seldatin=trnin(:,features); % selected training inputs
selchkin=chkin(:,features); % selected testing inputs

%% CLUSTERING PARAMETERS

load('param.mat','ctype','cnumset');

%% SVR PARAMETERS

load('param.mat','ker','svrcset','svrpset');

%% IT2 Biglarbegian-Melek-Mendel (BMM) PARAMETERS

load('param.mat','bmmqset','bmmrset');

maxtrnq2 = -1.0; maxchkq2 = -1.0;
maxc = 0.00; maxp = 0.00; maxq = 0.00; maxr = 0.00; maxtype=0; maxnum=0; maxfea = 0;

%% GRID SEARCH

for cnum=cnumset
for svrc=svrcset
for svrp=svrpset
for q=bmmqset
for r=bmmrset
for step=1:1
%% SYSTEM IDENTIFICATION (OVERLAPPING)

trndat = [seldatin datout]; % input ve output beraber cluster edilcek.
cl=ca(ctype,trndat,cnum); % do the cluster analysis

fprintf('find all gaussMF and triangularMF params (upper)\n');
upperM = cl.mean(:,1:numInp); upperS = cl.std(:,1:numInp);

fprintf('find lower MF in the overlapping regions\n');
%pause(2); %overlapping
[lowerS1,lowerS2,lowerM] = overlap(numInp,cnum,cl.min,cl.mean,cl.max);
uM = upperM; lM = lowerM; uS = upperS; lS1 = lowerS1; lS2 = lowerS2;

%% PREDICTION

load('param.mat','taskno');

[C,bias]=trainfsvm2(seldatin,datout,uM,uS,lM,lS1,lS2,ker,svrc,svrp,q,r);
svmout = predictfsvm2(seldatin,uM,uS,lM,lS1,lS2,C,bias,q,r);
if taskno == 4
 trnq2 = findsp(datout,svmout);
else
 trnq2 = findq2(datout,svmout);
end
svmouc = predictfsvm2(selchkin,uM,uS,lM,lS1,lS2,C,bias,q,r);
if taskno == 4
 chkq2 = findsp(chkout,svmouc);
else
 chkq2 = findq2(chkout,svmouc);  
end


%% RESULTS
if chkq2 > maxchkq2
maxchkq2 = chkq2; maxtrnq2 = trnq2; maxc = svrc; maxp = svrp; maxq = q; maxr = r; maxtype = ctype; maxnum=cnum; maxfea=numInp;
save('result.mat','trnq2','chkq2','svmout','svmouc','datout','chkout');
end

% print process
grd = {'step';'max'};
c_type = [ctype;maxtype];
c_num = [cnum;maxnum];
f_num = [numInp;maxfea];
svr_c = [svrc;maxc];
svr_p = [svrp;maxp];
bmm_q = [q;maxq];
bmm_r = [r;maxr];
trn_q2 = [round(trnq2,3);round(maxtrnq2,3)];
chk_q2 = [round(chkq2,3);round(maxchkq2,3)];

T = table(grd,c_type,c_num,f_num,svr_c,svr_p,bmm_q,bmm_r,trn_q2,chk_q2)
pause(3)

end % for step
end % for r
end % for q
end % for svrp
end % for svrc
end % for cnum