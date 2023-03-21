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

Mp = 25;
ts = 1;
tr1 = 0.18;
eRP_des = 0.08;           % erreur en regime permanent a une rampe
fudge_factor = 9;      % facteur qui pousse vers zero
marge = 10;


phi = atand((-1*pi)./log(Mp/100));
zeta = cosd(phi)+0.165;

%Wn1 et Wn2
Wn1 = (4/ts)/zeta;
Wn2 = (1+1.1*zeta+1.4*zeta^2)/tr1;

%Bigger Wn
if Wn1 > Wn2
    Wn = Wn1;     
else
     Wn = Wn2;
end

Wa = Wn*sqrt(1-zeta^2);

p1 = -zeta*Wn + j*Wa;
p2 = -zeta*Wn - j*Wa;
% AvPh
%phase au pole desire
%on enleve 360 car sinon angle va donner un angle positif 
Ph_G = ((angle(polyval(numEL,p1)/polyval(denEL,p1)))*180/pi)-360;

delta_phi = -180-Ph_G+marge;

alpha = 180-phi;

phi_z = (alpha + delta_phi)/2
phi_p = (alpha - delta_phi)/2

za = real(p1)-imag(p1)/tand(phi_z)
pa = real(p1)-imag(p1)/tand(phi_p)

numFT = [1 -za];
denFT = [1 -pa];

Ka = abs((polyval(denEL,p1)*polyval(denFT,p1))/(polyval(numEL,p1)*polyval(numFT,p1)))

Ga = Ka * tf([1 -za],[1 -pa])

% G_new = G*Ga
% [num,den] = tfdata(G_new);
% PI
Kvel = 2.531e11/1.091e10;

KI = 1/(Kvel*eRP_des);

ZI = real(p1)/fudge_factor;

Kp = -KI/ZI;

GPI = Kp * tf([1 -ZI],[1 0])

G_new = G*GPI*Ga 



% figure
% bode(G)
% figure
% margin(G_new)
% figure('Name','noncompense')
% rlocus(G)
% figure('Name','compense')
% 
% plot(real(p1),imag(p1),'p')
% 
hold on
rlocus(G)
hold on
pol = rlocus(G_new,1);
plot(real(pol), imag(pol),'s')

%% Critères de sécurité

%coupe bande

beta = 2
W0 = 123;

H = tf([1 0 W0^2],[1 beta W0^2])
G_CB = G_new*H

% figure('Name','bode')
% bode(G_new)
% hold on
% margin(G_CB)

% Valider DM
[GM,PM,Wp,Wg] = margin(G_CB)
DM= PM/Wg*(pi/180)

% Ajuster le gain
GM_DB = mag2db(GM)
GM_des = 15;
GM_compDB = GM_DB-GM_des;
GM_comp = db2mag(GM_compDB);

G_comp = (GM_comp*G_CB)*(0.0475/0.08);

FTBF = feedback(G_comp,1)


%% erreur

t = [0:0.01:100]';  % 201 points
u = t.^2 / 2;
y = lsim(FTBF,u,t);

figure
plot(t,u-y)

%% plot

% Valider DM
[GM,PM,Wp,Wg] = margin(G_comp);
DM= PM/Wg*(pi/180)
GM = mag2db(GM)


figure('Name','bode comp')
margin(G_comp)
figure('Name','rlocus comp')
plot(real(p1),imag(p1),'p')
hold on
rlocus(G_comp)
hold on
pol = rlocus(G_new,1);
plot(real(pol), imag(pol),'s')

figure
bode(FTBF)
figure
step(FTBF)





% % Initialisation
% constantes_APP5 % call le fichier des constantes
% 
% Profile_Tracking    % call le fichier Profile_Tracking.p (trajectoire de ref fournie)
% plot(ttrk,utrk)









