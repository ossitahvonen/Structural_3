
 load pre_est_data.mat
value_grid(winning_bid_data(780:785))
% Excercise 2 code and output here
load constraint_conditions.mat % loads the constraints used in the optimization routine
load starting_guess.mat % loads the starting guess used for the optimizer (a randomly sampled independent uniform joint distribution)

%function [lik]=joint_likelihood(F_v,winning_bids,last,bid_locations)

% F is read in as a 100x1 vector: reshape to 10x10 matrix
%F=reshape(F_v,[10,10])';

% Break into cases

% Win-win
%pics the whole rows of columns where the first wins and second wins

win_win_locs=bid_locations(bid_locations(:,1)>0 & bid_locations(:,3)>0,[1,3]);  

% Define L1: the component of the likelihood for pairs of bids that are
% both winning.

%so then the player 1s win is in win_win_locs(j,1) and players 2s in
%(j,3)?? maybeeee..

L1 = zeros(size(win_win_locs,1),1);