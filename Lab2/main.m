%% Lab 2 - Robótica
%% main

clear
close all

% Simultation or reality?
real = 1;
% Mac or windows?
mac = 1;

if real == 1
    delete(timerfindall);
    if mac == 1
        Sp = serial_port_start('/dev/tty.usbserial');
    else
        Sp = serial_port_start('COM3');
    end
    pioneer_init(Sp);
end

% Trajectory
trajectory = trajectory_generator;

% Simulation or real robot?
if real == 1
    RealRobot(trajectory, Sp);
    if mac == 1
        Sp = serial_port_stop('/dev/tty.usbserial');
    else
        Sp = serial_port_stop('COM3');
    end
else
   Simulation(trajectory);
end