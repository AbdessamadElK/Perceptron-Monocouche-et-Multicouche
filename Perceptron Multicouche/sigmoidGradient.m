function res = sigmoidGradient(z)
%%------------------------------------------------------------------------
%sigmoid - D�riv�e de la fonction sigmo�de
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

% Au cas o� la fonction sigmoid n'est pas d�finie:
% if exist('sigmoid', 'file') ~= 2
%     sigmoid = @(x) 1 ./ (1 + exp(-z));
% end


res = sigmoid(z) .* (1-sigmoid(z));




end
