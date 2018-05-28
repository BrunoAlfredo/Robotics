function [theta_real, corr_flag, type, x_real] = sonar_correction (x,y, theta, x_ref,y_ref,j,gradSensors,i,T, sonar)
%sonar_correction: correct odometry using sonars
%   corr_flag -> para só mandar o sinal de correção uma vez



% correction in x (1st and 3rd corridor)
% two sonar area
type = '.';
a = 5.5; b = 6;
a13 = 16.7;  a14 = 17.3;
if (y > a && y <b && j == 5)% || (y > a13 && y < a14 && j == 13)
%     desvio = (sonar(1) + sonar(8))/2;
%     x_real = x_ref + desvio;
%     y_real = y_ref;

    % corrects theta
    psi_real_8 = abs(atan2(gradSensors(i,8), T)); 
    psi_real_1 = abs(atan2(gradSensors(i,1), T));
    psi_real = (psi_real_8 + psi_real_1)/2;
    if gradSensors(i,1) > 0 && gradSensors(i,8) < 0 % right is growing
        psi_real = psi_real * -1;
    end
    theta_real = psi_real + pi/2; %pi/2 passa para theta
    corr_flag = 0;
    type = 'x';
    
    
    % corrects x
    % left and right factors
%     left = sonar(1)/(sonar(1)+sonar(8)); %right = sonar(8)/(sonar(1)+sonar(8));
%     
%     x_real = (3.45 + (3.986 - 3.45)/2) * (1-left);%
    
    
elseif (y > b && j == 5)% || (y > a14 && j == 13)
    type = 'o';
    corr_flag = 1; 
    theta_real = 0;
else
    theta_real = 0;
    corr_flag = 0;
end

end

