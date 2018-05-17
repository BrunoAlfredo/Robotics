function [ w_correction, sonar ] = sonar_correction
%sonar_correction: correct odometry using sonars
%   Detailed explanation goes here

incremento = 0.6;
sonar = pioneer_read_sonars;

if sonar(1) > 3000 || sonar(8) > 3000
   w_correction = 0;
   return 
end
if sonar(1) > sonar (8) % est� com demasiada distancia � esquerda
    % andar para a direita
    w_correction = incremento * abs(sonar(1)-sonar(8))/5000; 
elseif sonar(1) < sonar (8) % est� com demasiada distancia � direita
    % andar para a esquerda
    w_correction = - incremento * abs(sonar(1)-sonar(8))/5000;
else
    w_correction = 0;
end

end

