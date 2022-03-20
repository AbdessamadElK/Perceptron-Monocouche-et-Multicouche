%Entrianement d'un réseaux de neurones à une seule couche cachée
clc, clear, close all;

%% Chargement et visualisation de données:
load('data5.mat');

plotData(X, y);

fprintf('Programme en pause, tapez une touche pour continuer!\n');
pause;
close all;

%% Initialisation du réseau et normalisation des données:

% Nombre d'entrées
nbr_in = 2;

% Nombre de neurones de la couche cachée
nbr_cach = 15;

% Nombre de sorties
nbr_out = 1;

W1 = randInitW(nbr_in, nbr_cach);
W2 = randInitW(nbr_cach, nbr_out);

initial_nn_W = [W1(:); W2(:)];

[Xtr, mu, sigma] = normData(X);

%% Entrainement:

% Nombre maximal d'itérations:
max_iter = 1000;

% Taux de régularisation:
lambda = 0;

config = optimset('MaxIter', max_iter);

costFunction = @(p) nnCostFunction(p, nbr_in, nbr_cach, nbr_out, Xtr, y, lambda);

% Entrainement:
[nn_params, cost] = fmincg(costFunction, initial_nn_W, config);

[W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);


%% Affichage de résultats

% Distribution de probabilités et frontiére de décision
plotProb(X, y, W1, W2, mu, sigma);

