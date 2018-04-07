%% Direct Kinematics
clear all
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
T02 = simplify(T01*T12);
T03 = simplify(T02*T23);
T04 = simplify(T03*T34);
T05 = simplify(T04*T45);
T06 = simplify(T05*T56);

%T06(0,0,0,0,0,0);

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
%%
% Singularities
thetaDot = sym('thetaDot',[1 6]);
w11 = T01(1:3,1:3).'*[0;0;0] + [0;0;thetaDot(1)];
w22 = T12(1:3,1:3).'*w11 + [0;0;thetaDot(2)];
w33 = T23(1:3,1:3).'*w22 + [0;0;thetaDot(3)];
w44 = T34(1:3,1:3).'*w33 + [0;0;thetaDot(4)];
w55 = T45(1:3,1:3).'*w44 + [thetaDot(5);0;0]; 
w66 = T56(1:3,1:3).'*w55 + [0;0;thetaDot(6)];
v11 = [0;0;0];
v22 = T12(1:3,1:3).'*(v11 + cross(w11,T12(1:3,4)));
v33 = T23(1:3,1:3).'*(v22 + cross(w22,T23(1:3,4)));
v44 = T34(1:3,1:3).'*(v33 + cross(w33,T34(1:3,4)));
v55 = T45(1:3,1:3).'*(v44 + cross(w44,T45(1:3,4)));
v66 = T56(1:3,1:3).'*(v55 + cross(w55,T56(1:3,4)));
w06 = T06(1:3,1:3)*w66;
v06 = T06(1:3,1:3)*v66;

eqns = [w06(1) == 0, w06(2) == 0, w06(3) == 0];
vars = thetaDot;
[Jo,~] = equationsToMatrix(eqns,vars);
eqns = [v06(1) == 0, v06(2) == 0, v06(3) == 0];
[Jp,~] = equationsToMatrix(eqns,vars);
Jp = simplify(Jp);
Jo = simplify(Jo);
detJo = det(Jo(:,4:end));
detJo = simplify(detJo)

aux = Jp(3,2)*det([Jp(1:2,1) Jp(1:2,3)]);
aux1 = simplify(aux);

au = Jp(3,3)*det(Jp(1:2,1:2));
au1 = simplify(au)

total = aux1 + au1;
detJp(theta) = simplify(total)
detJp(0,0,0,0,0,0)
detJp(pi/3,0,0,0,0,0)
detJp(0,0,0,0,0,-pi/6)
% eqDetJp = detJp == 0;
% posSingularities = solve(eqDetJp,theta)