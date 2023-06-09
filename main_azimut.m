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
Erp_A2 = 0.03;              % erreur en regime permanent 
% ----------------------
% Modèle dynamique des deux télescopes en azimut (AZ)
num = [1.59e09];
den = [1 1020.51 25082.705 3102480.725 64155612.5 82700000 0];
FTBO = tf(num, den)
% -------------------

% NOTE: fudge factor on le baisse pour augmenter la rapidite et on le monte pour
% diminuer la phase
Fudge_factor = 10;


%pour telescope A on doit faire lieu des racines
%pour telescope B on doit faire Bode


phi = atand((-1*pi)./log(Mp/100));
zeta = cosd(phi);


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
   

Wa = Wn*sqrt(1-zeta^2);

p1 = -zeta*Wn + j*Wa;
p2 = -zeta*Wn - j*Wa;

%phase au pole desire
%on enleve 360 car sinon angle va donner un angle positif 
Ph_G = ((angle(polyval(num,p1)/polyval(den,p1)))*(180/pi))-360;

delta_phi = -180 - Ph_G;
alpha = 180 - phi;

phi_z = (alpha + delta_phi)/2;
phi_p = (alpha - delta_phi)/2;

za = real(p1)-imag(p1)/tand(phi_z);
pa = real(p1)-imag(p1)/tand(phi_p);

numFT = [1 -za];
denFT = [1 -pa];

% GA VALIDE ET FONCTIONNEL
Ka = abs((polyval(den,p1)*polyval(denFT,p1))/(polyval(num,p1)*polyval(numFT,p1)));
Ga = Ka * tf([1 -za],[1 -pa])
FTBO_AvPh = FTBO*Ga







% 
% figure('Name','FTBO_AvPh')
% % rlocus(FTBO)
% % hold on
% plot(real(p1),imag(p1),'p')
% hold on
% rlocus(FTBO_AvPh)
% hold on
% pol = rlocus(FTBO_AvPh,1);
% hold on
% plot(real(pol), imag(pol),'s')
% legend
% 
% 
% 
% figure('Name','FTBO et FTBO_AvPh')
% margin(FTBO)
% hold on
% plot(real(p1),imag(p1),'p')
% hold on
% margin(FTBO_AvPh)
% hold on
% pol = rlocus(FTBO_AvPh,1);
% hold on
% plot(real(pol), imag(pol),'s')
% grid on
% legend

























%% retard de phase RePh - VALIDE ET FONCTIONNEL
Fudge_factor = 10;

% le v donne les values
[NUM,DEN] = tfdata(FTBO_AvPh,'v');

Kvel_d = 1 / Erp_A2
Kvel = NUM(end)/DEN(end-1)
K_des = Kvel_d/Kvel

zr = real(p1) / Fudge_factor;

pr = zr/K_des;
Gr = tf([1 -zr],[1 -pr])
G_Ga_Gr = FTBO_AvPh * Gr

% figure('Name','FTBO_RePh')
% % rlocus(FTBO)
% % hold on
% plot(real(p1),imag(p1),'p')
% hold on
% rlocus(FTBO_RePh)
% hold on
% pol = rlocus(FTBO_RePh,1);
% hold on
% plot(real(pol), imag(pol),'s')
% legend




% figure('Name','FTBO_RePh')
% % rlocus(FTBO)
% % hold on
% % plot(real(p1),imag(p1),'p')
% % hold on
% margin(FTBO_RePh)
% hold on
% % pol = rlocus(FTBO_RePh,1);
% hold on
% plot(real(pol), imag(pol),'s')
% legend




% figure('Name','FTBO et FTBO_AvPh')
% margin(FTBO)
% hold on
% plot(real(p1),imag(p1),'p')
% hold on
% margin(FTBO_RePh)
% hold on
% % pol = rlocus(FTBO_AvPh,1);
% hold on
% plot(real(pol), imag(pol),'s')
% grid on
% legend







%% Critères de sécurité

%coupe bande

beta = 5;
W0 = 55;        %obtenu a partir du diagramme de Bode

H = tf([1 0 W0^2],[1 beta W0^2])
G_bandeCoupee = G_Ga_Gr * H

% figure('Name','bode')
% bode(G_new)
% hold on
% margin(G_CB)

% Valider DM
[GM,PM,Wp,Wg] = margin(G_bandeCoupee)
DM = PM/Wg*(pi/180)

% Ajuster le gain
GM_DB = mag2db(GM)
GM_des = 15;
GM_compDB = GM_DB - GM_des;
GM_comp = db2mag(GM_compDB);

G_comp = (GM_comp * G_bandeCoupee);

FTBF = feedback(G_comp,1)



%% erreur

t = [0:0.01:100]';  % 201 points
u = t / 2;
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
pol = rlocus(G_comp,1);
plot(real(pol), imag(pol),'s')


figure('Name','FTBF compensee')
margin(G_comp)

figure('Name', 'Step G*Ga*Gr')
bode(FTBF)
figure
step(FTBF)

