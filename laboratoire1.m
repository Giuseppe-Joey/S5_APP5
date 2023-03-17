clear all

num = [4500];
den = [1 361.2 0];

G = tf(num,den)

Mp = 6;
tr1 = 0.004;
tp = 0.008;
ts = 0.010;
err = 0.00005;

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

%% c)

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

%% d)







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



%% probleme 8







%% probleme 9





%% probleme 10






%% probleme 11








