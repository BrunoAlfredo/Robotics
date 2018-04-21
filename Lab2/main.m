%% Lab 2 - Robótica

%% main

% Simulação ou realidade?
real = 1;
% Mac ou windows?
mac = 1;

% Declaração de variáveis
Nt = 1000;
t_final = 10;
x_final = 15;
y_final = 10;
t = linspace(0, t_final, Nt);
Nx = x_final * 100;
Ny = y_final * 100;
space = zeros(Ny, Nx); % resolução de 1cm

% Trajetória
% Definição de uma trajetória: spline, pchip, etc
trajectory = zeros(Ny, Nx);
trajectory(150,:) = 1;

% Simulação ou robot real?
if real
   RealRobot(mac);
else
   Simulation(t, space, trajectory);
end