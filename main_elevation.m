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



%% DEBUT DE La problematique
clc
close all
clear all

% Initialisation
constantes_APP5 % call le fichier des constantes

Profile_Tracking    % call le fichier Profile_Tracking.p (trajectoire de ref fournie)
plot(ttrk,utrk)









