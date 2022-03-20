function plotData(X, y, varargin)
%------------------------------------------------------------------------
%plotData - fonction pour l'affichage de donn�es (points sur un plan)
%------------------------------------------------------------------------
%
%Syntax: plotData(X, y, ['c1', 'c2'], 'bords', bords)
%        plotData(X, y)
%
%Inputs:
% X : matrice de coordonn�es X1 et X2
% y : vecteur de labels
% colors : vecteur de sp�cification de couleurs ['c1', 'c2']
%          ci = r, g, b, c, m, y, w ou k
%          par d�faut : colors = ['r', 'k']
% bords : pourcentage des bords par rapport � la surface occup�e par les
%         donn�es.
%         par d�faut : bords = 0
%
%------------------------------------------------------------------------


%----------------------------------------------------
% Input parser
%----------------------------------------------------
p = inputParser;

% Le seuil doit �tre un scalaire entre 0 et 1
color_valide = @(x) isvector(x) && ~isnumeric(x) && length(x)==2;

% Le bord doit �tre un pourcentage
bords_valide = @(x) isscalar(x) && all(x>= 0 && x<=1);

addRequired(p, 'X', @(x) ismatrix(x));
addRequired(p, 'y', @(x) isvector(x));
addOptional(p, 'colors', ['r', 'k'], color_valide);
addParameter(p, 'bords', 0, bords_valide);

parse(p, X, y, varargin{:});

X = p.Results.X;
y = p.Results.y;
colors = p.Results.colors;
bords = p.Results.bords;
%----------------------------------------------------

% La fonction commence ici:
    
    minx = min(X(:, 1));
    maxx = max(X(:, 1));
    
    miny = min(X(:, 2));
    maxy = max(X(:, 2));
    
    lenx = maxx - minx;
    leny = maxy - miny;
    

    data1 = X(find(y), :);
    data2 = X(find(~y), :);
    
    marker1 = sprintf("%so", colors(1));
    marker2 = sprintf("%sx", colors(2));
    
    plot(data1(:, 1), data1(:, 2), marker1 , 'markersize', 7);
    axis([minx-bords*lenx, maxx+bords*lenx, miny-bords*leny, maxy+bords*leny]);

    hold on;
    plot(data2(:, 1), data2(:, 2), marker2 , 'markersize', 7);
    
end