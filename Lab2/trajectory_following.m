function [ w ] = trajectory_following(d, v, trajectory)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
%   output: w -> we are just controlling the angular velocity

% Descobrir x_ref, y_ref, theta_ref a partir da trajetória
x_ref = ...;
y_ref = ...;
theta_ref = ...;

% x,y -> posição do robot no world frame
theta = atan(y/x);

% Jacobiana
J = [cos(theta), -sin(theta), 0 ;...
     sin(theta), cos(theta),  0 ;...
     0         , 0         ,  1];
 
% Re-parametrizing the state space:


end

