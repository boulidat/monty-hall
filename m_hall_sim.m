clear all;clc;
%%this is a simulation of the famous Monty Hall game
%%which justifies the "switch door" strategy from the
%%player's side
%First we need to enter the number of games to be 
%played
number_of_games = input('Enter the number of games to be played: ');
strategy = input('Will you switch after Monty opens a goat door or not? Type 1 for yes and 0 for no: ');
winnings = 0;
probability_of_success = zeros(1,number_of_games);
%place the car behind one of the three doors
for ii = 1:number_of_games
    doors = zeros(1,3);
    random_choice = randi(3,1);
    if random_choice == 1
        doors(1) = 1;
    elseif random_choice == 2
        doors(2) = 1;
    else
        doors(3) = 1;
    end
    %we created a 1x3 matrix with two zeros and one 1
    % the two zeroes are the goats and the 1 is the car
    %now let the player make a random choice
    players_choice = randi(3,1);
    %make monty open a door to reveal a goat
    for jj = 1:3
        if jj ~= players_choice && doors(jj) ~= 1
            monty_door = jj;
            break
        end
    end
    %strategy to be followed
    if strategy == 1
        for kk = 1 : 3
            if kk~=monty_door && kk~=players_choice
                players_choice = kk;
                break
            end
        end
    end
    %%gathering winnings and losses
    if doors(players_choice) == 1
        winnings = winnings + 1;
    end
    %%probability of success
    probability_of_success(ii) = (winnings / ii);
end
%print the results
display(sprintf('The trials are over!\nThe number of trials performed were: %d\nThe probability of winning the car is %.2f%%',number_of_games,100*sum(probability_of_success)/number_of_games));

%make a plot
xaxis = 1:number_of_games;
figure;
plot(xaxis,probability_of_success,'LineWidth', 2,'Color',[0,0.7,0.9]);
xlabel('Number of games played');
ylabel('Probability of winning the car');
hold on;
plot([0 number_of_games],[2/3 2/3],'LineWidth',2.5,'Color','Red');
axis([0 number_of_games 0 1]);
