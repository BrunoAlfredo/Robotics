function theta = InverseKinematics(alpha,beta,gama,x,y,z)

ZERO = 1e-8;
% Getting the convention matrix
firstLine = [cos(alpha)*cos(gama) - sin(alpha)*cos(beta)*sin(gama) ...
    -cos(alpha)*sin(gama) - sin(alpha)*cos(beta)*cos(gama) ...
    sin(alpha)*sin(beta) x];
secondLine = [sin(alpha)*cos(gama) + cos(alpha)*cos(beta)*sin(gama) ...
    -sin(alpha)*sin(gama) + cos(alpha)*cos(beta)*cos(gama) ...
    -cos(alpha)*sin(beta) y];
thirdLine = [sin(beta)*sin(gama) sin(beta)*cos(gama) cos(beta) z];
fourthLine = [0 0 0 1];
conventionMatrixT06 = [firstLine; secondLine; thirdLine; fourthLine];

% Getting theta1
theta = pi/2 + atan2(conventionMatrixT06(2,1),conventionMatrixT06(1,1));
theta1 = [theta; theta + pi];
%theta = [theta; theta; theta + pi; theta + pi];

% Getting the position of joint 5 in the world frame
posJoint5toFrame6 = [0;0;-20e-3];
transformation = conventionMatrixT06*[posJoint5toFrame6;1];
posJoint5toFrame0 = transformation(1:3);

theta3 = [];
theta2 = [];
% Getting theta3 and theta2
for i = 1:length(theta1)
  height5NotTotal = abs(posJoint5toFrame0(3)) - 99e-3*posJoint5toFrame0(3)/abs(posJoint5toFrame0(3));
  if i == 1
     distance5NotTotal = sqrt(posJoint5toFrame0(1)^2 + posJoint5toFrame0(2)^2) - 25e-3;
  else
     distance5NotTotal = sqrt(posJoint5toFrame0(1)^2 + posJoint5toFrame0(2)^2) + 25e-3; 
  end
  %distance5NotTotal = 0; test when there is no triangule
  a1 = 120e-3;
  a2 = sqrt((120e-3)^2 + (21e-3)^2);
  %height5NotTotal = a1 + a2; test when there is no triangule
  arg = (-height5NotTotal^2 - distance5NotTotal^2 + a1^2 + a2^2)/(2*a1*a2);
  if abs(arg) > 1 % if cosine gives a value bigger than +-1
    warning('The point is not in the range of the arm in this possible configuration')
    continue
  end
  psi = atan(120e-3/21e-3);
  if i == 1
    theta3aux = pi - psi - acos(arg);
  else
    theta3aux = -(pi - psi - acos(arg)); % - because the frame change 
  end
  theta3 = [theta3; theta3aux; -theta3aux + pi];
 
  centralAngle = atan2(height5NotTotal,distance5NotTotal);
  arg = (height5NotTotal^2 + distance5NotTotal^2 + a1^2 - a2^2)/...
      (2*a1*sqrt(height5NotTotal^2 + distance5NotTotal^2));
  fi = acos(arg);
  if i == 1
    theta2nd = pi/2 + centralAngle - fi;
    theta2st = pi/2 - centralAngle - fi;
  else
    theta2nd = -(pi/2 + centralAngle - fi);
    theta2st = -(pi/2 - centralAngle - fi); % - because the frame change 
  end
  theta2 = [theta2; theta2st ; theta2nd];
end

theta = [theta1(1) theta2(1) theta3(1); theta1(1) theta2(2) theta3(2);
    theta1(2) theta2(3) theta3(3); theta1(2) theta2(4) theta3(4)];
theta = theta*180/pi;
%distance for theta 3: 120mm

% Getting theta4

% Getting theta5

% Getting theta6
end

