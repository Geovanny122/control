clear all

num=[0 2 3];
den=[1 0.5 1];
tf=tf(num,den)

[A,B,C,D]=tf2ss(num,den)

[num2,den2]=ss2tf(A,B,C,D)
%%
M_obs=obsv(A,C);
rank(M_obs)

H=ss(A,B,C,D);
step(H)
isstable(H)

%%
clear all
clc;

J=3.2284E-6;
b=3.5077E-6;
K=0.0274;
R=4;
L=2.75E-6;

A=[0,1,0;0,-b/J,K/J;0,-K/L,-R/L];
B=[0;0;1/L];
C=[1,0,0];
D=0;

H=ss(A,B,C,D);
figure(1)
step(H)

Fs=100;
Ts=1/Fs;
Hd=c2d(H,Ts,'tustin')
figure(2)
step(Hd)
grid on, grid minor

%% discretizar funciones de transferencia
syms z s
s=(z-1)/Ts;
F=3/(s^2+3*s+2);
Fs=simplify(F) % pendiente

%% Parte ejercicio 1
clear all;
clc;
%%
%save('funcion_transferencia','tf1')
kp=2;
ki=1;
kd=0;

Gc=pid(kp,ki,kd);
Gp=tf1;
Hs=feedback(series(Gc,Gp),1);
figure(3)
step(Hs)
title('Desempeño')
grid on, grid minor
%stepinfo(Hs)

%        RiseTime: 4.5244e-01 s
%      SettlingTime: 8.1061e+00 s
%         Overshoot: 1.6081e+01 %
%   Steady state error: (1.1608e+00-1)/1*100 = 16%

%% ej 3
Gpd=c2d(Gp,Ts,'tustin')
Gpdf=c2d(Gp,Ts,'foh')

figure(5)
subplot(2,1,1) %filas,columns,posicion
step(Gpdf)
title('Funcion de transferencia foh')
grid on, grid minor

subplot(2,1,2) %filas,columns,posicion
step(Gpd)
title('Funcion de transferencia bilinial')
grid on, grid minor
