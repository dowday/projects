% Lancer le programme avec nklandskape('d', x) pour la methode Deterministic Hill-Climbing :
%  et nklandskape('p', x) pour la Probabilistic Hill-Climbing
% avec x entre 0 et 2
function nklandskape(type, K)
  clc;

  N = 21;
  runs = 50;
  define_f();
  
  climbing_results = cell(runs, 1);
  for i = 1:runs
    if(type == 'd')
      climbing_results{i} = deterministic_climbing(N, K);
    else
      climbing_results{i} = probabilistic_climbing(N, K);
    end
  end
  figure(1);
  hist(hamming_histogram(climbing_results), 0:N);
  xlabel('Haming Distande');
  ylabel('Pair of sequences');
  title('{\it Probabilistic} Hill climbing for K = 0')
  saveas(figure(1),'Probabilistick0.fig');
  saveas(figure(1),'Probabilistick0.jpg');
  max_sequence = intmin;
  max_fitness = intmin;
  for i = 1:length(climbing_results)
    fitness = compute_fitness(climbing_results{i}, K);
    if(fitness > max_fitness)
      max_sequence = climbing_results{i};
      max_fitness = fitness;
    end
  end
  
  disp([max_sequence, ' : ', num2str(max_fitness)]);
end
