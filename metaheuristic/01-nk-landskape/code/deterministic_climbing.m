function sequence = deterministic_climbing(N, K)
  % Effectue la grimpe stricte
  sequence = generate_random_sequence(N);
  largest_fitness = intmin;

  while(1)
    neighbours = get_neighbours(sequence);
    fitness = zeros(length(neighbours), 1);

    for i = 1:length(neighbours)
        fitness(i) = compute_fitness(neighbours{i}, K);
    end

    [largest_fitness, index] = max([largest_fitness; fitness]);
    indexes = find(fitness == largest_fitness);
    if index == 1
      break;
    end

    rnd = randperm(length(indexes), 1);
    sequence = neighbours{indexes(rnd)};
  end
end