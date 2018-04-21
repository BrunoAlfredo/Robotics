%% Lab 2 - Rob�tica

%% main

% Simula��o ou realidade?
real = 1;
% Mac ou windows?
mac = 1;

% Declara��o de vari�veis
Nt = 1000;
t_final = 10;
x_final = 15;
y_final = 10;
t = linspace(0, t_final, Nt);
Nx = x_final * 100;
Ny = y_final * 100;
space = zeros(Ny, Nx); % resolu��o de 1cm

% Trajet�ria
% Defini��o de uma trajet�ria: spline, pchip, etc
trajectory = zeros(Ny, Nx);
trajectory(150,:) = 1;

% Simula��o ou robot real?
if real
   RealRobot(mac);
else
   Simulation(t, space, trajectory);
end