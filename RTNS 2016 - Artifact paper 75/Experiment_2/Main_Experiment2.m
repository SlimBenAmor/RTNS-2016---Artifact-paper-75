
% Experiment 2 script
tic
NumberOfAnalysedTaskSets=100;  % number of analaysed task sets
NumberOfTasks=6;           % number of tasks
NumberOfValues=8;       % number of values per distribution
Utilization=0.75;     % system utilization

DMP=[];
DMPmax=0;

for i=1:NumberOfAnalysedTaskSets
    G = generate_Graph(NumberOfTasks);                    % generate precedence graph
    Tau=generate_tasks(NumberOfTasks,NumberOfValues,Utilization);   % generate random task set
    T = transformPrecedenceTaskSet ( Tau,G );  % modify timing parameters
    [dmp,DMPmax]=sporadicSchedTest(T,0.1);     % schedulability test
    DMP=[DMP DMPmax];
end

HistBars=zeros(1,11);
for i=1:size(DMP,2)
    HistBars(fix((1-DMP(i))*10)+1)=HistBars(fix((1-DMP(i))*10)+1)+1;
end
figure('units','normalized','outerposition',[0.25 0.25 0.5 0.75])
bar(0:10:100,HistBars);
xlabel('x = schedulability ratio');
ylabel('y = nbr of tsak set');
legend('nbr of task set per 10% schedulability ratio interval','Location','north');
toc