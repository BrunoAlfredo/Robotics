function [ output_args ] = Simulation(vt, trajectory, t)
%SIMULATION: Simulates the behaviour of the robot
%   Detailed explanation goes here
options=simset('SrcWorkspace','current','DstWorkspace','current');
xF=[];
yF=[];
thetaF=[];
x0 = 0;
y0 = 0;
theta0 = 0;
wt = 0;
for i = 1:length(t)    
    v = timeseries(vt);
    w = timeseries(wt);
    T = t(2)-t(1);
    sim('Unicycle.slx',T,options);
    x0 = x(end);
    y0 = y(end);
    theta0 = theta(end);
    xF = [xF; x];
    yF = [yF; y];
    thetaF = [thetaF ; theta];
    
    x = x0;
    y = y0;
    theta = theta0;
        
    wt = trajectory_following(vt, trajectory, x, y, theta);
    wt = round(wrapToPi(wt)*180/pi);
    wt = wt*pi/180;
    i
end
figure;
subplot(3,1,1), plot(xF);
title('X')
subplot(3,1,2), plot(yF);
title('Y')
subplot(3,1,3), plot(thetaF);
title('Theta')
figure, plot(yF,xF,'x')
set(gca,'Ydir','reverse')

end
