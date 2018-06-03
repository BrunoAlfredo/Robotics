%% Lab 2 - Robótica
%% main

clear
close all

% Simultation or reality?
real = 1;
% Mac or windows?
mac = 1;


%%        Sp = serial_port_start('/dev/tty.usbserial')
        Sp = serial_port_start('/dev/tty.usbserial');
    pause(2)
pioneer_init(Sp);

%%
pause(1)
r = 0.30; w = pi/2;
v = r*w;
pioneer_set_controls(Sp, round(v*100), round(w*180/pi*1)) 
pause(1)

pioneer_set_controls(Sp, 0, 0) 