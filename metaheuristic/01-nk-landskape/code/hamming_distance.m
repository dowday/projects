function distance = hamming_distance(s1, s2) 
  distance = 0;
  
  for i = 1:length(s1)
    if s1(i) ~= s2(i)
      distance = distance + 1;
    end
  end
end