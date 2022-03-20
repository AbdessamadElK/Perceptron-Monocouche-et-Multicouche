function res = sigmoid(z)
%------------------------------------------------------------------------
%sigmoid - Fonction sigmoïde
%------------------------------------------------------------------------
%
%Syntax: res = sigmoid(z)
%
%Inputs:
% z : Matrice, Vecteur ou Scalaire d'entrée
%
%Outputs:
% res : Resultats
%------------------------------------------------------------------------
    res = 1 ./ (1 + exp(-z));
end