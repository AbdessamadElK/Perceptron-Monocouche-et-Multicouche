function [normX, mu, sigma] = normData(X)
%------------------------------------------------------------------------
%normData - fonction qui r�gularise la matrice X (r�gularisation standard)
%------------------------------------------------------------------------
%Fonctionnement:
%   Chaque colone est r�gularis�e s�paremment par soustraction de sa
%   moyenne (mu) et division par son �cart type (sigma).
%
%Syntax: [normX, my, sigma] = normData(X)
%
%Inputs:
% X : matrice � r�gulariser
%
%Outputs:
% normX : matrice r�gularis�e
% mu : vecteur contenant les moyennes de chaque colone
% sigma : vecteur contenant les �carts types de chaque colone
%------------------------------------------------------------------------

    m = size(X, 1);
    
    mu = mean(X);
    sigma = std(X);
    
    muMat = repmat(mu, m, 1);
    sigMat = repmat(sigma, m, 1);
    
    normX = (X - muMat) ./ sigMat;

end

