%% Direct Kinematics

theta = sym('theta',[1 6]);
L = [25e-3 99e-3 120e-3 21e-3 0 0 120e-3 20e-3];
T01 = [cos(theta(1)) -sin(theta(1)) 0 0;sin(theta(1)) cos(theta(1)) 0 0;...
         0 0 1 L(2); 0 0 0 1];
T12 = [-sin(theta(2)) -cos(theta(2)) 0 -L(1);0 0 -1 0;...
         cos(theta(2)) -sin(theta(2)) 0 0; 0 0 0 1];
T23 = [cos(theta(3)) -sin(theta(3)) 0 L(3);sin(theta(3)) cos(theta(3)) 0 0;...
         0 0 1 0; 0 0 0 1];
T34 = [cos(theta(4)) -sin(theta(4)) 0 L(4);0 0 1 0;...
         -sin(theta(4)) -cos(theta(4)) 0 0; 0 0 0 1];
        
T45 = [0 1 0 0; -1 0 0 0; 0 0 1 L(7); 0 0 0 1];

T56 = [cos(theta(6)) -sin(theta(6)) 0 0; cos(theta(5))*sin(theta(6)) cos(theta(5))*cos(theta(6)) -sin(theta(5)) -sin(theta(5))*20e-3;...
         sin(theta(6))*sin(theta(5)) cos(theta(6))*sin(theta(5)) cos(theta(5)) cos(theta(5))*20e-3; 0 0 0 1];

%T01(theta) = T01;
T02(theta) = simplify(T01*T12);
T03(theta) = simplify(T02*T23);
T04(theta) = simplify(T03*T34);
T05(theta) = simplify(T04*T45);
T06(theta) = simplify(T05*T56)

T06(0,0,0,0,0,0);

%% Inverse Kinematics
%orientation = sym('orientation',[1 3]);
%position = sym('position',[1 3]);
% baseT = [cos(orientation(1))*cos(orientation(3))-sin(orientation(1))*cos(orientation(2))*sin(orientation(3))...
%     -cos(orientation(1))*sin(orientation(3))-sin(orientation(1))*cos(orientation(2))*cos(orientation(3)) ...
%     sin(orientation(1))*sin(orientation(2)) position(1);...
%     sin(orientation(1))*cos(orientation(3))+cos(orientation(1))*cos(orientation(2))*sin(orientation(3))...
%     -sin(orientation(1))*sin(orientation(3))+cos(orientation(1))*cos(orientation(2))*cos(orientation(3))...
%     -cos(orientation(1))*sin(orientation(2)) position(2);...
%     sin(orientation(2))*sin(orientation(3)) sin(orientation(2))*cos(orientation(3)) ...
%     cos(orientation(2)) position(3); 0 0 0 1];
T13(theta) = simplify(T12*T23);
T14(theta) = simplify(T13*T34);
T15(theta) = simplify(T14*T45);
T16(theta) = simplify(T15*T56);

T35(theta) = simplify(T34*T45);
T36(theta) = simplify(T35*T56);

%T45(theta) = simplify();