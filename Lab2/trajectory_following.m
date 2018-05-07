function [w,v] = trajectory_following(v, trajectory, x, y, theta)
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
if i_ref == 1
   w=0;
   return  
end
x_ref = x_ref_vector(i_ref);
y_ref = y_ref_vector(i_ref);
theta_ref = theta_ref_vector(i_ref);
w_ref = w_ref_vector(i_ref);
theta_ref_direction = [x_ref - x_ref_vector(i_ref-1), y_ref - y_ref_vector(i_ref-1) , 0];
l_direction = [x - x_ref , y - y_ref , 0];

% Re-parametrizing the state space and using the linearization
r = v / abs(w_ref);
c_s = 1/r;
theta_til = theta_ref - theta;
theta_til_degrees = 180/pi * theta_til;

% Signal of "l"
cross_prod = cross(theta_ref_direction, l_direction);
if cross_prod(3) < 0
   l = l * -1; 
end


% Values of the controllers
% For curves:
% K2 = 3;
% K3 = 2;
% For straight lines
% K2 = 3;
% K3 = 2;

[K2, K3, v] = Gain_tune (x, y);
u1 = - K2*v*l;
u2 =  K3*abs(v)*sin(theta_til);
u = u1+u2;

w = v*cos(theta_til)*c_s/(1-c_s*l) + u;

end