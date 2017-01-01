%% Random TSP

m1 = 5;
m2 = 10;
n = [50 60 80 100];
nCount = length(n);
distNN = zeros(m1, nCount);
distAS = distNN;
timeNN = zeros(m1, nCount);
timeAS = timeNN;

for i = 1:nCount
  for j = 1:m1
    filename = writeRandomTSP(n(i));
    [cities, labels] = getDataFromFile(filename);
    tic
    [seqCities, distAS(j,i)] = as(cities,40,1,5,0.1,40);
    timeAS(j,i) = toc;
    disp(['AS (n=', num2str(n(i)), ', TSP #', num2str(j), ')']);
    disp('  Sequence of cities:');
    disp(seqCities');
    disp('  Total distance:');
    disp(distAS(j,i));
    disp('-----------------------------');

    avg = zeros(m2,2);
    for k = 1:m2
      tic;
      [seqCities, avg(k,1)] = nn(cities);
      avg(k,2) = toc;
      disp(['NN (n=', num2str(n(i)), ', TSP #', num2str(j), ', iter #', num2str(k), ')']);
      disp('  Sequence of cities:');
      disp(seqCities');
      disp('  Total distance:');
      disp(avg(k,1));
      disp('-----------------------------');
    end
    distNN(j,i) = mean(avg(:,1));
    timeNN(j,i) = mean(avg(:,2));
  end
end

% Génération figures
meanTimeNN = mean(timeNN);
stdTimeNN  = std (timeNN);
meanTimeAS = mean(timeAS);
stdTimeAS  = std (timeAS);

meanDistNN = mean(distNN);
stdDistNN  = std (distNN);
meanDistAS = mean(distAS);
stdDistAS  = std (distAS);



% randtsp;
%% showing diversification 
%     for alphadec = 0:0.1:1
%         tic
%         [SeqSolBestf, Bestf, BestCost, cities]= aco('cities.dat', 100, alphadec, 5, 0.1, 10);
%         NNmeantime(count) = toc;
%         ASmean_div(count) = mean(BestCost);
%         ASstd_div(count) = std(BestCost);
%         count = count + 1;
%     end
%     figure;
%     plot(BestCost,'LineWidth',2);
%     xlabel('Iteration');
%     ylabel('Best Cost AS in diversifivation');
%     grid on;

% %% Greedy algorithm
% NN_BestCostnExc=zeros(1,nExc);
% NN_ExecTime=zeros(1,nExc);
% for exec=1:nExc
%     tic;
%     [NN_SeqSolBestf, NN_BestCost] = nn(cities);
%     NN_BestCostnExc(nExc,:) = NN_BestCost;
%     NN_ExecTime(nExc) = toc;
%     NN_ExecTimeMean=mean(NN_ExecTime);
%     NN_ExecTimeSTD=mean(NN_ExecTime);    
%     NN_mean = mean(NN_BestCostnExc);
%     NN_STD = std(NN_BestCostnExc);
% end
%     figure;
%     plot(NN_BestCostnExc,'LineWidth',2);
%     xlabel('Iteration');
%     ylabel('Best Cost NN');
%     grid on;
%     showPlot(cities, NN_SeqSolBestf);

