%%  S5 - APP4 - PROBLEMATIQUE - MAIN.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Lucas Corrales
%   CIP:        CORL0701

%   Date de creation:       13-MARS-2023
%   Date de derniere modification:       13-MARS-2023

% DESCRIPTION: fichier principale pour la problematique S5-APP5



%% Critères de conception
clc
close all
clear all

numAZ = [1.59e09];
denAZ = [1 1020.51 25082.705 3102480.725 64155612.5 82700000 0];

G = tf(numAZ,denAZ)


%% AvPh
BW = 10;
PM_des = 50;
eRP_des = 0.005;           % erreur en regime permanent a une rampe
mrg = 12;

[Gm,PM1,Wp,Wg] = margin(G);

zeta_des = (1/2)*sqrt(tand(PM_des)*sind(PM_des));
Wn_des = BW/sqrt((1-2*zeta_des^2)+sqrt(4*zeta_des^4-4*zeta_des^2+2));
Wg_des = (2*zeta_des*Wn_des)/tan(PM1);

% le gain est simplement linverse du module
[mag, pha] = bode(G, Wg_des);
K_des = 1/mag;

[Gm,PM2,Wp,Wg] = margin(G*K_des);

delta_phi = PM_des - PM2 + mrg;
alpha = (1-sind(delta_phi))/(1+sind(delta_phi));
T = 1/(Wg_des*sqrt(alpha));
Ka = K_des/sqrt(alpha);

Ga = Ka*alpha*tf([T 1],[alpha*T 1])

G_Ga = G*Ga

% %plot
% figure
% margin(G)
% hold on
% margin(G_Ga)


%% RePh
[NUM,DEN] = tfdata(G_Ga)
num = NUM{1};
den = DEN{1};
fudge = 5;

%1
Kvel = num(end)/den(end-1)
K_des = 1/(Kvel*eRP_des)

beta = K_des;
T = fudge/Wg_des

Gr = beta * tf([T 1],[T*beta 1])
G_comp = G_Ga*Gr

%plot
figure
% margin(G_Ga)
% hold on
% margin(Gr)
% hold on
margin(G_comp)


%% erreur
%1
[NUM,DEN] = tfdata(G_comp);
num = NUM{1};
den = DEN{1};
Kvel = num(end)/den(end-1)

%2
FTBF = feedback(G_comp,1)
t = [0:0.01:100]';  % 201 points
u = t;
y = lsim(FTBF,u,t);

figure
plot(t,u-y)














