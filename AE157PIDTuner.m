clear all
close all
clc

t = 0:.01:8;
k = 0;
solution=zeros(50,5)
for Kp = 0:.1:2
    for Ki = 0:.1:2
        for Kd = 0:.1:2
            PID = tf(-1*[Kp Ki Kd], [1 0]);
            systemdynamics = (PID*S*Ge);
            CL = feedback(systemdynamics,1);
            q = stepinfo(CL);
            if q.Overshoot<2 && q.Overshoot>0 & q.SettlingTime<2;
                k=k+1;
                solution(k,:) = [Kp Ki Kd q.Overshoot q.SettlingTime];
            end
        end
    end
end
solution
