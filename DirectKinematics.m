function [alpha,beta,gama,x,y,z] = DirectKinematics(theta)

cosBeta = -sin(theta(2) + theta(3))*cos(theta(5)) - cos(theta(2) + ...
    theta(3))*cos(theta(4))*sin(theta(5));
beta = acos(cosBeta);

if sin(beta) ~= 0
  numeratorAlpha = sin(theta(5))*(sin(theta(1))*sin(theta(4)) + ...
      sin(theta(2) + theta(3))*cos(theta(1))*cos(theta(4))) - ...
      cos(theta(2) + theta(3))*cos(theta(1))*cos(theta(5));
  denominatorAlpha =  sin(theta(5))*(cos(theta(1))*sin(theta(4)) - ...
      sin(theta(2) + theta(3))*cos(theta(4))*sin(theta(1))) + ...
      cos(theta(2) + theta(3))*cos(theta(5))*sin(theta(1));
  alpha = atan2(numeratorAlpha,denominatorAlpha);
  
  numeratorGama = cos(theta(2) + theta(3))*cos(theta(6))*sin(theta(4)) - ...
      sin(theta(2) + theta(3))*sin(theta(5))*sin(theta(6)) + cos(theta(2) + theta(3))*...
      cos(theta(4))*cos(theta(5))*sin(theta(6));
  denominatorGama = cos(theta(2) + theta(3))*cos(theta(4))*cos(theta(5))*...
      cos(theta(6)) - sin(theta(2) + theta(3))*cos(theta(6))*sin(theta(5)) -...
      cos(theta(2) + theta(3))*sin(theta(4))*sin(theta(6));
  gama = atan2(numeratorGama,denominatorGama);  
else
  gama = 0;
  numeratorAlpha = cos(theta(5))*sin(theta(6))*(cos(theta(1))*sin(theta(4)) -...
      sin(theta(2) + theta(3))*cos(theta(4))*sin(theta(1))) - cos(theta(6))*...
      (cos(theta(1))*cos(theta(4)) + sin(theta(2) + theta(3))*sin(theta(1))*...
      sin(theta(4))) - cos(theta(2) + theta(3))*sin(theta(1))*sin(theta(5))*sin(theta(6));
  denominatorAlpha = cos(theta(6))*(cos(theta(4))*sin(theta(1)) - ...
      sin(theta(2) + theta(3))*cos(theta(1))*sin(theta(4))) - cos(theta(5))*...
      sin(theta(6))*(sin(theta(1))*sin(theta(4)) + sin(theta(2) + theta(3))*...
      cos(theta(1))*cos(theta(4))) - cos(theta(2) + theta(3))*cos(theta(1))*...
      sin(theta(5))*sin(theta(6));
  alpha = atan2(numeratorAlpha,denominatorAlpha); 
end

x = (sin(theta(5))*(sin(theta(1))*sin(theta(4)) + sin(theta(2) + theta(3))*...
    cos(theta(1))*cos(theta(4))))/50 - (3*cos(theta(2) + theta(3))*cos(theta(1)))/25 -...
    (cos(theta(1))*(21*sin(theta(2) + theta(3)) + 120*sin(theta(2)) + 25))/1000 -...
    (cos(theta(2) + theta(3))*cos(theta(1))*cos(theta(5)))/50;
y = -(sin(theta(1))*(21*sin(theta(2) + theta(3)) + 120*sin(theta(2)) + 25))/1000 -...
    (sin(theta(5))*(cos(theta(1))*sin(theta(4)) - sin(theta(2) + theta(3))*...
    cos(theta(4))*sin(theta(1))))/50 - (3*cos(theta(2) + theta(3))*sin(theta(1)))/25 -...
    (cos(theta(2) + theta(3))*cos(theta(5))*sin(theta(1)))/50;
z = (21*cos(theta(2) + theta(3)))/1000 - (3*sin(theta(2) + theta(3)))/25 +...
    (3*cos(theta(2)))/25 - (sin(theta(2) + theta(3))*cos(theta(5)))/50 - ...
    (cos(theta(2) + theta(3))*cos(theta(4))*sin(theta(5)))/50 + 99/1000;

end

