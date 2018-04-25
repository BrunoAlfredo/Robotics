function [ w_next ] = trajectory_following(d, v,trajectory, w_actual, x, y, theta, t)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
% .        w_actual -> present angular velocity
%   output: w_next -> next angular velocity to meet trajectory

% x_ref, y_ref vector and theta_ref vector
x_ref_vector = trajectory(2,:,:);
y_ref_vector = trajectory(3,:,:);
theta_ref_vector = trajectory(4,:,:);

% Finding x_ref, y_ref, theta_ref from trajectory
aux = sqrt((x_ref_vector-x)^2 + (y_ref_vector-y)^2);
[~,i_ref] = min(aux);
x_ref = x_ref_vector(i_ref);
y_ref = y_ref_vector(i_ref);
theta_ref = theta_ref_vector(i_ref);

% Re-parametrizing the state space and using the linearization
r = v / w_atual;
c_s = 1/r;
theta_til = theta_ref - theta;
dI = v * sin(theta_til);
I = norm([x, y] - [x_ref, y_ref]);

ds = v * cos(theta_til) / (1-c_s * I);
dtheta_til = w_actual;

% Values of the controllers
K2 = 20;
K3 = 11;
% (alternativa -> lqr)

u = -K2 * v * I - K3 * abs(v) * theta_til;
w_next  = 
end

