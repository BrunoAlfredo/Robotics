function [x_real, y_real, corr_flag] = sonar_correction (x,y, x_ref,y_ref,j,sensors)
%sonar_correction: correct odometry using sonars
%   Detailed explanation goes here



% correction in x (1st and 3rd corridor)
% two sonar area
if y > 5.7 && y < 6.7 && j == 5
    desvio = (sonar(1) + sonar(8))/2;
    x_real = x_ref + desvio;
    y_real = y_ref;
elseif y > 6.7 && j == 5
    corr_flag = 1; 
end

end

