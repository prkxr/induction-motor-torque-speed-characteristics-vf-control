Te = out.logsout.get('<Te>');
w  = out.logsout.get('<w>');

Te.Values
w.Values
    
Te_data = Te.Values.Data;
Te_time = Te.Values.Time;

w_data = w.Values.Data;
w_time = w.Values.Time;

speed_rpm = w_data * 60/(2*pi);
Te_data(end)
speed_rpm(end)

%Te_data(end-10:end)
%w_data(end-10:end)

ias = out.logsout.get('<ias>');
ibs = out.logsout.get('<ibs>');
ics = out.logsout.get('<ics>');

ia = ias.Values.Data;
ib = ibs.Values.Data;
ic = ics.Values.Data;

t = ias.Values.Time;