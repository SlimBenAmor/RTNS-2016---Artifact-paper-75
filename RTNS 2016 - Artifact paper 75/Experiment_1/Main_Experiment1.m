
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
    
for i=1:NumberOfAnalysedTaskSets
    Tau=generate_tasks(NumberOfTasks,NumberOfValues,Utilization);               % generate random task set
    T = transformPrecedenceTaskSet ( Tau,G );  % modify timing parameters
    [dmp,DMPmax]=sporadicSchedTest(T,0.1);     % schedulability test
    DMP=[DMP DMPmax];
end
OurTestRatio=(1-DMP')*100
toc