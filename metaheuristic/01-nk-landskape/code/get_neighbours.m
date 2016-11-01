function neighbours = get_neighbours(sequence) 
  neighbours = cell(length(sequence), 1);
  
  for i = 1:length(sequence)
    neighbour = sequence;
    neighbour(i) = int2str(abs(str2double(neighbour(i)) - 1));

    neighbours{i} = neighbour;
  end
end