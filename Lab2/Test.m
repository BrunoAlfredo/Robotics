Sp = serial_port_start('COM5');
pioneer_init(Sp);
   
%%
pioneer_read_sonars

%%
pioneer_set_controls(Sp,200,0);
while(true)
  aux = pioneer_read_sonars
  if (aux(1) <500)
      break;
  end
  pause(1)
end
pioneer_set_controls(Sp,0,0);
%pioneer_read_odometry

%pioneer 2 desalinha para a esquerda