% Classification de numéros
clc, clear, close all;

%% Chargement et affichage du Dataset
load('dataDigits.mat');

m = size(X, 1);

taille = [20, 20];

[Xtrain, ytrain, Xcv, ycv, Xtest, ytest] = splitData(X, y, .7, .2);

fprintf('Affichage d''un échantillon de 9 images de l''ensemble d''entrainement\n');
displayEchantillon(Xtrain, ytrain, [], taille);

fprintf('Programme en pause, tapez une touche pour continuer\n\n');
pause;
 
close all;

%% Choix du nombre de neurones dans la couche cachée

% Nombre d'entrées
nbr_in = 400;

% Nombre de neurones dans la couche cahée à tester
nbrs_cach = [2, 4, 5, 10, 15, 20, 30, 40, 50, 60, 70, 80, 90, 100];

% Nombre de sorties
nbr_out = 10;

% Taux de régularisation
lambda = 0;

% Nombre maximal d'itérations
% (l'entrainement en utilisant fmincg() peut s'arrêter avant ce nombre)
max_iter = 100;

% Historique d'erreur
err_Train_Hist = [];

config = optimset('MaxIter', max_iter);
indice = 0;

for nbr_cach = nbrs_cach
    
    %Affichage du progres
    indice = indice + 1;
    fprintf('[%d/%d] - Entrainement pour %d neurones dans la couche cahée\n...\n', ...
              indice, length(nbrs_cach), nbr_cach);
    
    % Initialisation:
    W1 = randInitW(nbr_in, nbr_cach);
    W2 = randInitW(nbr_cach, nbr_out);
    initial_nn_W = [W1(:); W2(:)];

    costFunction = @(p) nnCostFunction(p, nbr_in, nbr_cach, nbr_out, Xtrain, ytrain, lambda);

    % Entrainement:
    [nn_params, cost] = fmincg(costFunction, initial_nn_W, config);

    [W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);
    
    % Sauvegarde d'erreur
    err_Train_Hist = [err_Train_Hist, cost(end)];

      
end

% Affichage des courbes:
fprintf('Affichage du progres d''erreur d''entrainement\n');

figure;
plot(nbrs_cach, err_Train_Hist, '-b', 'LineWidth', 2);

title('Erreur d''entrainement');

ylabel('Erreur');
xlabel('nombre de neurones dans la couche 2');

fprintf('Programme en pause, tapez une touche pour continuer\n\n');
pause;

close all;

%% Choix du taux de régularisation:

% Nombre d'entrées
nbr_in = 400;

% Nombre de neurones cachées
nbr_cach = 35;

% Nombre de sorites
nbr_out = 10;

% Nombre limite d'itérations
max_iter = 100;

% Valeurs de lambda à tester
lambdas = [0.01, 0.03, 0.1, 0.3, 0.5, 1, 1.3, 1.5, 2, 2.3, 2.5, 3, 3.3, 3.5, 4, 5, 6, 7, 8, 9, 10];

% Historiques de précisions
accuracy_Train_Hist = [];
accuracy_CV_Hist = [];

config = optimset('MaxIter', max_iter);


W1_init = randInitW(nbr_in, nbr_cach);
W2_init = randInitW(nbr_cach, nbr_out);

indice = 0;

for lambda = lambdas
    
    %Affichage du progres
    indice = indice + 1;
    fprintf('[%d/%d] - Entrainement pour lambda = %.2f\n...\n', ...
              indice, length(lambdas), lambda);
    
    % Initialisation:
    W1 = W1_init;
    W2 = W2_init;
    initial_nn_W = [W1(:); W2(:)];

    costFunction = @(p) nnCostFunction(p, nbr_in, nbr_cach, nbr_out, Xtrain, ytrain, lambda);

    % Entrainement:
    [nn_params, cost] = fmincg(costFunction, initial_nn_W, config);

    [W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);

    % Ajout des précisions à l'historique:
    accuracy_Train_Hist = [accuracy_Train_Hist, accuracy(Xtrain, ytrain, W1, W2)];
    accuracy_CV_Hist = [accuracy_CV_Hist, accuracy(Xcv, ycv, W1, W2)];

end

% Affichage des courbes:
fprintf('Affichage des précisions d''entrainement et de validation\net leur différence\n');

% Précisions
figure;
plot(lambdas, accuracy_Train_Hist * 100, '-g', 'LineWidth', 2);
hold on;
plot(lambdas, accuracy_CV_Hist * 100, '--k', 'LineWidth', 2);

title('Precisions d''entrainement et de validation');
l = legend('entrainement', 'validation');

xlabel('lambda');
ylabel('Précisions (%)');

%Difference
figure;
plot(lambdas, (accuracy_Train_Hist - accuracy_CV_Hist) * 100, '-g', 'LineWidth', 2);
title('différence entre les deux précisions');

ylabel('Différence');
xlabel('lambda');

fprintf('Programme en pause, tapez une touche pour continuer\n\n');
pause;

close all;

%% Entrainement final

% Paramètres du perceptron
nbr_in = 400;
nbr_cach = 35;
nbr_out = 10;

max_iter = 200;

lambda = 5;

config = optimset('MaxIter', 200);

% Initialisations
W1 = randInitW(nbr_in, nbr_cach);
W2 = randInitW(nbr_cach, nbr_out);

initial_nn_W = [W1(:); W2(:)];

costFunction = @(p) nnCostFunction(p, nbr_in, nbr_cach, nbr_out, Xtrain, ytrain, lambda);

% Entrainement:
[nn_params, cost] = fmincg(costFunction, initial_nn_W, config);

[W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);

fprintf('Précisions obtenues:');
fprintf('Précision entrainement : %.2f%%\n', accuracy(Xtrain, ytrain, W1, W2) * 100);
fprintf('Précision de validation : %.2f%%\n', accuracy(Xcv, ycv, W1, W2) * 100);
fprintf('Précision de test : %.2f%% \n', accuracy(Xtest, ytest, W1, W2) * 100);


%% Affichage d'échantillons

% Ensemble d'entrainement
pred_train = pred(Xtrain, W1, W2);

true_idxs = find(ytrain == pred_train);
false_idxs = find(ytrain ~= pred_train);

figure('Name', 'Ensemble d''entrainement (Vrais)');
displayEchantillon(Xtrain(true_idxs, :), ytrain(true_idxs), pred_train(true_idxs), taille);

figure('Name', 'Ensemble d''entrainement (Faux)');
displayEchantillon(Xtrain(false_idxs, :), ytrain(false_idxs), pred_train(false_idxs), taille);


% Ensemble de validation
pred_cv = pred(Xcv, W1, W2);

true_idxs = find(ycv == pred_cv);
false_idxs = find(ycv ~= pred_cv);

figure('Name', 'Ensemble de validation (Vrais)');
displayEchantillon(Xcv(true_idxs, :), ycv(true_idxs), pred_cv(true_idxs), taille);

figure('Name', 'Ensemble de validation (Faux)');
displayEchantillon(Xcv(false_idxs, :), ycv(false_idxs), pred_cv(false_idxs), taille);


% Ensemble de test
pred_test = pred(Xtest, W1, W2);

true_idxs = find(ytest == pred_test);
false_idxs = find(ytest ~= pred_test);

figure('Name', 'Ensemble de test (Vrais)');
displayEchantillon(Xtest(true_idxs, :), ytest(true_idxs), pred_test(true_idxs), taille);

figure('Name', 'Ensemble de test (Faux)');
displayEchantillon(Xtest(false_idxs, :), ytest(false_idxs), pred_test(false_idxs), taille);



