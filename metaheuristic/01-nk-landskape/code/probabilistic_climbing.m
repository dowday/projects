function sequence_largest_fitness = probabilistic_climbing(N, K)
  sequence = generate_random_sequence(N);
  largest_fitness = intmin;
  sequence_largest_fitness = '';

  for k = 1:15
    neighbours = get_neighbours(sequence);
    fitness = zeros(length(neighbours), 1);

    for i = 1:length(neighbours)
        fitness(i) = compute_fitness(neighbours{i}, K);
    end
   
    r = rand;
    fitness_cumulative_mean = cumsum(fitness / sum(fitness));
    chosen_fitness_index = find(r < [0; fitness_cumulative_mean], 1) - 1;

    if fitness(chosen_fitness_index) > largest_fitness
      largest_fitness = fitness(chosen_fitness_index);
      sequence_largest_fitness = neighbours{chosen_fitness_index};
    end

    sequence = neighbours{chosen_fitness_index};
  end
end