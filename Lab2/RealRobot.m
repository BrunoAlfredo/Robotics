function RealRobot(trajectory,Sp)
%RealRobot: Moves the robot in the lab
%   Detailed explanation goes here

% global flagUpdateRobot;
% flagUpdateRobot = 0;

%wOffset = -(0.08/20/5.08+0.075/20/5.062)/2; % pioneer 4: desvia direita
wOffset = -(0.07/20/5.005+0.0057/20/5.032)/2; % pioneer 7: desvia esquerda

T_mov = 0.1; % period of the moving timer
T_sens = 0.03; % period of the sensors timer
T_odom = 0;

N = 700;
v_vec = zeros(N,1);
w_vec = zeros(N,1);
x_vec = zeros(N,1);
x_noodo = zeros(N,1);
y_vec = zeros(N,1);
y_noodo = zeros(N,1);
theta_vec = zeros(N,1);
sensors = zeros(N,8);
gradSensors= zeros(N,8);
correctSensX = 0;
correctSensY = 0;
correctSensTheta = 0;
flagSituation = 0;
x_real = zeros(N,1);

vec = pioneer_read_odometry;
x = vec(1);
y = vec(2);
theta = vec(3);

x_vec(1) = x*0.001;
x_noodo(1) = x*0.001;
y_vec(1) = y*0.001;
y_noodo(1) = y*0.001; 
theta = theta * 0.1 * pi / 180; % rad
theta_vec(1) = theta;
[w,v, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta,flagSituation);
w_vec(1) = w;
v_vec(1) = v;

% sendMoveTimer = timer('Period', T_mov, 'ExecutionMode', 'fixedRate');
% sendMoveTimer.StartFcn = {@starting,"Starting the motion of the robot..."};
% sendMoveTimer.TimerFcn = @updateRobotFlag;
% readSensorTimer = timer('Period', T_sens, 'ExecutionMode', 'fixedRate');
% readSensorTimer.StartFcn = {@starting,"Staring reading the sonars"};
% readSensorTimer.TimerFcn = @updateSensorFlag;
% start(sendMoveTimer);
% start(readSensorTimer);


pioneer_set_controls (Sp, round(v*100), round(w*180/pi*0.1)); % confirmar unidades!
pause(T_mov);
j = 1;
while (j<N)
    j = j+1;
    
    vec = pioneer_read_odometry;
    sonar = pioneer_read_sonars;
    % colocar ciclo while para por o robot a parar quando houver um obstaculo
    sensors(j,:) = sonar(1:8);
    gradSensors(j,:) = sensors(j,:)-sensors(j-1,:);
        
    %fprintf('(x,y)=(%d,%d),   grad sensor=%d\n',vec(1),vec(2),gradSensors(j,8));
%     if (vec(2)>2.7 && vec(1)<3.826) && gradSensors(end,8)>=2400
%         beep;
%         correctSensY = 3.41 - vec(2);
%     end
    
    % Correct position using odometry
    if (rem(j,120)~=0)
        T_odom = j*T_mov;
    else
        T_odom = 0;
    end

    correctOdoX = -sin(theta_vec(j-1))*sin(wOffset*T_odom)*v_vec(j-1)*T_mov;
    correctOdoY = cos(theta_vec(j-1))*sin(wOffset*T_odom)*v_vec(j-1)*T_mov;
    correctOdoTheta = wOffset*T_odom;   
    %fprintf('OdoX:%f, OdoY:%f, OdoThe:%f\n',correctOdoX,correctOdoY,correctOdoTheta);
    
    % Correct position using sensors
    % corridor for the stairs -> 1st corridor -> distance=6.256 + 1.668 + 3.45
%     if gradSensors(j,8)>1800 && y > 11.374 && y < 11.374+0.5 
%         correctSensY = 11.374 - vec(2)*0.001;
%         disp(correctSensY)
%         disp(vec(2)*0.001)
%     elseif gradSensors(j,8)> 1800 && y > 17.5 && y < 18.5
%          disp('Mudei flag')
%          flagSituation = 1;
%     end
    
    x_noodo(j) = vec(1)*0.001; 
    x = vec(1)*0.001 + correctSensX + correctOdoX;
    y_noodo(j) = vec(2)*0.001;
    y = vec(2)*0.001 + correctSensY + correctOdoY;
    theta = vec(3)*0.1*pi/180 + correctOdoTheta;
    %fprintf('VecX:%f, X:%f, VecY:%f, Y:%f\n',vec(1)*0.001,x,vec(2)*0.001,y);
    x_vec(j) = x;
    y_vec(j) = y;
%     figure(4)
%     subplot(3,1,1), plot(j,x, 'x'), title('x'), hold on
%     subplot(3,1,2), plot(j,y, 'x'), title('y'), hold on
%     subplot(3,1,3), plot(j,theta, 'x'), title('\theta'), hold on
    figure(3), plot(y,x, 'x','Color',[1, 0.7, 0])
    %plot(y_ref, x_ref,'x','Color', 'g')
    theta_vec(j) = theta;
    
    % sonars
    [~,~,~,~,~,sonar_signal,jo] = Type_of_trajectory (x,y);
    type = '.';
    if sonar_signal
        % corrects odometry from sonars
        if corr_flag == 1 && stop_corr == 0
            % remove all zeros from vector
            x_real(x_real == 0) = [];
            y_real(y_real == 0) = [];
            theta_real(theta_real == 0) = [];
            
            x_correction = mean(x_real);
            y_correction = mean(y_real);
            theta_correction = mean(theta_real);
            disp(theta_correction*180/pi);
%             correctSensX = x - x_correction;
%             correctSensY = y - y_correction;
            correctSensTheta = theta_correction - theta; % novo
            
            figure(6), plot(theta_real*180/pi), title('angulo sonares')
            % reallocates vector to get them ready for another correction
            x_real = zeros(N,1);
            y_real = zeros(N,1);
            theta_real = zeros(N,1);
            stop_corr = 1;
        end
        
        % sonar correction
        %dist = norm(x_vec(j)-x_vec(j-1) , y_vec(j)-y_vec(j-1));
        [theta_real(j),corr_flag, type] = ...
            sonar_correction(x,y,theta,x_ref,y_ref,jo,gradSensors,j,T_mov);
    end
    
    figure(5)
    subplot(3,1,1), plot(j,sonar(1),type,'Color','g'), hold on
    subplot(3,1,2), plot(j,sonar(8),type,'Color','b'), hold on
    subplot(3,1,3), plot(j,gradSensors(j,8),type,'Color','r'), hold on
    
    % plots odometry evolution in time
%     figure(4)
%     subplot(3,1,1), plot(j,x, 'x'), title('x'), hold on
%     subplot(3,1,2), plot(j,y, 'x'), title('y'), hold on
%     subplot(3,1,3), plot(j,theta, 'x'), title('\theta'), hold on



    % plots trajectory evolution in time
    plot_trajectory(x,y,sonar)
    %plot(y_ref, x_ref,'x','Color', 'g')
    
    % end of sonar part
    
    
    [w,v, x_ref, y_ref] = trajectory_following(trajectory, x, y, theta,flagSituation);
    flagSituation = 0;
    
    w_vec(j) = w;
    v_vec(j) = v;
    
%     if (y > 3.45)
%         pioneer_set_controls (Sp,0,0);
%     end
    pioneer_set_controls (Sp, round(v*100), round((w)*180/pi*0.1));
    pause(T_mov)
    
%     if flagUpdateRobot==1
%         disp([v w])
%         pioneer_set_controls (Sp, round(v*100), round(w*180/pi*0.1));
%         flagUpdateRobot = 0;
%     end
end

pioneer_set_controls(Sp,0,0);
figure, hold on;
plot(x_noodo,y_noodo,'x');
plot(x_vec,y_vec,'x');
save('sensors.mat', 'gradSensors', 'sensors');
save('simulation.mat','x_vec','y_vec');
legend('sem correçao','com correção');

end


% function starting(obj, event, message)
% 
% txt1 = ' event occurred at ';
% event_type = event.Type;
% event_time = datestr(event.Data.time);
% 
% msg = [event_type txt1 event_time];
% disp(msg)
% disp(message)
% 
% end
% 
% function updateRobotFlag(Obj,event)
% 
% global flagUpdateRobot;
% flagUpdateRobot = 1;
% 
% end
% 
% function updateSensorFlag(Obj,event)
% 
% global flagSensorRobot;
% flagSensorRobot = 1;
% 
% end