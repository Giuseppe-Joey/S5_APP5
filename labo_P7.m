err = 0;
ts_max = 0.1;
Mp = 5;

num = [1 1];
den1 = [1 6 10];
den2 = [1 7];
den = conv(den1,den2);

G = tf(num,den);

zPD = 
