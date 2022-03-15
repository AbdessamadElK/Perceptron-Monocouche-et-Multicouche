%% Perceptron Monocouche (décente du gradient)
clc, clear, close all;

%Gradient du couleur
color1 = [246 94 0] ./ 255;
color2 = [51 202 255] ./ 255;
myMap = colorGradient(color1, color2);

%% Entrainement sans Test ---------------------

%-- Chargement de données --%

% Vous pouvez essayer avec Data2.mat et Data3.mat aussi
load('Data1.mat');

plotData(X, y, 'bords', .1);
xlabel('X1');
ylabel('X2');
title('Ensemble d''entrainement');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%--- Paramètres ---%

% Taux d'apprentissage (learning rate):
alpha = .1;

% Nombre d'itérations
iters = 200; 

% degré de variables polynômiales
degree = 1;

% Taux de régularisation (L2)
lambda = 0; 


%-- Prétraitment --%
 
Xtr = X;

% Normalisation
[Xtr, mu, sigma] = normData(Xtr);

% Variables polynômiales
Xtr = mapFeature(Xtr(:, 1), Xtr(:, 2), degree);


%-- Entrainement --%

% Initialisatin des poids
w = rand(size(Xtr, 2), 1);

% Décente du gradient
[w, Htrain] = perceptronTrain(Xtr, y, w, alpha, lambda, iters);


%-- Affichage de résultats --%

% Affichage d'erreur en fonction des pas
plot(Htrain, '-b');
xlabel('iterations');
ylabel('J(w)');
title('Evolution d''Erreur');


% Affichage de la distribution de probabilités de sortie et de la
% Frontièr de décision

plotProb(X, y, w, degree, mu, sigma);

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%% Entrainement avec Test ---------------------

%-- Chargement de données --%

load('Data4.mat');

plotData(Xtrain, ytrain, 'bords', .1);
xlabel('X1');
ylabel('X2');
title('Ensemble d''entrainement');

plotData(Xtest, ytest, 'bords', .1);
xlabel('X1');
ylabel('X2');
title('Ensemble de test');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%--- Paramètres ---%

% Taux d'apprentissage (learning rate):
alpha = .1;

% Nombre d'itérations
iters = 200; 

% degré de variables polynômiales
degree = 2;

% Taux de régularisation (L2)
lambda = 0; 


%-- Prétraitment --%

% Normalisation
[Xtr, mu, sigma] = normData(Xtrain);

Xts = ( Xtest - mu ) ./ sigma;


% Variables polynômiales
Xtr = mapFeature(Xtr(:, 1), Xtr(:, 2), degree);
Xts = mapFeature(Xts(:, 1), Xts(:, 2), degree);


%-- Entrainement --%

% Initialisatin des poids
w = rand(size(Xtr, 2), 1);

% Décente du gradient
[w, Htrain, Htest] = perceptronTrain(Xtr, ytrain, w, alpha, lambda, iters, 'Xtest', Xts, 'ytest', ytest);


%-- Affichage de résultats --%

% Affichage d'erreurs en fonction des pas
plot(Htrain, '-b');
hold on;
plot(Htest, '-r');

legend('Entrainement', 'Test');
xlabel('iterations');
ylabel('J(w)');
title('Evolution d''Erreurs');


% Affichage de la distribution de probabilités de sortie et de la
% Frontièr de décision

plotProb(Xtrain, ytrain, w, degree, mu, sigma);

plotProb(Xtest, ytest, w, degree, mu, sigma);
