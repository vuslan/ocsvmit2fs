clc; clear; close;

taskno = input('What is taskno: ');
addpath('data');

switch taskno
    case 1
        load mm1trninp.csv; load task1trnout.csv;
        load mm1chkinp.csv; load task1chkout.csv;

        trnin = mm1trninp; datout = task1trnout;
        chkin = mm1chkinp; chkout = task1chkout;

        % feature selection is omitted for simplicity
        % task1 features are provided in task1features.txt 
        features=load('task1features.txt'); % 161/5787
        numInp = numel(features); % 161
        
        % CLUSTERING PARAMETERS
        ctype = 2; % 1: HCM 2: FCM 3: HCA     
        cnum = 3; cnumset=[cnum:1:cnum];
        
        % SVR PARAMETERS

        ker=0; % linear:0 polynomial:1 radial basis:2 sigmoid:3
        svrc = 0.75; svrcset = [svrc:0.05:svrc];
        svrp = 0.05; svrpset = [svrp:0.05:svrp];
        svrg = 1.0; % for linear kernel this has no use
        
        % IT2 Biglarbegian-Melek-Mendel (BMM) PARAMETERS

        q=0.55; bmmqset = [q:0.05:q];
        r=0.50; bmmrset = [r:0.05:r];
        
    case 2
        load mm2trninp.csv; load task2trnout.csv;
        load mm2chkinp.csv; load task2chkout.csv;

        trnin = mm2trninp; datout = task2trnout;
        chkin = mm2chkinp; chkout = task2chkout;

        % feature selection is omitted for simplicity
        % task2 features are provided in task2features.txt 
        features=load('task2features.txt'); % 247/5144
        numInp = numel(features); % 247        
        
        % CLUSTERING PARAMETERS
        ctype = 3; % 1: HCM 2: FCM 3: HCA         
        cnum = 4; cnumset=[cnum:1:cnum];
        
        % SVR PARAMETERS

        ker=0; % linear:0 polynomial:1 radial basis:2 sigmoid:3
        svrc = 1.40; svrcset = [svrc:0.05:svrc];
        svrp = 0.05; svrpset = [svrp:0.05:svrp];
        svrg = 1.0; % for linear kernel this has no use
        
        % IT2 Biglarbegian-Melek-Mendel (BMM) PARAMETERS

        q=0.65; bmmqset = [q:0.05:q];
        r=0.45; bmmrset = [r:0.05:r];
        
    case 3
        load mm3trninp.csv; load task3trnout.csv;
        load mm3chkinp.csv; load task3chkout.csv;

        trnin = mm3trninp; datout = task3trnout;
        chkin = mm3chkinp; chkout = task3chkout;

        % feature selection is omitted for simplicity
        % task3 features are provided in task3features.txt 
        features=load('task3features.txt'); % 172/5787
        numInp = numel(features); % 172
        
        % CLUSTERING PARAMETERS
        ctype = 2; % 1: HCM 2: FCM 3: HCA       
        cnum = 3; cnumset=[cnum:1:cnum];
        
        % SVR PARAMETERS

        ker=0; % linear:0 polynomial:1 radial basis:2 sigmoid:3
        svrc = 1.25; svrcset = [svrc:0.05:svrc];
        svrp = 0.85; svrpset = [svrp:0.05:svrp];
        svrg = 1.0; % for linear kernel this has no use
        
        % IT2 Biglarbegian-Melek-Mendel (BMM) PARAMETERS

        q=0.45; bmmqset = [q:0.05:q];
        r=0.50; bmmrset = [r:0.05:r];
             
    case 4
        load mm4trninp.csv; load task4trnout.csv;
        load mm4chkinp.csv; load task4chkout.csv;

        trnin = mm4trninp; datout = task4trnout;
        chkin = mm4chkinp; chkout = task4chkout;

        % feature selection is omitted for simplicity
        % task4 features are provided in task4features.txt 
        features=load('task4features.txt'); % 141/5787
        numInp = numel(features); % 141
        
        % CLUSTERING PARAMETERS
        ctype = 2; % 1: HCM 2: FCM 3: HCA     
        cnum = 3; cnumset=[cnum:1:cnum];        
        
        % SVR PARAMETERS

        ker=0; % linear:0 polynomial:1 radial basis:2 sigmoid:3
        svrc = 1.75; svrcset = [svrc:0.05:svrc];
        svrp = 0.45; svrpset = [svrp:0.05:svrp];
        svrg = 1.0; % for linear kernel this has no use
        
        % IT2 Biglarbegian-Melek-Mendel (BMM) PARAMETERS

        q=0.70; bmmqset = [q:0.05:q];
        r=0.55; bmmrset = [r:0.05:r];                
        
    otherwise
        disp('no such task')
end

save('data.mat','trnin','datout','chkin','chkout','features','numInp');
save('param.mat','ctype','cnumset','ker','svrcset','svrpset','bmmqset','bmmrset','taskno');