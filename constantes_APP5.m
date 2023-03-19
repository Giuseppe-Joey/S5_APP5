%%  S5 - APP4 - PROBLEMATIQUE - constantes_APP5.m
%   Auteur:     Giuseppe Lomonaco
%   CIP:        LOMG2301
%   Auteur:     Lucas Corrales
%   CIP:        CORL0701

%   Date de creation:       13-MARS-2023
%   Date de derniere modification:       13-MARS-2023

% DESCRIPTION: fichier utilise pour entrer toutes les constantes fournies
% du guide etudiant



%% TELESCOPE A

% ----------------------
% CRITERES DE CONCEPTION
% ----------------------

% A1 - Minimiser l'amplification du bruit a hautes frequences
% ----------------------

% A2 - Reponse a un echelon unitaire:
Mp = 25;                    % depassement maximum en pourcentage
ts = 1.00;                  % temps de stabilisation(2%) en secondes
tm = [0:0.001:0.18];        % temps de montee(10% a 90%) en secondes 
Erp_A2 = 0.00;              % erreur en regime permanent 
% ----------------------

% A3 - Reponse a une rampe unitaire:
% on a pas besoin de changer la ... car on est deja en classe un 
Erp_A3_Az = 0.03;           % erreur en regime permanent en degre en AZIMUT
% erreur de 0.00 car on a un classe 2 et donc on doit augmenter la classe
Erp_A3_El = 0.00;           % erreur en regime permanent en degre ELEVATION              
% ----------------------

% A4 - Reponse a une parabole unitaire:
%S/O : car erreur infini
% Erp_A4_Az = S/O;           % erreur en regime permanent en degre en AZIMUT
Erp_A4_El = 0.08;           % erreur en regime permanent en degre ELEVATION              
% ----------------------



% ----------------------
% CRITERES DE SECURITE
% ----------------------


% ----------------------
% A8 - 
% NOTE: verifier car certains criteres sont difficiles a atteindre sans
% relaxion



% ----------------------



% ----------------------

%% ANNEXE A

% Modèle dynamique des deux télescopes en azimut (AZ)
numAZ = [1.59e09];
denAZ = [1 1020.51 25082.705 3102480.725 64155612.5 82700000 0];
TF_AZ = tf(numAZ, denAZ)




% Modèle dynamique des deux télescopes en élévation (EL)
numEL = [7.95e09];
denEL = [1 1020.51 37082.705 15346520.725 320776412.5 413500000 0];
TF_EL = tf(numEL, denEL)




