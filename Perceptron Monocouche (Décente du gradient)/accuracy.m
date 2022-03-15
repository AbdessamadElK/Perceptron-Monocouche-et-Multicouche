function acc = accuracy(X, y, w, varargin)

%-----------------------------------------------------------------------
%accuracy - fonction pour calculer la précision du perceptron monocouche
%-----------------------------------------------------------------------
%Syntax: acc = accuracy(X, y, w, 'seuil', s)
%        acc = accuracy(X, y, w)
%
%Inputs:
% X : matrice contenant les variables d'entrée
% y : vecteur de labels
% w : vecteur de poids
% s : seuil de décision (0.5 par défaut)
%
%Outputs:
% acc : La valeur de la précision du perceptron monocouche, définie par
%       le rapport du nombre d'éléments classifiés correctement sur le 
%       le nombre d'éléments de l'ensemble.
%------------------------------------------------------------------------

%----------------------------------------------------
% Input parser
%----------------------------------------------------
psr = inputParser;

% Le seuil doit être un scalaire entre 0 et 1
seuil_valide = @(x) isscalar(x) && x >= 0 && x <= 1;

addRequired(psr, 'X');
addRequired(psr, 'y');
addRequired(psr, 'w');
addOptional(psr, 'seuil', .5, seuil_valide);

parse(psr, X, y, w, varargin{:});

seuil = psr.Results.seuil;
%----------------------------------------------------

% La fonction commence ici:

m = length(y);

p = pred(X, w);

p = p >= seuil;

% il faut avoir p=y (cád p=0,y=0 ou p=1,y=1) c'est la fonction NXOR
p = not(xor(p, y));

acc = sum(p) ./ m ;
 
end