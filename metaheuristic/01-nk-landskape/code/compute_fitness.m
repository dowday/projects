function sum = compute_fitness(neighbour, K)
  global f;
  offset = 0;
  sum = 0;
  while(offset + K + 1 <= length(neighbour))
    subsequence = neighbour(1 + offset:1 + offset + K);
    sum = sum + f(subsequence);
    offset = offset + 1;
  end
end