function theta = InverseKinematics(alpha,beta,gama,x,y,z)

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
theta = [theta; theta; theta + pi; theta + pi];

% Getting theta3
posJoint5toFrame6 = [0;0;-20e-3];
transformation = conventionMatrixT06*[posJoint5toFrame6;1];
posJoint5toFrame0 = transformation(1:3);
height5 = posJoint5toFrame0(3) - 99e-3;
distance5 = sqrt(posJoint5toFrame0(1)^2 + posJoint5toFrame0(2)^2) - 25e-3;
a1 = 120e-3;
a2 = sqrt((195e-3)^2 + (21e-3)^2);

arg = (-height5^2 - distance5^2 + a1^2 + a2^2)/(2*a1*a2);
if abs(arg) > 1 % if cosine gives a value bigger than +-1
  warning('The point is not in the range of the arm')
  return
end
psi = atan(195e-3/21e-3);
theta3 = pi - psi - acos(arg);
theta3 = [theta3; -theta3];
%theta = completar depois de fazer o theta2 


%caso em que não ha triangulo

%distance for theta 3: 120mm

% Getting theta2
a1 = sqrt((99e-3)^2+(25e-3)^2);
a2 = sqrt(height5^2 + distance5^2);
arg = (-height5^2 - distance5^2 + a1^2 + a2^2)/(2*a1*a2);
if abs(arg) > 1 % if cosine gives a value bigger than +-1
  warning('The point is not in the range of the arm')
  return
end

%caso em que não ha triangulo

% Getting theta4

% Getting theta5

% Getting theta6
end

