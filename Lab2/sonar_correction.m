function [psi_real, corr_flag, type] = sonar_correction (x,y, theta, x_ref,y_ref,j,gradSensors,i,T)
%sonar_correction: correct odometry using sonars
%   corr_flag -> para só mandar o sinal de correção uma vez



% correction in x (1st and 3rd corridor)
% two sonar area
type = '.';
if y > 5.7 && y < 6.7 && j == 5
%     desvio = (sonar(1) + sonar(8))/2;
%     x_real = x_ref + desvio;
%     y_real = y_ref;
    psi_real_8 = abs(atan2(gradSensors(i,8), T)); 
    psi_real_1 = abs(atan2(gradSensors(i,1), T));
    psi_real = (psi_real_8 + psi_real_1)/2;
    if gradSensors(i,1) > 0 && gradSensors(i,8) < 0 % right is growing
        psi_real = psi_real * -1;
    end
    psi_real = psi_real + pi/2; %pi/2 passa para theta
    corr_flag = 0;
    type = 'x';
elseif y > 6.7 && j == 5
    type = 'o';
    corr_flag = 1; 
    psi_real = 0;
else
    psi_real = 0;
    corr_flag = 0;
end

end

