function [p] = pred(X, W1, W2)

%------------------------------------------------------------------------
%pred - Fonction pour calculer la sortie du perceptron multicouche à une
%       seule couche cahée.
%------------------------------------------------------------------------
%
%Syntax: p = pred(X, W1, W2)
%
%Inputs:
% X : matrice de variables
% W1 : matrice de poids de passage de la couche 1 vers la couche cachée
% W2 : matrice de poids de passage de la couche 2 vers la couche de sortie
%
%Outputs:
% p : Matrice de sorties du perceptron
%------------------------------------------------------------------------


m = ones(size(X, 1));

% Propagation directe:
a1 = [ones(m, 1), X];

z2 = a1 * W1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];

z3 = a2 * W2';
p = sigmoid(z3);

end