Sp = serial_port_start('/dev/tty.usbserial');
pioneer_init(Sp);
   
%%
serial_port_stop(Sp)
 pause(2)

%%
pioneer_set_controls(Sp,200,0);
aux1 =[];
while(true)
  aux = pioneer_read_sonars
  if (aux(1) <500)
      break;
  end
  aux1 = [aux1; aux];
  pause(0.1)
end
pioneer_set_controls(Sp,0,0);
%pioneer_read_odometry


%0.930 - 0.566 desvio x 
%pioneer 2 desalinha para a esquerda
% 5.882 -> distancia percorrida em frente
% mm/s