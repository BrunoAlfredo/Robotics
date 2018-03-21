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
conventionMatrixT06 = [firstLine;secondLine;thirdLine;fourthLine];

% Getting theta1
theta = pi/2 + atan2(conventionMatrixT06(2,1),conventionMatrixT06(1,1));
theta = [theta; theta + pi];

% Getting theta2
posJoint5toFrame6 = [0;0;-20e-3];
transformation = conventionMatrixT06*[posJoint5toFrame6;1];
posJoint5toFrame0 = transformation(1:3);

%caso em que não ha triangulo

%distance for theta 3: 120mm

% Getting theta3

%caso em que não ha triangulo

% Getting theta4

% Getting theta5

% Getting theta6
end

