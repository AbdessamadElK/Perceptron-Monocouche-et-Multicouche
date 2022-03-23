function [p] = pred(X, W1, W2)

%------------------------------------------------------------------------
%pred - Fonction pour calculer la sortie du perceptron multicouche � une
%       seule couche cah�e pour le cas de la multiclassification.
%------------------------------------------------------------------------
%
%Syntax: p = pred(X, W1, W2)
%
%Inputs:
% X : matrice de variables
% W1 : matrice de poids de passage de la couche 1 vers la couche cach�e
% W2 : matrice de poids de passage de la couche 2 vers la couche de sortie
%
%Outputs:
% p : Matrice de sorties du perceptron (pr�dictions)
%------------------------------------------------------------------------



m = size(X, 1);

% Propagation directe:
a1 = [ones(m, 1), X];

z2 = a1 * W1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];

z3 = a2 * W2';
a3 = sigmoid(z3);

% Pour la multiclassification, prendre la classe qui a la probabilit� la
% plus grande

[not_used, p] = max(a3, [], 2);

end