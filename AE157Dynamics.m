clear all
close all
clc


%% Define Matrices (System Dynamics)
% A = State Matrix
% B = Control Matrix (Input to State)
% C = Output Matrix (State to Output)
% D = Direct Transmission (Feedthrough)
A = [-0.5961 0.8011 -0.871 -9.791 5.053e-05 0.01263; -0.7454 -7.581 15.72 -0.5272 -0.0009384 0; 1.042 -7.427 -15.85 0 -8.01e-16 -0.01318; 0 0 1 0 0 0; -0.05377 0.9986 0 -17 0 0; 135.8 7.315 0 0 -0.08268 -5.919]
B = [0.4681 0; -2.711 0; -134.1 0; 0 0; 0 0; 0 2506]
C = [0.9986 0.05377 0 0 0 0; -0.003163 0.05874 0 0 0 0; 0 0 1 0 0 0; 0 0 0 1 0 0; 0 0 0 0 -1 0; -0.5961 0.8011 0.04307 0 5.07e-05 0.01263; -0.7454 -7.581 -1.259 0 -0.0009415 0]
D = [0 0; 0 0; 0 0; 0 0; 0 0; 0.4681 0; -2.711 0]
%% Map I/O Transfer Functions
states = {'u', 'w', 'q', 'theta', 'Ze', 'omega'};
inputs = {'elevator', 'throttle'};
outputs = {'V', 'alpha', 'q', 'theta', 'h', 'ax', 'az'};
sys_mimo = ss(A,B,C,D,'statename',states,...
'inputname',inputs,...
'outputname',outputs);
Ge=tf(sys_mimo(4,1)) %input "elevator" to output "theta (pitch angle)"
Gt=tf(sys_mimo(4,2)) %input "throttle" to output "theta"
%% Define Servo Transfer Function
num = [50]
den = [1 50]
Serv = tf(num,den)
%% Define Plant Transfer Function
plant = series(Serv,Ge)
%% System Figures
margin(plant) %Magnitude & Phase
figure
rlocus(plant) %Plot Poles & Zeroes with 
figure
stepplot(plant) %Step response in time domain
figure
nyquist(plant) %Nyquist plot
%% System Values
stepinfo(plant) %rise time, settling, settling min/max, overshoot, peak, peak time
zpk(plant) %zero/pole/gain of TF: "elevator" to "theta"
damp(plant) %poles & eigen values & damping ratio of TF: "elevator" to "theta"
