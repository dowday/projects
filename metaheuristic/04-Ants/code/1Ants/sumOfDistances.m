function s = sumOfDistances(cities, sol)

n = length(sol); % # de villes dans la solution

% somme des distances eucl. entre chaque ville
s = norm(cities(sol(1),:) - cities(sol(end),:),2);
for i = 2:n
  s = s + norm(cities(sol(i),:) - cities(sol(i-1),:),2);
end

end