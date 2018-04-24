clear
close all
v_vec = [20e-3; 20e-3; 0; 20e-3];
w_vec = [0; pi/2; pi/2; 0];
xF=[];
yF=[];
thetaF=[];
x0 = 0;
y0 = 0;
theta0 = 0;
for i=1:4
    v = timeseries(v_vec(i));
    w = timeseries(w_vec(i));
    T = 1;
    sim('Unicycle.slx',T);
    x0 = x(end);
    y0 = y(end);
    theta0 = theta(end);
    xF = [xF; x];
    yF = [yF; y];
    thetaF = [thetaF ; theta];
end

subplot(3,1,1), plot(xF);
title('X')
subplot(3,1,2), plot(yF);
title('Y')
subplot(3,1,3), plot(thetaF);
title('Theta')
figure, plot(yF,-xF,'x')