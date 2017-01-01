function results = hamming_histogram(climbing_results) 
  runs = length(climbing_results);

  results = zeros((runs*runs - runs)/2, 1);

  k = 1;
  j_iterations = 1;
  for i = 2:length(climbing_results)
    for j = 1:j_iterations
      results(k) = hamming_distance(climbing_results{i}, climbing_results{j});
      k = k + 1;
    end
    j_iterations = j_iterations + 1;
  end
end