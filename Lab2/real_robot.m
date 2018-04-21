function [ output_args ] = RealRobot( mac )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% inicialização da porta
if mac
    Sp = serial_port_start('/dev/tty.usbserial');
else
    
end
pioneer_init(Sp);

pioneer_set_controls (Sp,1,3); % v -> mm/s; w -> 

end


