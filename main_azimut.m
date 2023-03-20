%%  S5 - APP4 - PROBLEMATIQUE - MAIN_AZIMUT.M
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



%% DEBUT DE La problematique
clc
close all
clear all

% Initialisation
constantes_APP5 % call le fichier des constantes

% Profile_Tracking    % call le fichier Profile_Tracking.p (trajectoire de ref fournie)
% plot(ttrk,utrk)





%% azimut code 

% A2 - Reponse a un echelon unitaire:
Mp = 25;                    % depassement maximum en pourcentage
ts = 1.00;                  % temps de stabilisation(2%) en secondes
tm = 0.18;        % temps de montee(10% a 90%) en secondes 
Erp_A2 = 0.00;              % erreur en regime permanent 
% ----------------------
% Modèle dynamique des deux télescopes en azimut (AZ)
num = [1.59e09];
den = [1 1020.51 25082.705 3102480.725 64155612.5 82700000 0];
FTBO = tf(num, den);
% -------------------



phi = atand((-1*pi)./log(Mp/100))
zeta = cosd(phi)





%Wn1 et Wn2
Wn1 = (4/ts)/zeta;
Wn2 = (1+1.1*zeta+1.4*zeta^2)/tm;
% Wn3 = pi/(tp*sqrt(1-zeta^2));

%Bigger Wn
if Wn1 > Wn2
    Wn = Wn1; 
elseif Wn2 > Wn1
     Wn = Wn2;     
end
   



% -------------------------------------------------------------------
% b)

Wa = Wn*sqrt(1-zeta^2);




% Kvel = 4500/361.2;
% Kvel_d = 1/Erp_A2;


p1 = -zeta*Wn + j*Wa;
p2 = -zeta*Wn - j*Wa;

%phase au pole desire
%on enleve 360 car sinon angle va donner un angle positif 
Ph_G = ((angle(polyval(num,p1)/polyval(den,p1)))*180/pi)-360;

delta_phi = -180-Ph_G;

alpha = 180-phi;

phi_z = (alpha + delta_phi)/2;
phi_p = (alpha - delta_phi)/2;

za = real(p1)-imag(p1)/tand(phi_z);
pa = real(p1)-imag(p1)/tand(phi_p);

numFT = [1 -za];
denFT = [1 -pa];

% FT = tf(numFT,denFT);

beta = abs(za)/abs(pa);

% Ka = abs((polyval(den,p1)*polyval(denFT,p1))/(polyval(num,p1)*polyval(numFT,p1)))

Kr = 1;
Gr = Kr * tf([1 -za],[1 -pa]);



PM_des = atand(2*zeta/(sqrt(sqrt(1+4*zeta^4) - (2*zeta^2))));
[Gm,PM,Wcg,Wcp] = margin(FTBO);




% -------------------------
% reponse du prof
pha_des = -180.0 + PM_des;
wg_des = 0.0;
wg_dum = [0.1:0.0001:1.0]';         % vecteur de frequences dummy
[mag, pha] = bode(FTBO, wg_dum);
ind = find(abs(pha(1,1,:) - pha_des) < 0.005);
wg_des = wg_dum(ind);
% -------------------------



% le gain est simplement linverse du module
[mag, pha] = bode(FTBO, wg_des);
K_des = 1/mag;

figure
margin(FTBO)
hold on
% G_augmentee = FTBO*K_des
FTBO_comp = FTBO*Gr
% margin(G_augmentee)
margin(FTBO_comp)
legend








% figure('Name','Rlocus')
% rlocus(FTBO)
% hold on
% plot(real(p1),imag(p1),'p')
% hold on
% rlocus(FTBO_comp)
% hold on
% pol = rlocus(FTBO_comp,1)
% hold on
% plot(real(pol), imag(pol),'s')
% legend




% 
% 
% figure('Name','Bode')
% margin(FTBO)
% hold on
% plot(real(p1),imag(p1),'p')
% hold on
% margin(FTBO_comp)
% hold on
% pol = rlocus(FTBO_comp,1)
% hold on
% plot(real(pol), imag(pol),'s')
% grid on
% legend on
% 






