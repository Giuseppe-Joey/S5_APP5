

%%  S5 - APP4 - PROBLEMATIQUE - filtre_coupe_bande.m
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Lucas Corrales
%   CIP:        CORL0701

%   Date de creation:       13-MARS-2023
%   Date de derniere modification:       13-MARS-2023

% DESCRIPTION: exemple de filtre coupe bande en Matlab


clear all
close all
clc


Fe = 1000;  %Frequence dechantillonnage
F0 = 62.5;  %Frequence de resonnance
Q = 10;     %Facteur de qualite
Te = 1/Fe;  %Periode dechantillonnage
t = [0:Te:1];
Freq = [0:length(t)-1]*(Fe/length(t));
W = 2*pi*Freq;
W0 = 2*pi*F0;
X = W/W0;
H = 1./(1+j*Q*(X./(1-(X.^2))));
Module = 20*log10(abs(H));

figure
semilogx(Freq,Module,'')
%plot(W,W0,'p')
hold on
semilogx(Freq, max(Module)-3*ones(1,length(H)), 'r--')
grid on
title('Visualisation du Filtre Coupe-Bande')
legend
