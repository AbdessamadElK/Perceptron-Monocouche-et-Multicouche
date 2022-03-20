%Entrianement d'un r�seaux de neurones � une seule couche cach�e
clc, clear, close all;

%% Chargement et visualisation de donn�es:
load('data5.mat');

plotData(X, y);

fprintf('Programme en pause, tapez une touche pour continuer!\n');
pause;
close all;

%% Initialisation du r�seau et normalisation des donn�es:

% Nombre d'entr�es
nbr_in = 2;

% Nombre de neurones de la couche cach�e
nbr_cach = 15;

% Nombre de sorties
nbr_out = 1;

W1 = randInitW(nbr_in, nbr_cach);
W2 = randInitW(nbr_cach, nbr_out);

initial_nn_W = [W1(:); W2(:)];

[Xtr, mu, sigma] = normData(X);

%% Entrainement:

% Nombre maximal d'it�rations:
max_iter = 1000;

% Taux de r�gularisation:
lambda = 0;

config = optimset('MaxIter', max_iter);

costFunction = @(p) nnCostFunction(p, nbr_in, nbr_cach, nbr_out, Xtr, y, lambda);

% Entrainement:
[nn_params, cost] = fmincg(costFunction, initial_nn_W, config);

[W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);


%% Affichage de r�sultats

% Distribution de probabilit�s et fronti�re de d�cision
plotProb(X, y, W1, W2, mu, sigma);

