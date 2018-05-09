function RealRobot(mac, v, trajectory)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

% % port initialization
if mac
    Sp = serial_port_start('/dev/tty.usbserial');
else
    Sp = serial_port_start('COM5');
end

T = 1; % period of the timer
pioneer_init(Sp);
%delete(timerfindall);

w_vec = [];
x_vec = [];
y_vec = [];
theta_vec = [];
aux1 =[];
  
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

t = timer('Period', T, 'ExecutionMode', 'fixedRate',...
    'TimerFcn','[]=updateRobot(v,trajectory)');
start(t)

t.StartFcn = {@my_callback_fcn, 'Starting moving the robot'};
pioneer_set_controls (Sp, round(v*100), round(wrapTo2Pi(w)*180/pi)); % confirmar unidades!

while (1)  
    
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
  
  aux = pioneer_read_sonars
  if (aux(1)<500||aux(8)<500||aux(4)<500||aux(5)<500)
      stop(t)
      break
  end
  %aux1 = [aux1; aux];
end

pioneer_set_controls(Sp,0,0);

end


function my_callback_fcn(obj, event, text_arg)

txt1 = ' event occurred at ';
txt2 = text_arg;

event_type = event.Type;
event_time = datestr(event.Data.time);

msg = [event_type txt1 event_time];
disp(msg)
disp(txt2)
end

function [] = updateRobot(v,w,Sp)
    pioneer_set_controls (Sp, round(v*100), round(wrapTo2Pi(w)*180/pi)); % confirmar unidades!
end


