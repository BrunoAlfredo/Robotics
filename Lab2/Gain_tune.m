function [ K2, K3, v ] = Type_of_trajectory ( x, y )
%Gain_tune Breaks trajectory into curves and stright lines
%   Detailed explanation goes here

figure(3)
if y < 4.5 && x < 3.826 % curve zone
    v = 1.5;
    K2 = 3;
    K3 = 2;
    rectangle('Position',[0 0 4.5 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 4.5 && y < 17.25 && x < 3.826 % straight line
    v =2;
    K2 = 0.01;
    K3 = 0.2;
    rectangle('Position',[4.5 0 17.25-4.5 3.826],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
elseif y > 17.25 && y < 18.85 && x < 3.79 % curve
    v = 0.5;
    K2 = 5;
    K3 = 2;
    rectangle('Position',[17.25 0 18.85-17.25 3.79],'LineStyle','--',...
              'EdgeColor', [0.8, 0.8, 0.8])
else
    v = 0.5;
    K2 = 3;
    K3 = 2;
    warning('Trajectory not feasible');
end

end

