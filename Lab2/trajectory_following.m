function w = trajectory_following(v, trajectory, x, y, theta)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
% .        w_actual -> present angular velocity
%   output: w_next -> next angular velocity to meet trajectory

% x_ref, y_ref vector and theta_ref vector
x_ref_vector = trajectory(2,:,:);
y_ref_vector = trajectory(3,:,:);
theta_ref_vector = trajectory(4,:,:);
w_ref_vector = trajectory(5,:,:);

% Finding x_ref, y_ref, theta_ref from trajectory
aux = sqrt((x_ref_vector-x).^2 + (y_ref_vector-y).^2);
[I,i_ref] = min(aux);
x_ref = x_ref_vector(i_ref);
y_ref = y_ref_vector(i_ref);
theta_ref = theta_ref_vector(i_ref);
w_ref = w_ref_vector(i_ref);

% Re-parametrizing the state space and using the linearization
if w_ref == 0
    c_s = 0;
else
    r = v / w_ref;
    c_s = 1/r;
end
theta_til = theta_ref - theta;

ds = v * cos(theta_til);
dI = v * sin(theta_til);


% Values of the controllers
K2 = 100;
K3 = 11;
% (alternativa -> lqr)

u = -K2 * v * I - K3 * abs(v) * theta_til;

w = v*cos(theta_til)*c_s/(1-c_s*I) + u;

end