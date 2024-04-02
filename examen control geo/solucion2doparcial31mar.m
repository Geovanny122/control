clear all
clc
% Ejercicio 6 a
sys = tf([4.545 0], [1 0.1818 -31.21 4.456]);
Kp=3268;
Ki=4.522e4;
Kd=57.69;
Cs=pid(Kp,Ki,Kd);
sys_s=series(sys,Cs);
sys_t=feedback(sys_s,1);
step(sys_t);
% Ejercicio 6 b
sys_ss1=ss(sys_t)
[A1,B1,C1,D1]=tf2ss([262.2 1.485e04 2.055e05 0],[1 262.4 1.482e04 2.055e05 0])

O=obsv(sys_ss1.A,sys_ss1.C);
% Ejercicio 6 c y d
sys_d=c2d(sys,0.001,'tustin');
%para ver controlabilidad se usa la función ctrl(matriz A, matriz B)

Csd=c2d(Cs,0.001,'tustin');

%Sc1=feedback(series(sys_d,Csd),1);
step(feedback(series(sys_d,Csd),1));

%2da Parte 
%Ejercicio 1

%GenVolt/Pressure 0.9476%
%GenVolt/MagVolt 76.63%
%Speed/MagVolt 1.264%
%Pressure/MagVolt 61.27%

%Ejercicio 2

% Kp = 14.6, Ki = 0.803

%Ejercicio 3
tf1=tf([-0.00512 0.01597 0.0008936],[1 0.01271 0.00435])
P=[-10,-10];
GP_ss=ss(tf1);
GPT=ss(feedback(series(tf1,pid(14.6, 0.803, 0)),1));
L = acker(GPT.A,GPT.B,P);
%GPT=ss()

%Ejercicio 4

SM=tf([-0.005351 0.001283 4.312e-05],[1 0.001952 0.007696]);
SM_ss=ss(SM);
Ts=0.01;
Ad = (inv(eye(2) - (0.5*(SM_ss.A*Ts)))) * (eye(2) + (0.5*(SM_ss.A*Ts)));
Bd = (inv(eye(2) - (0.5*(SM_ss.A*Ts)))) * (SM_ss.B*Ts);
Cd = SM_ss.C*(inv(eye(2) - (0.5*(SM_ss.A*Ts))));
Dd = SM_ss.D + SM_ss.C*(inv(eye(2) - (0.5*(SM_ss.A*Ts))))*(0.5*SM_ss.B*Ts);
%Ad =
%     1.0000   -0.0006
%     0.0012    1.0000
% Bd =
% 
%    1.0e-03 *
% 
%     0.6250
%     0.0004
% Cd =
% 
%     0.0207    0.0108
% Dd =
% 
%    -0.0053



