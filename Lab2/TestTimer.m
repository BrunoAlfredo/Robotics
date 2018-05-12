t = timer('Period', 1, 'ExecutionMode', 'fixedRate');

t.StartFcn = {@my_callback_fcn, 'My start message'};

t.TimerFcn = @my_function;

start(t)

function my_function(obj, event)
disp("ola");
end

function my_callback_fcn(obj, event, text_arg)

txt1 = ' event occurred at ';
txt2 = text_arg;

event_type = event.Type;
event_time = datestr(event.Data.time);

msg = [event_type txt1 event_time];
disp(msg)
disp(txt2)
end