function p = pred(X, w)
%----------------------------------------------------------------
%pred - fonction pour calculer la sortie du perceptron monocouche
%----------------------------------------------------------------
%Syntax: p = pred(X,w)
%
%Inputs:
% X : matrice contenant les variables d'entrée
% w : vecteur de poids
%
%Outputs:
% p : vecteur contenant les sorties (prédictions) correspondantes à chaque
%     élément d'entrainement.

    p = sigmoid(X*w);
end