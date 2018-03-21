theta = sym('theta',[1 6]);
L = [25e-3 99e-3 120e-3 21e-3 0 0 195e-3 20e-3];
T01 = [cos(theta(1)) -sin(theta(1)) 0 0;sin(theta(1)) cos(theta(1)) 0 0;...
         0 0 1 L(2); 0 0 0 1];
T12 = [cos(theta(2)) -sin(theta(2)) 0 -L(1);0 0 -1 0;...
         sin(theta(2)) cos(theta(2)) 0 0; 0 0 0 1];
T23 = [sin(theta(3)) -cos(theta(3)) 0 L(3);cos(theta(3)) sin(theta(3)) 0 0;...
         0 0 1 0; 0 0 0 1];
T34 = [cos(theta(4)) -sin(theta(4)) 0 L(4);0 0 1 0;...
         -sin(theta(4)) -cos(theta(4)) 0 0; 0 0 0 1];
T45 = [0 -1 0 0; 0 0 -1 0; 1 0 0 0; 0 0 0 1];
T56 = [sin(theta(5)) cos(theta(5)) 0 L(7); -cos(theta(5)) sin(theta(5)) 0 0;...
         0 0 1 0; 0 0 0 1];
T67 = [cos(theta(6)) -sin(theta(6)) 0 0; 0 0 1 L(8);...
         -sin(theta(6)) -cos(theta(6)) 0 0; 0 0 0 1];

T02 = simplify(T01*T12);
T03 = simplify(T02*T23);
T04 = simplify(T03*T34);
T05 = simplify(T04*T45);
T06 = simplify(T05*T56);
T07(theta) = simplify(T06*T67);

T07(0,0,0,0,0,0)
