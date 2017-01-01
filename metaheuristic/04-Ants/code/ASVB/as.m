function [sol, f] = as(cities, m, alpha, beta, rho, tmax)

n = size(cities, 1); % # de villes
[sol, f] = nn(cities); % on prend algo NN comme sol. init.
Q = f;
tau = (1/f)*ones(n);
d = squareform(pdist(cities));
eta = 1 ./ d;

for t = 1:tmax
  paths = zeros(m,n); % on reset les paths
  deltatau = zeros(n); % les diffs des qtés de phéromones
  paths(:,1) = randi(n,m,1); % on assigne les fourmis à une ville random
  for k = 1:m % on parcourt les fourmis
    for u = 1:n-1 % on parcourt les villes restantes
      i = paths(k, u); % dernière ville du chemin courant

      % calcul de la prob de chaque ville d'être choisie ensuite
      p = zeros(n,1);
      for j = 1:n
        if ~ismember(j,paths(k,1:u)) % ville pas encore dans le chemin
          p(j) = tau(i,j)^alpha * eta(i,j)^beta; % formule (1)
        end
      end
      p = p/sum(p); % normalisation

      paths(k,u+1) = randsample(1:n,1,true,p); % on choisit une des villes d'après les probas précédentes

      % on màj delta tau
      deltatau(i,paths(k,u+1)) = deltatau(i,paths(k,u+1)) + Q/sumOfDistances(cities, paths(k,1:u+1));
    end
    
    % on garde cette solution si c'est la meilleure
    f_curr = sumOfDistances(cities, paths(k,:));
    if f_curr < f
      sol = paths(k,:);
      f = f_curr;
    end
  end

  % on update les taux de phéromones
  tau = (1-rho)*tau + deltatau;
end

end
