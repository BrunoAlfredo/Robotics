%% Lab 2 - Rob�tica
%% main

clear
close all

% Simula��o ou realidade?
real = 1;
% Mac ou windows?
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

% Declara��o de vari�veis
Nt = 188; % n� de elementos do vetor dos tempos
t_final = 10; % s
x_final = 15; % m
y_final = 10; % m
t = linspace(0, t_final, Nt)';
Nx = x_final * 100;
Ny = y_final * 100;
Np = 1000; % n� de pontos do vetor de trajet�ria

% Trajectory
[t_ref, x_ref, y_ref, theta_ref, w_ref] = trajectory_generator(Np);
trajectory = [t_ref, x_ref, y_ref, theta_ref, w_ref];


% Simulation or real robot?
if real
   w_vec = RealRobot(trajectory, Sp);
else
   Simulation(trajectory, t);
end