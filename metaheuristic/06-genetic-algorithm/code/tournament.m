function [winner_x_component, winner_y_component] = tournament(population,fitnesses,pop_size,tournament_size)
players = zeros(1,tournament_size);%k-tournament
%randomly select 5 knights from the population to participate to the joust.
for i=1:tournament_size
    %tirage au sort proportionnel a la fitness. NOTE:abs() to avoid negative
    %probabilities
    new_player = randsample(1:pop_size,1,true,abs((fitnesses./1000)));
    %check that we dont select a player that is already in the list
%     while sum(ismember(players,new_player))
%         new_player = randsample(1:pop_size,1);
%     end
    players(i) = new_player;
end

for i=1:tournament_size
    scores(i) = fitness(population(players(i),1),population(players(i),2));
    players_index(i) = players(i);
end

[winner_fitness, winner_index] = min(scores); %the winner is the smallert value (minimization problem)


winner_x_component = population(players_index(winner_index),1);
winner_y_component = population(players_index(winner_index),2);


end

