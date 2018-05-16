function [ K2, K3, v, factor, w] = Type_of_trajectory ( x, y )
%Type_of_trajectory: Breaks trajectory into curves and straight lines
%   Detailed explanation goes here

figure(3)
factor = 7;
w = 0;
if y < 0.30*3 && x < 5 * 0.30 % straight line
    v = 3.5;
    w = 0; K2 = 0; K3 = 0; factor = NaN;
%     % Pioneer 7
%     K2 = 2*v;
%     K3 = 2*v;
%     % Pioneer 6
%     K2 = 2*v;
%     K3 = 0.7*v;
    rectangle('Position',[0 0 2.855 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
          
elseif y < 0.30*3 && x > 5*0.30 && x < 3.826 % curve zone
    v = 3.5;
    r = 0.30 * 4;
    w = v/r; K2 = 0; K3 = 0; factor = NaN;
elseif y > 0.30*3 && y < 2.855 && x > 5*0.30 && x < 3.826 %stright line
    v = 3.5;
    w = 0; K2 = 0; K3 = 0; factor = NaN;
elseif y > 2.855 && y < 4.5 && x < 3.826 % straight line
    disp('Comecei closed loop')
    v = 2.5;
    K2 = 1.5*v;
    K3 = 3*v;
    rectangle('Position',[2.855 0 4.5-2.855 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 4.5 && y < 16.5 && x < 3.826 % straight line
    v = 2.5; % tested in 11/05 
    K2 = 1.5*v;
    K3 = 0.8*v;
    rectangle('Position',[4.5 0 16.5-4.5 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 16.5 && y < 17.25 && x < 3.826 % straight line
    v = 2.5;
    K2 = 0.8*v;
    K3 = 0.8*v;
    rectangle('Position',[16.5 0 17.25-16.5 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 17.25 && y < 18.85 && x < 3.79 % curve
    %v = 1.5161;
    v = 2;
    r = 1;
    w = -v/r; factor = NaN; K2 = 0; K3 = 0;
%     K2 = 40*v;
%     K3 = 26*v;
%     K2 = 6*v;
%     K3 = 5*v;
    rectangle('Position',[17.25 0 18.85-17.25 3.79],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 17.64 && y < 18.85 && x > 3.79 && x < 16.23 % straight line
    v = 3.5;
    K2 = 0.8*v;
    K3 = 2*v;
    rectangle('Position',[17.64 3.826  18.85-17.64 16.23-3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 17.64 && y < 18.85 && x > 16.23 && x < 17.9 % curve
%     v = 1.516;
%     factor = 4;
%     K2 = 6*v;
%     K3 = 5*v;
    v = 2;
    r = 0.8;
    w = -v/r; factor = NaN; K2 = 0; K3 = 0;
    rectangle('Position',[17.64 16.23 18.85-17.64 17.9-16.23],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 4.523 && y < 17.64 && x > 16.23 && x < 17.9 % straight line
    v = 3.5;
    K2 = 0.8*v;
    K3 = 2*v;
    rectangle('Position',[4.523 16.23 (17.64-4.523) (17.9-16.23)],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
else
    v = 2;
    K2 = 0.01*v;
    K3 = 0.4*v;
    warning('Trajectory not feasible')
end

end