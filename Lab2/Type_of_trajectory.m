function [ K2, K3, v, factor, w, sonar, j] = Type_of_trajectory ( x, y, flagSituation)
%Type_of_trajectory: Breaks trajectory into curves and straight lines
%   Detailed explanation goes here

figure(3)
factor = 7;
w = 0; sonar = 0;
if y < 0.30*3 && x < 4 * 0.30 % straight line
    v = 3.5;
    w = 0; K2 = 0; K3 = 0; factor = NaN; j = 1;
    
    rectangle('Position',[0 0 0.30*3 4*0.30],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
          
elseif y < 0.30*4 && x > 4*0.30 && x < 3.826 % curve zone
    v = 3.5;
    r = 0.4 * 4;
    w = v/r; K2 = 0; K3 = 0; factor = NaN; j = 2;
    rectangle('Position',[0 4*0.30 0.30*4 3.826-4*0.30],'LineStyle','--',...
        'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 0.30*4 && y < 3.45+0.19 && x > 5*0.30 && x < 3.826 %straight line
    v = 3.5;
    w = 0; K2 = 0; K3 = 0; factor = NaN; j = 3;
    rectangle('Position',[0.30*4 5*0.30 3.45+0.19-0.30*4 3.826-0.30*5],'LineStyle','--',...
        'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 3.45+0.19 && y < 5.118 && x < 3.826 % straight line
    j = 4;
    v = 3;
    K2 = 3*v;
    K3 = 1*v; %1.5
    rectangle('Position',[3.45+0.19 0 5.118-3.45+0.19 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 5.118 && y < 16.5 && x < 3.826 % straight line
    j = 5;
    if y > 6
        %disp('Comecei sonares')
        sonar = 1;
    end
    v = 3.5; % tested in 11/05 
    K2 = 2*v;
    K3 = 1*v;
    rectangle('Position',[5.118 0 16.5-5.118 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 16.5 && y < 17.6 && x < 3.826 % straight line
    j = 6;
    v = 2.5; % 2.5
    K2 = 1.2*v; %1
    K3 = 0.8*v;
    rectangle('Position',[16.5 0 17.6-16.5 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 17.6 && y < 19.45 && x < 3.99 || flagSituation==1% curve
    j = 7;
    %v = 1.5161;
    v = 2;
    r = 1;
    w = -v/r; factor = NaN; K2 = 0; K3 = 0;
    rectangle('Position',[17.6 0 19.45-17.6 3.99],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 18.03 && y < 19.45 && x > 3.99 && x < 5.5 % straight line
    j = 8
    v = 2.5;
    K2 = 4*v;
    K3 = 2*v;
    rectangle('Position',[18.03 3.99  19.45-18.03 5.5-3.99],'LineStyle','--',...
        'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 18.03 && y < 19.45 && x > 5.5 && x < 15.57 % straight line
    j = 9
    v = 3.5;
    K2 = 0.1;%4*v;
    K3 = 0.01;%2*v;
    rectangle('Position',[18.03 5.5  19.45-18.03 15.57-5.5],'LineStyle','--',...
        'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 18.03 && y < 19.45 && x > 15.57 && x < 16.07 % straight line
    j = 10;
    v = 2.5;
    K2 = 1.2*v;
    K3 = 0.8*v;
    rectangle('Position',[18.03 15.57  19.45-18.03 16.07-15.57],'LineStyle','--',...
        'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 18.03 && y < 19.5 && x > 16.07 && x < 17.9 % curve
    j = 10;
    v = 2;
    r = 1;
    w = -v/r; factor = NaN; K2 = 0; K3 = 0;
    rectangle('Position',[18.03 16.07 19.5-(18.03) 17.9-16.07],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 4.523 && y < 18.03 && x > 16.23 && x < 17.9 % straight line
    j = 11;
    v = 3.5;
    K2 = 2*v;
    K3 = 2*v;
    rectangle('Position',[4.523 16.23 (18.03-4.523) (17.9-16.23)],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
else
    v = 2;
    K2 = 0.01*v;
    K3 = 0.4*v;
    warning('Trajectory not feasible')
end

end