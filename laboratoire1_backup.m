


clc
close all
clear all




%% NOTES
% POLYVAL(NUN, P*) VA EVALUER LE NUM A CETTE VALEUR P*
% POLYVAL (DEN, p*) DONC UN DIV PAR LAUTRE VA NOUS DONNER LA FT AU POLE
% DESIRE

% en faisant polyval(den) / polyval(num) on aura le gain

% avec lieu des racines on prend plot() et les poles desires doivent etre a gauche 
% il recomande de faire un carre pour les poles obtenus avec un carre
% representant la compensatiopn
% si on fait un retard de phase il suggere de faire un cercle, il sera un
% peu a droite car il sagit dun retard dephase

% ensuite on devra faiore une sur compensation 

% poles obtenus avec lavances
% poles obtenus avec le retard
% etc







%% probleme 6
num = [4500];
den = [1 361.2 0];

G = tf(num,den)

Mp = 6;
tr1 = 0.004;
tp = 0.008;
ts = 0.010;
err = 0.00005;



% -------------------------------------------------------------------
% a)

phi = atand((-1*pi)./log(Mp/100));
zeta = cosd(phi);

%Wn1 et Wn2
Wn1 = (4/ts)/zeta;
Wn2 = (1+1.1*zeta+1.4*zeta^2)/tr1;
Wn3 = pi/(tp*sqrt(1-zeta^2));

%Bigger Wn
if Wn1 > Wn2 & Wn1 > Wn3
    Wn = Wn1; 
elseif Wn2 > Wn1 & Wn2 > Wn3
     Wn = Wn2;     
else
     Wn = Wn3;
end
   



% -------------------------------------------------------------------
% b)

Wa = Wn*sqrt(1-zeta^2);

Kvel = 4500/361.2;
Kvel_d = 1/err;


p1 = -zeta*Wn + j*Wa;
p2 = -zeta*Wn - j*Wa;

%phase au pole desire
%on enleve 360 car sinon angle va donner un angle positif 
Ph_G = ((angle(polyval(num,p1)/polyval(den,p1)))*180/pi)-360;

delta_phi = -180-Ph_G;

alpha = 180-phi;

phi_z = (alpha + delta_phi)/2
phi_p = (alpha - delta_phi)/2

za = real(p1)-imag(p1)/tand(phi_z)
pa = real(p1)-imag(p1)/tand(phi_p)

numFT = [1 -za];
denFT = [1 -pa];

% FT = tf(numFT,denFT);

Ka = abs((polyval(den,p1)*polyval(denFT,p1))/(polyval(num,p1)*polyval(numFT,p1)))

Ga = Ka * tf([1 -za],[1 -pa])

G_new = G*Ga


figure('Name','compense')

plot(real(p1),imag(p1),'p')

hold on
rlocus(G_new)
hold on
pol = rlocus(G_new,1)
plot(real(pol), imag(pol),'s')
hold on


% -------------------------------------------------------------------
% c)

F = 10;

Kvel = 1.612e08/3.204e05;
K_d = Kvel_d/Kvel;

[NUM,DEN] = tfdata(G_new);

p_d = DEN{1}+1;

zr = real(roots(p_d))/F;
zr = zr(1);

pr = abs(zr)/K_d;

Gr = tf([1 -zr],[1 -pr])

G_new = G_new*Gr
rlocus(G_new)
hold on
pol = rlocus(G_new,1)
plot(real(pol), imag(pol),'s')





% -------------------------------------------------------------------
% d)










%% probleme 7
err = 0;
ts_max = 0.1;
Mp = 5;

num = [1 1];
den1 = [1 6 10];
den2 = [1 7];
den = conv(den1,den2);

G = tf(num,den);

zPD = 0;







%% probleme 8 - le prof dit quil est tres important!! il a ete continue au procedural 2 

clc
clear all
close all

PM_des = 50;            % en degres
BW = 5.2;               % en rad/s  
e_RP = 0.005;           % erreur en regime permanent a une rampe
marge_ajoutee = 5;      % en degres
fudge_factor = 10;      % facteur qui pousse vers zero

Kvel = 4/3;
Kvel_des = 1/e_RP;

num = [1    4];
den = [1    8   3   0];
G = tf(num,den)

zeta_des = 0.5*sqrt(tand(PM_des)*sind(PM_des))
wn_des = BW / sqrt((1-2*zeta_des^2) + sqrt(4*zeta_des^4 -4*zeta_des^2 +2))

wg_des = 2*zeta_des*wn_des / tand(PM_des)
G1 = (polyval(num,wg_des*j)/polyval(den,wg_des*j))
K_des = 1 / abs(G1)

[Gm,PM,Wp,Wg] = margin(G*K_des)

% etape 4
delta_phi = PM_des - PM + marge_ajoutee

% etape 5 - calculer alpha et T
alpha = (1 - sind(delta_phi)) / (1 + sind(delta_phi))
T = 1 / (wg_des * sqrt(alpha))

% etape 6 - calculer Ka
Ka = K_des / sqrt(alpha)
Ga = Ka * alpha * tf([T     1],[alpha*T    1])

% etape 7 - plot that thing !!!!! 
figure 
margin(G)
hold on
margin(Ga*G)
legend















%% probleme 9
clc
clear all
close all

fudge_factor = 10;      % facteur qui pousse vers zero

num = 20;
den_intermediaire = conv([1  1],[1    4]);
den = [den_intermediaire  0];

G = tf(num,den)




% a) on veut MP = 18.115
disp(['Question a)'])
Mp = 18.115;
phi = atand(-pi/log(Mp/100))
zeta = cosd(phi)






% b) 
PM_des = atand(2*zeta/(sqrt(sqrt(1+4*zeta^4) - (2*zeta^2))))
[Gm,PM,Wcg,Wcp] = margin(G)



% -------------------------
% reponse du prof
pha_des = -180.0 + PM_des
wg_des = 0.0;
wg_dum = [0.1:0.0001:1.0]';         % vecteur de frequences dummy
[mag, pha] = bode(G, wg_dum);
ind = find(abs(pha(1,1,:) - pha_des) < 0.005);
wg_des = wg_dum(ind)
% -------------------------



% le gain est simplement linverse du module
[mag, pha] = bode(G, wg_des(1));
K_des = 1/mag

figure
margin(G)
hold on
G_augmentee = G*K_des
margin(G_augmentee)
legend






% c) calculer la mnouvelle erreur en RP en reponse a une rampe unitaire
K_vel = 2.885/4;
e_RP = 1/K_vel;






% COMPENSATEUR PI
% d) CAS A
[MAG,PHASE] = bode(G_augmentee, wg_des)
poles = roots(den_Gaug{1})
zi = -wg_des(1)/fudge_factor
bode
PI = Kp*tf([1   -zi], [1    0])

figure
margin(G_augmentee)
hold on
margin(G_augmentee*PI)
legend





% CAS B








% CAS C















%% probleme 10






%% probleme 11








