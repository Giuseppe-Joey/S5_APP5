


clc
close all
clear all



%% probleme 12 : systeme avec retard

T = 0.2;    % retard pur

% num = [5    50];
% den = [1    2   2];
% G = tf(num, den)

s = tf('s');
sys = exp(-T*s)*((5*s + 50)/(s^2 + 2*s + 2))

% utilisation de Pade dordre 5 comme suggere
% sysx = pade(sys,1)
% pade(T,1)
% 
% sysx = pade(sys,5)
% pade(T,5)

sysx = pade(sys,2)
pade(T,2)









%% probleme 13 : conception de AvPh et RePh avec diagramme de Bode (methode 2)
PM = 50;        % en degres
BW = 5.2;       % en rad/s  
e_RP = 0.005;   % erreur en regime permanent a une rampe

num = [1    4];
den = [1    8   3   0];

G = tf(num,den);

% figure
% bode(G)




% a) faire la conception dun AvPh qui rencontre les criteres PM et erreur
% en RP (avec la methode 2, Jdel section 7.5.4) sans prendre en
% consideration le critere BW






% b) faire la conception dun RePh qui rencontre les criteres PM et erreur
% en RP (avec la methode 2, Jdel section 7.6.4) sans prendre en
% consideration le critere BW






% c) comparer la BW de chacun des designs et conclure sur les
% caracteristiques de chacune des approches













%% probleme 14 : conception avec Bode : AvPh ou RePh avec Methode 2
num = [1    2];
den = [1    2   3   0];
G = tf(num,den);        % systeme en boucle ouverte






