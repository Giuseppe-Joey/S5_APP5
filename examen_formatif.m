




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





% a)







% b)





% c)





% d)






% e)





% f)





% g)






% h)












disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);






%% probleme 3
disp(['----------------------']);
disp(['------PROBLEME 3------']);
disp(['----------------------']);

num_p3 = [1];
den1_p3 = [1    0];
den2_p3 = [1    5];
den3_p3 = [1    11];

den_p3 = conv(den1_p3, den2_p3);
den_p3 = conv(den_p3, den3_p3);

TF_p3 = tf(num_p3,den_p3)







disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);



%% probleme 4
disp(['----------------------']);
disp(['------PROBLEME 4------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);



%% probleme 5
disp(['----------------------']);
disp(['------PROBLEME 5------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);


%% probleme 6
disp(['----------------------']);
disp(['------PROBLEME 6------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);




%% probleme 7
disp(['----------------------']);
disp(['------PROBLEME 7------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);





%% probleme 8
disp(['----------------------']);
disp(['------PROBLEME 8------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);





%% probleme 9
disp(['----------------------']);
disp(['------PROBLEME 9------']);
disp(['----------------------']);









disp(['----------------------']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
disp([' ']);
