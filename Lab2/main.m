%% Lab 2 - Robótica

%% main

clear
close all


% Simulação ou realidade?
real = false;
% Mac ou windows?
mac = true;

% Declaração de variáveis
Nt = 500; % nº de elementos do vetor dos tempos
t_final = 15; % s
x_final = 15; % m
y_final = 10; % m
t = linspace(0, t_final, Nt)';
Nx = x_final * 100;
Ny = y_final * 100;
w = zeros(Nt, 1);
Np = 1000; % nº de pontos do vetor de trajetória

% Trajectory
[t_ref, x_ref, y_ref, theta_ref, w_ref] = trajectory_generator(Np);
trajectory = [t_ref, x_ref, y_ref, theta_ref, w_ref];


% Simulation or real robot?
if real
   RealRobot(mac,trajectory, t);
else
   Simulation(trajectory, t);
end