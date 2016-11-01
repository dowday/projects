function filename = writeRandomTSP(size)

  TSP = [(1:size)', rand(2,size)'*100];

  filename = strcat('rnd_', num2str(size), '.dat');
  dlmwrite(filename, TSP, ' ');
end