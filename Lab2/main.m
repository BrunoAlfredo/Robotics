%% Lab 2 - Robótica

%% main

clear
close all


% Velocidade linear constante
v = 2; %m/s 
% Simulação ou realidade?
real = 1;
% Mac ou windows?
mac = 1;

% Declaração de variáveis
Nt = 1000; % nº de elementos do vetor dos tempos
t_final = 10; % s
x_final = 15; % m
y_final = 10; % m
t = linspace(0, t_final, Nt)';
Nx = x_final * 100;
Ny = y_final * 100;
w = zeros(Nt, 1);

% Trajectory
[t_ref, x_ref, y_ref, theta_ref, w_ref] = trajectory_generator;
trajectory = [t_ref, x_ref, y_ref, theta_ref, w_ref];


% Simulation or real robot?
if real
   RealRobot(mac, v, trajectory, t);
else
   Simulation(v, trajectory, t);
end