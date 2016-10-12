
% Experiment 2 script
tic
NumberOfAnalysedTaskSets=100;  % number of analaysed task sets
NumberOfTasks=6;           % number of tasks
NumberOfValues=8;       % number of values per distribution
Utilization=0.75;     % system utilization

DMP=[];
DMPmax=0;

clc;
disp('Starting please wait...');

for i=1:NumberOfAnalysedTaskSets
    disp('generate graph please wait...');
    G = generate_Graph(NumberOfTasks);                    % generate precedence graph
    disp('generate task please wait...');
    Tau=generate_tasks(NumberOfTasks,NumberOfValues,Utilization);   % generate random task set
    disp('transform task please wait...');
    T = transformPrecedenceTaskSet ( Tau,G );  % modify timing parameters
    disp('schedulability test please wait...');
    [dmp,DMPmax]=sporadicSchedTest(T,0.1);     % schedulability test
    DMP=[DMP DMPmax];
    str=sprintf('%d%% done. Please wait... ',fix(i/NumberOfAnalysedTaskSets*100));
    disp(str);
end

HistBars=zeros(1,11);
for i=1:size(DMP,2)
    HistBars(fix((1-DMP(i))*10)+1)=HistBars(fix((1-DMP(i))*10)+1)+1;
end
disp('Finished');
figure('units','normalized','outerposition',[0.25 0.25 0.5 0.75])
bar(0:10:100,HistBars);
xlabel('X = Schedulability Ratio');
ylabel('Y = Number of schedulable task-sets');
legend('Number of task-sets per 10% schedulability ratio interval','Location','north');
toc
