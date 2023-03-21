%%  S5 - APP4 - PROBLEMATIQUE - MAIN.M
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Lucas Corrales
%   CIP:        CORL0701

%   Date de creation:       13-MARS-2023
%   Date de derniere modification:       13-MARS-2023

% DESCRIPTION: fichier principale pour la problematique S5-APP5



%% NOTES
% Marge de retard cest une marge de phase traduite en secondes
% JAMAIS UN BODE AVEC UNE FTBF!!!!!!!
% pour atenuer les vibrations on peut utiliser un filtre coupe bande comme
% vue dans les sessions anterieures en autant que ca fonctionne!!
% pour le filtre coupe bande on trouvera les frequences a laide de BODE
% --on reconnait une vibration sur un diagramme de bode car il y aura un
% peak a cette vibration, le peak doit en bas de -15dB voir A6 et B5



%% ETAPES DE RESOLUTION
% 1-le diagramme de procedures de conception est la premiere chose quon
% sattend a voir dans la presentation on sattend a faire une arboresence 
% 2-conception **voir tableau notes tuto1 Xavier
% 3-tableau de conformite: on verif la conformite des condos de departs et
% des criteres de conception, on runnera des simulations et dira si par
% exemple les criteres de specs du client sont rencontrés on pas (ex MP,
% bande passante, etc)
% **ici on fait literation
% 4-tableau des compensateurs finaux et criteres de conformite avec
% explications pour literation
% 5-Marge de retard apres augmentation dun facteur 5 (14dB)
% 6-resultats de simulation
% ***si on veut voir lerreur sur un graph on doit faire : on doit voir la
% consigne, la reponse superposee et sur un autre graph l'erreur (entree
% moins la sortie (U-Y))
% ***donner les fonctions de transferts des compensateurs (tous les
% compensateurs de tous les etudiants donc tous les compensateurs de DEPART 
% devraient etre pareille pour tlm mais les compensateurs FINAUX devraient
% etre differents dun etudiant a lautre
% ***quand on demande quon veut voir lerreur: on fait le diagramme de
% lerreur et non pas de la reponse


%% ANNEXE A
% provient de lapp 3
% classe 1 car 
% lieu des racines : 6 asymptotes pcq jai 6 poles donc 6 lieu des racines qui se termine a linfini
% pour avoir le nb de mode on devra faire residu....quand on a des
% vibration ca veut dire quon a au moins un ordre 2 car ordre 1 ne peut pas
% avoir de vibration



%% Critères de conception
clc
close all
clear all

numEL = [7.95e09];
denEL = [1 1020.51 37082.705 15346520.725 320776412.5 413500000 0];

G = tf(numEL,denEL)

%% AvPh
BW = 10;
PM_des = 50;
eRP_des = 0.005;           % erreur en regime permanent a une rampe
mrg = 15;

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
fudge = 4;

%1
Kvel = num(end)/den(end-1)
K_des = 1/(Kvel*eRP_des)

%2
beta = K_des;

%3
T = fudge/Wg_des

%4

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














