function [normX, mu, sigma] = normData(X)
%------------------------------------------------------------------------
%normData - fonction qui régularise la matrice X (régularisation standard)
%------------------------------------------------------------------------
%Fonctionnement:
%   Chaque colone est régularisée séparemment par soustraction de sa
%   moyenne (mu) et division par son écart type (sigma).
%
%Syntax: [normX, my, sigma] = normData(X)
%
%Inputs:
% X : matrice à régulariser
%
%Outputs:
% normX : matrice régularisée
% mu : vecteur contenant les moyennes de chaque colone
% sigma : vecteur contenant les écarts types de chaque colone
%------------------------------------------------------------------------

    m = size(X, 1);
    
    mu = mean(X);
    sigma = std(X);
    
    muMat = repmat(mu, m, 1);
    sigMat = repmat(sigma, m, 1);
    
    normX = (X - muMat) ./ sigMat;

end

