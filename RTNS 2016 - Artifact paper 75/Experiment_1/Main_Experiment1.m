
% Experiment 1 script
tic
G=[0 1 1 1 0 0;...  % precedence matrix
   0 0 0 0 1 0;...
   0 0 0 0 1 0;...
   0 0 0 0 0 1;...
   0 0 0 0 0 1;...
   0 0 0 0 0 0];
NumberOfAnalysedTaskSets=10;  % number of analaysed task sets
NumberOfTasks=6;       % number of tasks
NumberOfValues=8;       % number of values per distribution
Utilization=0.75;     % system utilization

DMP=[];
DMPmax=0;

clc;
disp('Starting please wait...');

for i=1:NumberOfAnalysedTaskSets
    disp('generate task please wait...');
    Tau=generate_tasks(NumberOfTasks,NumberOfValues,Utilization);               % generate random task set
    disp('transform task please wait...');
    T = transformPrecedenceTaskSet ( Tau,G );  % modify timing parameters
    disp('schedulability test please wait...');
    [dmp,DMPmax]=sporadicSchedTest(T,0.1);     % schedulability test
    DMP=[DMP DMPmax];
    clc;
    str=sprintf('%d%% done. Please wait... ',fix(i/NumberOfAnalysedTaskSets*100));
    disp(str);
end
disp('Finished');
OurTestRatio=(1-DMP')*100
toc
