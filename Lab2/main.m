%% Lab 2 - Robótica
%% main

clear
close all

% Simultation or reality?
real = 0;
% Mac or windows?
mac = 1;

if real == 1
    delete(timerfindall);
    if mac == 1
        Sp = serial_port_start('/dev/tty.usbserial');
    else
        Sp = serial_port_start('COM5');
    end
    pioneer_init(Sp);
end

% Trajectory
trajectory = trajectory_generator;

% Simulation or real robot?
if real == 1
   RealRobot(trajectory, Sp);
else
   Simulation(trajectory);
end