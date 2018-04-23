function [ w ] = trajectory_following(d, v, trajectory, dtheta)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
%   output: w -> we are just controlling the angular velocity


% Time vector
t = trajectory(1,:,:);

% Descobrir x_ref, y_ref, theta_ref a partir da trajet�ria
x_ref = ...;
y_ref = ...;
theta_ref = ...;

% x,y -> posi��o do robot no world frame
theta = cumtrapz(t, dtheta); % numerical integral

% Jacobiana
J = [cos(theta), -sin(theta), 0 ;...
     sin(theta), cos(theta),  0 ;...
     0         , 0         ,  1];
 
% Re-parametrizing the state space:


end
