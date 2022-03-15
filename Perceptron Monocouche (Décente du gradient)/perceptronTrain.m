function [w ,Htrain, Htest] = perceptronTrain(Xtrain, ytrain, w, alpha, lambda, iters, varargin)
%-----------------------------------------------------------------------
%perceptronTrain - fonction réaliser l'entrainement du perceptron
%                  monocouche
%-----------------------------------------------------------------------
%Syntax: [w, Htrain] = perceptronTrain(Xtr, ytr, w, alpha, lambda, iters)
%
%        [w, Htrain, Htest] = perceptronTrain(Xtr, ytr, w, 'Xtest', Xtest, ...
%                               'ytest', ytest)
%
%        [w, Htrain, Htest] = perceptronTrain(Xtr, ytr, w, alpha, lambda, ...
%                               iters, 'Xtest', Xtest, 'ytest', ytest)
%
%Inputs:
% Xtrain : matrice contenant les variables d'entrée d'entrainement
% ytrain : vecteur de labels d'entrainement
% w : vecteur de poids initial
% alpha : taux d'apprentissage (0.01 par défaut)
% lambda : taux de régularisation (0.01 par défaut)
% iters : nombre limite d'itérations (100 par défaut)
% Xtest : matrice contenant les variables d'entrée de test
% ytest ; vecteur de labels de test
%
%Outputs:
% w : vecteur de poids final (modèle)
% Htrain : Historique d'erreur d'entrainement
% Htest : Historique d'erreur de test
%------------------------------------------------------------------------

%----------------------------------------------------
% Input parser
%----------------------------------------------------
psr = inputParser;
withTest = false;

% Xtrain et Xtest doivent être des matrices contenant des nombres
X_valide = @(x) ismatrix(x) && isnumeric(x);

% w doit être un vecteur numerique
w_valide = @(x) isvector(x) && isnumeric(x);

% ytrain et ytest doivent être des vecteurs contenant des 1 ou 0.
y_valide = @(x) w_valide(x)  && all(x==0 | x==1);

% alpha, lambda et iters doivent être des scalaires positifs
param_valide = @(x) isscalar(x) && all(x>=0);

addRequired(psr, 'Xtrain', X_valide);
addRequired(psr, 'ytrain', y_valide);
addRequired(psr, 'w', w_valide);
addOptional(psr, 'alpha', 0.01, param_valide);
addOptional(psr, 'lambda', 0.01, param_valide);
addOptional(psr, 'iters', 100, param_valide);
addParameter(psr, 'Xtest', [], X_valide);
addParameter(psr, 'ytest', [], y_valide);


parse(psr, Xtrain, ytrain, w, alpha, lambda, iters, varargin{:});

Xtrain = psr.Results.Xtrain;
ytrain = psr.Results.ytrain;
w = psr.Results.w;
alpha = psr.Results.alpha;
lambda = psr.Results.lambda;
iters = round(psr.Results.iters); %entier
Xtest = psr.Results.Xtest;
ytest = psr.Results.ytest;

if ~isempty(Xtest) && ~isempty(ytest)
    if length(Xtest) == length(ytest)
        withTest = true;
    else
        error('Xtest et ytest doivent avoir la même taille');
    end
end

%----------------------------------------------------


% Fonction qui performe la regression logistique (par déscente du gradient)
% sur les données Xtrain labélisées par ytrain.
%
% logRegTrain prend comme entrées:
% Xtrain : matrice contenant les données
% ytrain : labels correspondants
% Xtest : matrice contenant les variables de test
% ytest : matrice contenant les labels de test
% w : poids initials
% alpha : TauXtrain d'apprentissage
% iters : nombre d'iterations
%
% logRegTrain retourne les poids appris (w) et l'historique d'erreurs.

    m = size(Xtrain, 1);
    Htrain = zeros(1, iters);
    Htest = 'none';
    if withTest
        Htest = Htrain;
    end
    
    for i = 1:iters
        % Vecteur des prédictions (Probabilités)
        h = sigmoid(Xtrain * w);
        
        % Calcul du gradient
        grad = Xtrain .* (h-ytrain);
%       grad = vmprod(h-ytrain, Xtrain);              % Pour Matlab 2012
        grad = 1/m * sum(grad)';
        
        wgrad = w;
        wgrad(1) = 0;
        
        grad = grad + 1/m * lambda * wgrad;
        
        % Mise à jour des poids
        w = w - alpha .* grad;
        
        % Calcul d'erreur
        Etr = errSCC(Xtrain, ytrain, w, lambda);
        Htrain(i) = Etr;
        
        if withTest
            Etst = errSCC(Xtest, ytest, w, lambda);
            Htest(i) = Etst;
        end
        
        % Affichage d'informations (progres)
        if withTest
            fprintf('Epoch[%d] - SCC (Train) : %d - SCC (Test) : %d\n', i, Etr, Etst);
        else
            fprintf('Epoch[%d] - SCC (Train) : %d\n', i, Etr);
        end
    end

end