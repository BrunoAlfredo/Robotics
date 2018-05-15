load('sensors.mat')
figure; 
subplot(2,1,1),hold on,title('Left'),plot(sensors(:,1));
subplot(2,1,2),hold on,title('Right'),plot(sensors(:,8));

figure; 
subplot(2,1,1),hold on,title('Left'),plot(gradSensors(:,1));
subplot(2,1,2),hold on,title('Right'),plot(gradSensors(:,8));