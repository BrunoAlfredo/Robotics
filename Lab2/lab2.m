%% Lab 2 - Rob�tica

Sp = serial_port_start('/dev/tty.usbserial');
pioneer_init(Sp);

%%
pioneer_set_controls (Sp,1,3); % v -> mm/s; w -> 

