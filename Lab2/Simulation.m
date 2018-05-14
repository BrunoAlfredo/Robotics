function Simulation(trajectory)
%SIMULATION: Simulates the behaviour of the robot
%   Detailed explanation goes here

% Declaration of simulation variables
Nt = 200; % number of simulation points
t_final = 20;


tr = linspace(0, t_final, Nt)';
options=simset('SrcWorkspace','current','DstWorkspace','current');
xF=[];
yF=[];
thetaF=[];
x0 = 0;
y0 = -0.1;
theta0 = 0;
wt = 0;
figure(3),hold on
posF = zeros(length(tr),3);
wF = zeros(length(tr),1);
wF(1) = 0;
vt = 0.5; % initial velocity
for i = 1:length(tr)
    v = timeseries(vt);
    w = timeseries(wt);
    T = tr(2)-tr(1);
    sim('Unicycle_b.mdl',T,options);
    x0 = x(end);
    y0 = y(end);
    theta0 = theta(end);
    posF(i,:) = [x0 y0 theta0];
    %xF = [xF; x];
    %yF = [yF; y];
    %thetaF = [thetaF ; theta];
    
    x = x0;
    y = y0;
    theta = theta0;
    
    
    [wt,vt, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta);
    
    
    wt = round(wrapToPi(wt)*180/pi);
    wt = wt*pi/180;
    wF(i) = wt;
    waitbar(i/length(tr));
    plot(posF(i,2),posF(i,1),'x','Color', [1, 0.7, 0])
    plot(y_ref, x_ref,'x','Color', 'g')
end
% figure;
% subplot(3,1,1), plot(xF)
% title('X')
% subplot(3,1,2), plot(yF)
% title('Y')
% subplot(3,1,3), plot(thetaF)
% title('Theta')
%figure(3), hold on, plot(posF(:,2),posF(:,1),'x')
 figure, plot(wF)


end