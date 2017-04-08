clc
close all
%% Transfer Functions
tf(sys_mimo) %writes 14 TFs
Ge=tf(sys_mimo(4,1)) %input "elevator" to output "theta (pitch angle)"
Gt=tf(sys_mimo(4,2)) %input "throttle" to output "theta"
%% Define Controller Transfer Function
Kp = -.72
Ki = -.4
Kd = -.1
PID = pid(Kp,Ki,Kd);
%% Define Closed Loop Transfer Function
System=PID*Serv*Ge
CL = feedback(System,1)
a=stepinfo(CL)
%% Other
zpk(CL)
damp(CL)
