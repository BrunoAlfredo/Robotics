function plot_trajectory(x,y,sonar)
%plot_trajectory: plots trajectory
%   Detailed explanation goes here

    
    [~,~,~,~,~,~,j] = Type_of_trajectory (x, y);
    
    figure(3)
    
    % trajetoria do robot
    plot(y,x, 'x','Color',[1, 0.7, 0])
    
    % leitura dos sonares
    if j == 1 || j == 8
        % sonar 1
        plot(y+sonar(1),x, '.','Color','r')
        % sonar 8
        plot(y-sonar(8),x, '.','Color','g')
    elseif j == 5
        % sonar 1
        plot(y,x-sonar(1), '.','Color','r')
        % sonar 8
        plot(y,x+sonar(8),x, '.','Color','g')
    end

end

