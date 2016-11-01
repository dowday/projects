function [cities, labels] = getDataFromFile(fileName)

cities = zeros(0, 2);
labels = {};
file = fopen(fileName);

while(1)
  
  % read next line
  line = fgetl(file);
  if line == -1
    break;
  end
  
  % skip line if special chars
  if length(line) < 1 || strcmp(line(1), '#') || strcmp(line(1), '!') || strcmp(line(1), ';')
    continue;
  end

  % read line and append
    X = sscanf(line,'%s %g %g')';
    labels{end+1} = char(X(1:end-2));
    cities(end+1,:) = X(end-1:end);
end

labels = labels';

fclose(file);

end