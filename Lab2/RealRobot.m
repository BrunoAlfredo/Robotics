function RealRobot(mac, v, trajectory, t)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

% % port initialization
if mac
    Sp = serial_port_start('/dev/tty.usbserial');
else
    
end

pioneer_init(Sp);
%delete(timerfindall);

w_vec = [];
x_vec = [];
y_vec = [];
theta_vec = [];
aux1 =[];
for i = 1:length(t)
    
    vec = pioneer_read_odometry;
    x = vec(1);
    y = vec(2);
    theta = vec(3);
    x = x * 0.01; % m
    x_vec = [x_vec; x];
    y = y * 0.01; % m
    y_vec = [y_vec; y];
    theta = theta * 0.1 * pi / 180; % rad
    theta_vec = [theta_vec; theta];
    w = trajectory_following(v, trajectory, x, y, theta);
    w_vec = [w_vec; w]; 
    pioneer_set_controls (Sp, round(v*100), round(wrapTo2Pi(w)*180/pi)); % confirmar unidades!
    
    aux = pioneer_read_sonars
    if (aux(1) <500)
        break;
    end
    aux1 = [aux1; aux];

    pause(t(2)-t(1));
end

pioneer_set_controls(Sp,0,0);

end


