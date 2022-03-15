%% Perceptron Monocouche (d�cente du gradient)
clc, clear, close all;

%Gradient du couleur
color1 = [246 94 0] ./ 255;
color2 = [51 202 255] ./ 255;
myMap = colorGradient(color1, color2);

%% Entrainement sans Test ---------------------

%-- Chargement de donn�es --%

% Vous pouvez essayer avec Data2.mat et Data3.mat aussi
load('Data1.mat');

plotData(X, y, 'bords', .1);
xlabel('X1');
ylabel('X2');
title('Ensemble d''entrainement');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%--- Param�tres ---%

% Taux d'apprentissage (learning rate):
alpha = .1;

% Nombre d'it�rations
iters = 200; 

% degr� de variables polyn�miales
degree = 1;

% Taux de r�gularisation (L2)
lambda = 0; 


%-- Pr�traitment --%
 
Xtr = X;

% Normalisation
[Xtr, mu, sigma] = normData(Xtr);

% Variables polyn�miales
Xtr = mapFeature(Xtr(:, 1), Xtr(:, 2), degree);


%-- Entrainement --%

% Initialisatin des poids
w = rand(size(Xtr, 2), 1);

% D�cente du gradient
[w, Htrain] = perceptronTrain(Xtr, y, w, alpha, lambda, iters);


%-- Affichage de r�sultats --%

% Affichage d'erreur en fonction des pas
plot(Htrain, '-b');
xlabel('iterations');
ylabel('J(w)');
title('Evolution d''Erreur');


% Affichage de la distribution de probabilit�s de sortie et de la
% Fronti�r de d�cision

plotProb(X, y, w, degree, mu, sigma);

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%% Entrainement avec Test ---------------------

%-- Chargement de donn�es --%

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

%--- Param�tres ---%

% Taux d'apprentissage (learning rate):
alpha = .1;

% Nombre d'it�rations
iters = 200; 

% degr� de variables polyn�miales
degree = 2;

% Taux de r�gularisation (L2)
lambda = 0; 


%-- Pr�traitment --%

% Normalisation
[Xtr, mu, sigma] = normData(Xtrain);

Xts = ( Xtest - mu ) ./ sigma;


% Variables polyn�miales
Xtr = mapFeature(Xtr(:, 1), Xtr(:, 2), degree);
Xts = mapFeature(Xts(:, 1), Xts(:, 2), degree);


%-- Entrainement --%

% Initialisatin des poids
w = rand(size(Xtr, 2), 1);

% D�cente du gradient
[w, Htrain, Htest] = perceptronTrain(Xtr, ytrain, w, alpha, lambda, iters, 'Xtest', Xts, 'ytest', ytest);


%-- Affichage de r�sultats --%

% Affichage d'erreurs en fonction des pas
plot(Htrain, '-b');
hold on;
plot(Htest, '-r');

legend('Entrainement', 'Test');
xlabel('iterations');
ylabel('J(w)');
title('Evolution d''Erreurs');


% Affichage de la distribution de probabilit�s de sortie et de la
% Fronti�r de d�cision

plotProb(Xtrain, ytrain, w, degree, mu, sigma);

plotProb(Xtest, ytest, w, degree, mu, sigma);
