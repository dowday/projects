function [sol, f] = nn(cities)

n = size(cities,1); % # de villes

% ville random au début
sol = zeros(1,n);
currCity = randi(n);
sol(1) = currCity;

% on parcourt toutes les autres villes
for i = 2:n
  % on trouve la ville la plus proche pas encore visitée
  bestDist = Inf;
  for c = 1:n
    if ~ismember(c,sol(1:i-1))
      dist = norm(cities(currCity) - cities(c),2);
      if dist < bestDist
        nextcity = c;
        bestDist = dist;
      end
    end
  end
  
  currCity = nextcity;
  sol(i) = currCity;
end

f = sumOfDistances(cities, sol);

end