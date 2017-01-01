function sequence = generate_random_sequence(N) 
  sequence = '';
  for i = 1:N
    sequence = strcat(sequence, num2str(round(rand(1,1))));
  end
end