function plotData(X, y, varargin)
%------------------------------------------------------------------------
%plotData - fonction pour l'affichage de données (points sur un plan)
%------------------------------------------------------------------------
%
%Syntax: plotData(X, y, 'colors', ['c1', 'c2'])
%        plotData(X, y)
%
%Inputs:
% X : matrice de coordonnées X1 et X2
% y : vecteur de labels
% colors : vecteur de spécification de couleurs ['c1', 'c2']
%          ci = r, g, b, c, m, y, w ou k
%          par défaut : colors = ['r', 'k']
%
%------------------------------------------------------------------------


%----------------------------------------------------
% Input parser
%----------------------------------------------------
p = inputParser;

% Le seuil doit être un scalaire entre 0 et 1

addRequired(p, 'X', @(x) ismatrix(x));
addRequired(p, 'y', @(x) isvector(x));
addOptional(p, 'colors', ['r', 'k']);

parse(p, X, y, varargin{:});

colors = p.Results.colors;
%----------------------------------------------------

% La fonction commence ici:
    
    minx = min(X(:, 1));
    maxx = max(X(:, 1));
    
    miny = min(X(:, 2));
    maxy = max(X(:, 2));
    
    lenx = maxx - minx;
    leny = maxy - miny;
    
    bdr = 0.1;

    data1 = X(find(y), :);
    data2 = X(find(~y), :);
    
    marker1 = sprintf("%so", colors(1));
    marker2 = sprintf("%sx", colors(2));
    
    plot(data1(:, 1), data1(:, 2), marker1 , 'markersize', 7);
    axis([minx-bdr*lenx maxx+bdr*lenx miny-bdr*leny maxy+bdr*leny]);

    hold on;
    plot(data2(:, 1), data2(:, 2), marker2 , 'markersize', 7);
    
end