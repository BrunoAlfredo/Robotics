function [w,v, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta)
%trajectory_following: follows the trajectory
%   input: v -> constant, trajectory -> constant, d = 0?
% .        w_actual -> present angular velocity
%   output: w_next -> next angular velocity to meet trajectory

[K2, K3, v_max, factor, w_open] = Type_of_trajectory (x, y);


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
   x_ref = 0; y_ref = 0; v = v_max;
   return  
end
x_ref = x_ref_vector(i_ref);
y_ref = y_ref_vector(i_ref);
theta_ref = theta_ref_vector(i_ref);
w_ref = w_ref_vector(i_ref);
theta_ref_direction = [x_ref - x_ref_vector(i_ref-1), y_ref - y_ref_vector(i_ref-1) , 0];
l_direction = [x - x_ref , y - y_ref , 0];

% open-loop
if isnan(factor)
   w = w_open; v = v_max;
   return
end

% Relation between v and w
v =  abs(1 / ((w_ref/(2*pi))*factor));
if v > v_max
   v = v_max; 
end

% Re-parametrizing the state space and using the linearization
r = v / w_ref;
c_s = 1/r;
theta_til = theta_ref - theta;
theta_til_degrees = 180/pi * theta_til; % for debug

% Signal of "l"
cross_prod = cross(theta_ref_direction, l_direction);
if cross_prod(3) < 0
   l = l * -1; 
end


u1 = - K2*v*l;
u2 =  K3*abs(v)*sin(theta_til);
u = u1+u2;


w = v*cos(theta_til)*c_s/(1-c_s*l) + u;
%w = w_ref + u;



% ang_speed_limit = 45; % degrees per second

ang_speed_limit = 55; % degrees per second

if abs(w * 180 / pi) > ang_speed_limit
   %warning('could not perform such high angular speed')
   w = ang_speed_limit * pi / 180 * sign(w);
end

end