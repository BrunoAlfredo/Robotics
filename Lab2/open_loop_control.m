function [ w, v ] = open_loop_control( trajectory, x, y, theta, w_prev, real )
%open_loop_control: Sends open loop commands to the robot
%   Detailed explanation goes here

if real
   w = w_ref;
else
    % simulação do open loop
end

end

