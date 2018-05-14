function RealRobot(mac, v, trajectory,t)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

% port initialization
if mac
    Sp = serial_port_start('/dev/tty.usbserial');
else
    
end
pioneer_init(Sp);

for i = 1:length(t)
    
    [x,y,theta] = pioneer_read_odometry;
    x = x * 0.01; % m
    y = y * 0.01; % m
    theta = theta * 0.1 * pi / 180; % rad
    
    w = trajectory_following(v, trajectory, x, y, theta);
    
    pioneer_set_controls (Sp, v*100, w*10*180/pi); % confirmar unidades!
    
    pause(t(2)-t(1));
end

end


