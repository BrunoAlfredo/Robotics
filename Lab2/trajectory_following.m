function w = trajectory_following(v, trajectory, x, y, theta)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
% .        w_actual -> present angular velocity
%   output: w_next -> next angular velocity to meet trajectory

% x_ref, y_ref vector and theta_ref vector
x_ref_vector = trajectory(:,2,:);
y_ref_vector = trajectory(:,3,:);
theta_ref_vector = trajectory(:,4,:);
w_ref_vector = trajectory(:,5,:);

% Finding x_ref, y_ref, theta_ref from trajectory
aux = sqrt((x_ref_vector-x).^2 + (y_ref_vector-y).^2);
[l,i_ref] = min(aux);
x_ref = x_ref_vector(i_ref);
y_ref = y_ref_vector(i_ref);
theta_ref = theta_ref_vector(i_ref);
w_ref = w_ref_vector(i_ref);
theta_ref_direction = [x_ref - x_ref_vector(i_ref-1), y_ref - y_ref_vector(i_ref-1)];
l_direction = [x - x_ref , y - y_ref];

% Re-parametrizing the state space and using the linearization
r = v / abs(w_ref);
c_s = 1/r;
theta_til = theta_ref - theta;

% Signal of "l"
if cross(theta_ref_direction, l_direction < 0)
   l = l * -1; 
end


% ds = v * cos(theta_til);
% dI = v * sin(theta_til);


% Values of the controllers
K2 = -1;
K3 = 4;
% (alternativa -> lqr)

u = -K2 * v * l - K3 * abs(v) * theta_til;

w = v*cos(theta_til+u)*c_s/(1-c_s*abs(l)) + u;

end