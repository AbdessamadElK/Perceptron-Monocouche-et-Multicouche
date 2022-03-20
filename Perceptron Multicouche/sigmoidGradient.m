function res = sigmoidGradient(z)
%%------------------------------------------------------------------------
%sigmoid - Dérivée de la fonction sigmoïde
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

% Au cas où la fonction sigmoid n'est pas définie:
% if exist('sigmoid', 'file') ~= 2
%     sigmoid = @(x) 1 ./ (1 + exp(-z));
% end


res = sigmoid(z) .* (1-sigmoid(z));




end
