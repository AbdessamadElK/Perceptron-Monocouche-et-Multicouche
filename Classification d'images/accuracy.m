function acc = accuracy(X, y, W1, W2)
%-----------------------------------------------------------------------
%accuracy - fonction pour calculer la pr�cision du perceptron multicouches
%           � une seule couche cach�e.
%-----------------------------------------------------------------------
%Syntax: acc = accuracy(X, y, W1, W2)
%
%Inputs:
% X : Matrice contenant les variables d'entr�e
% y : Vecteur de labels
% W1 : Matrice de passage 1
% W2 : Matrice de passage 2
%
%Outputs:
% acc : La valeur de la pr�cision du perceptron monocouche, d�finie par
%       le rapport du nombre d'�l�ments classifi�s correctement sur le 
%       le nombre d'�l�ments de l'ensemble.
%------------------------------------------------------------------------

m = size(y, 1);

p = pred(X, W1, W2);

V = p == y;

acc = length(find(V));

acc = acc / m;

end