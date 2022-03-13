function [w, H] = perceptronTrain(X, y, w, varargin)
%------------------------------------------------------------------------
%perceptronTrain - fonction qui réalise l'entrainement du perceptron
%                  monocouche (algorithme 1)
%------------------------------------------------------------------------
%
%Syntax: [w, H] = perceptronTrain(X, y, w, 'itersLimit', lim)
%        [w, H] = perceptronTrain(X, y, w)
%
%Inputs:
% X : matrice de variables (dataset)
% y : vecteur de labels
% w : vecteur de poids initial
% itersLimit (lim) : Nombre limite d'itérations (100 par défaut)
%
%Outputs:
% w : vecteur de poids final (modèle)
% H : Historique d'erreur (pour affichage)
%------------------------------------------------------------------------

%----------------------------------------------------
% Input parser
%----------------------------------------------------
p = inputParser;

% Le seuil doit être un scalaire entre 0 et 1
limit_valide = @(x) isscalar(x) && x >= 1;

addRequired(p, 'X');
addRequired(p, 'y');
addRequired(p, 'w');
addOptional(p, 'itersLimit', 100, limit_valide);

parse(p, X, y, w, varargin{:});

itersLimit = p.Results.itersLimit;
%----------------------------------------------------

H = [];
m = size(X, 1);

convergence = false;
count = 0;

while ~convergence
    convergence = true;
    
    for j = 1:m
        p = X(j, :) * w;
        if p <= 0 && y(j) == 1
            w = w + X(j, :)';
            convergence = false;
        elseif p > 0 && y(j) == 0
            w = w - X(j, :)';
            convergence = false;
        end
        H = [H accuracy(X, y, w)];
    end
    
    count = count + 1;
    if count >= itersLimit
        convergence = true;
    end

end

end