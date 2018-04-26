function RealRobot(mac, v, trajectory, t)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

% % port initialization
% if mac
%     Sp = serial_port_start('/dev/tty.usbserial');
% else
%     
% end

%pioneer_init(Sp);
%delete(timerfindall);

w_vec = [];
for i = 1:length(t)
    
    vec = pioneer_read_odometry;
    x = vec(1);
    y = vec(2);
    theta = vec(3);
    x = x * 0.01; % m
    y = y * 0.01; % m
    theta = theta * 0.1 * pi / 180; % rad
    
    w = trajectory_following(v, trajectory, x, y, theta);
    w_vec = [w_vec; w]; 
    pioneer_set_controls (Sp, v*100, w*180/pi); % confirmar unidades!
    
    pause(t(2)-t(1));
end

end


