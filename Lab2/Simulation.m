function [ output_args ] = Simulation(v, trajectory, t)
%SIMULATION: Simulates the behaviour of the robot
%   Detailed explanation goes here

for i = 1:length(t)
    
    [x,y,theta] = simulation_read_odometry;
    x = x * 0.01; % m
    y = y * 0.01; % m
    theta = theta * 0.1 * pi / 180; % rad
    
    w = trajectory_following(v, trajectory, x, y, theta);
    
    pioneer_set_controls (Sp,v*100,w*10*180/pi); % confirmar unidades!
    
    pause(t(2)-t(1));
end


end
