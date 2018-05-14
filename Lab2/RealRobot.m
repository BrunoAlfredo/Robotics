function RealRobot(trajectory,Sp)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

global flagUpdateRobot;
flagUpdateRobot = 0;
T = 0.08; % period of the timer
v_vec = [];
w_vec = [];
x_vec = [];
y_vec = [];
theta_vec = [];
sensors =[];
  
vec = pioneer_read_odometry;
x = vec(1);
y = vec(2);
theta = vec(3);

x = x * 0.001; % m
x_vec = [x_vec; x];
y = y * 0.001; % m
y_vec = [y_vec; y];
theta = theta * 0.1 * pi / 180; % rad
theta_vec = [theta_vec; theta];
[w,v, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta);
w_vec = [w_vec; w]; 

% Activate the timer of the comands to send to the robot
% sendMoveTimer = timer('Period', T, 'ExecutionMode', 'fixedRate');
% sendMoveTimer.StartFcn = @starting;
% sendMoveTimer.TimerFcn=@updateRobot;
% start(sendMoveTimer)

pioneer_set_controls (Sp, round(v*100), round(w*180/pi*0.1)); % confirmar unidades!
j = 0;
while (1) 
  j = j+1;
  
  vec = pioneer_read_odometry;
  vec = [0 0 0];
  x = vec(1);
  y = vec(2);
  theta = vec(3);
  x = x * 0.001; % m
  x_vec = [x_vec; x];
  y = y * 0.001; % m
  y_vec = [y_vec; y];
  theta = theta * 0.1 * pi / 180; % rad
  figure(4)
  subplot(3,1,1), plot(j,x, 'x'), title('x'), hold on
  subplot(3,1,2), plot(j,y, 'x'), title('y'), hold on
  subplot(3,1,3), plot(j,theta, 'x'), title('\theta'), hold on
  figure(3), plot(y,x, 'x','Color',[1, 0.7, 0])
  plot(y_ref, x_ref,'x','Color', 'g') 
  theta_vec = [theta_vec; theta];
  [w,v, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta);
 
  w_vec = [w_vec; w];
  v_vec = [v_vec; v];
  
  %aux = pioneer_read_sonars;
%   if (sensors(1)<500||sensors(8)<500||sensors(4)<500||sensors(5)<500)
%       %stop(sendMoveTimer)
%       break
%   end
  %pause(0.08)
  if flagUpdateRobot==1
    pioneer_set_controls (Sp, round(v*100), round(w*180/pi*0.1));
    flagUpdateRobot = 0;
  end
  %sensors = [sensors; aux];
end

pioneer_set_controls(Sp,0,0);

end


function starting(obj, event)
txt1 = ' event occurred at ';
event_type = event.Type;
event_time = datestr(event.Data.time);

msg = [event_type txt1 event_time];
disp(msg)
disp("Starting the motion of the robot...")
end

function updateRobotFlag(Obj,event)
    global flagUpdateRobot;
    flagUpdateRobot = 1;
end


