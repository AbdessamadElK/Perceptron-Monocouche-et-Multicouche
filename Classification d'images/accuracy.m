function acc = accuracy(X, y, W1, W2)
%-----------------------------------------------------------------------
%accuracy - fonction pour calculer la précision du perceptron multicouches
%           à une seule couche cachée.
%-----------------------------------------------------------------------
%Syntax: acc = accuracy(X, y, W1, W2)
%
%Inputs:
% X : Matrice contenant les variables d'entrée
% y : Vecteur de labels
% W1 : Matrice de passage 1
% W2 : Matrice de passage 2
%
%Outputs:
% acc : La valeur de la précision du perceptron monocouche, définie par
%       le rapport du nombre d'éléments classifiés correctement sur le 
%       le nombre d'éléments de l'ensemble.
%------------------------------------------------------------------------

m = size(y, 1);

p = pred(X, W1, W2);

V = p == y;

acc = length(find(V));

acc = acc / m;

end