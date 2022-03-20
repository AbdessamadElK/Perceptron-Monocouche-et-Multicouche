function res = sigmoid(z)
%------------------------------------------------------------------------
%sigmoid - Fonction sigmo�de
%------------------------------------------------------------------------
%
%Syntax: res = sigmoid(z)
%
%Inputs:
% z : Matrice, Vecteur ou Scalaire d'entr�e
%
%Outputs:
% res : Resultats
%------------------------------------------------------------------------
    res = 1 ./ (1 + exp(-z));
end