




clc
clear all
close all





%% probleme 2
disp(['----------------------']);
disp(['------PROBLEME 2------']);
disp(['----------------------']);

num_p2 = [1];
% den1_p2 = [1     7       16      12];
den1_p2 = [1    2];
den2_p2 = [1    3];

den_p2 = conv(den1_p2, den1_p2);
den_p2 = conv(den_p2, den2_p2);

TF_p2 = tf(num_p2,den_p2)





% a) Calculer la position des pôles dominants pour avoir temps de stabilisation à 2% de 1.6 seconde et un dépassement maximum de 25%.
Mp = 25;
ts = 1.6;

phi = atand((-1*pi)./log(Mp/100));
zeta = cosd(phi);

Wn1 = (4/ts)/zeta






% b) ** Si un compensateur AvPh avec un zéro à −1 est utilisé pour satisfaire
% les conditions (a), quelle devrait être la contribution angulaire du pôle
% du compensateur.






% c) Calculer la position du pôle du compensateur.






% d) (d) Calculer la valeur du gain du compensateur et donner la FT
% du compensateur.






% e)(e) Avec rlocus, vérifier la position obtenue des pôles en boucle fermée
% du système compensé.






% f)(f) Avec une simulation en boucle fermée, vérifier si les
% spécifications sont rencontrées. Est-ce que l’approximation de second ordre est valide?






% g)*** On remarque que l’avance de phase requise est plus élevée que
% 75 deg et le zéro de l’AvPh est à droite des pôles désirés, conditions
% qui ne sont pas acceptables. Refaire le problème avec un double AvPh
% avec les deux zéros à −3.






% h)







disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);










% %% probleme 3
% disp(['----------------------']);
% disp(['------PROBLEME 3------']);
% disp(['----------------------']);
% 
% num_p3 = [1];
% den1_p3 = [1    0];
% den2_p3 = [1    5];
% den3_p3 = [1    11];
% 
% den_p3 = conv(den1_p3, den2_p3);
% den_p3 = conv(den_p3, den3_p3);
% 
% TF_p3 = tf(num_p3,den_p3)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% 
% %% probleme 4
% disp(['----------------------']);
% disp(['------PROBLEME 4------']);
% disp(['----------------------']);
% 
% num_p4 = [1];
% den1_p4 = [1    0];
% den2_p4 = [1    8];
% den3_p4 = [1    30];
% 
% den_p4 = conv(den1_p4, den2_p4);
% den_p4 = conv(den_p4, den3_p4);
% 
% TF_p4 = tf(num_p4,den_p4)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% 
% %% probleme 5
% disp(['----------------------']);
% disp(['------PROBLEME 5------']);
% disp(['----------------------']);
% 
% num_p5 = [1     8];
% den1_p5 = [1    3];
% den2_p5 = [1    6];
% den3_p5 = [1    10];
% 
% den_p5 = conv(den1_p5, den2_p5);
% den_p5 = conv(den_p5, den3_p5);
% 
% TF_p5 = tf(num_p5,den_p5)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% %% probleme 6
% disp(['----------------------']);
% disp(['------PROBLEME 6------']);
% disp(['----------------------']);
% 
% num_p6 = [1    2    1];
% den_p6 = [1    1    1   0];
% 
% TF_p6 = tf(num_p6,den_p6)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% 
% %% probleme 7
% disp(['----------------------']);
% disp(['------PROBLEME 7------']);
% disp(['----------------------']);
% 
% num_p7 = [1    2    1];
% den_p7 = [1    2    2   1   0];
% 
% TF_p7 = tf(num_p7,den_p7)
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %% probleme 8
% disp(['----------------------']);
% disp(['------PROBLEME 8------']);
% disp(['----------------------']);
% 
% num_p8 = [1    2    1];
% den_p8 = [1    2    2   1   0];
% 
% TF_p8 = tf(num_p8,den_p8)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %% probleme 9
% disp(['----------------------']);
% disp(['------PROBLEME 9------']);
% disp(['----------------------']);
% 
% num_p9 = [1];
% den1_p9 = [1    0];
% den2_p9 = [1    8];
% den3_p9 = [1    30];
% 
% den_p9 = conv(den1_p9, den2_p9);
% den_p9 = conv(den_p9, den3_p9);
% 
% TF_p9 = tf(num_p9,den_p9)
% 
% 
% 
% 
% 
% 
% 
% disp(['----------------------']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% disp([' ']);
% 
% 
% 
% 
% 
% 
% 
