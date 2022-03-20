function z = plotProb(X, y, W1, W2, varargin)

%------------------------------------------------------------------------
%plotData - fonction pour l'affichage de probabilit�s de classifiaction
%           (Perceptron Multicouches)
%------------------------------------------------------------------------
%
%Syntax: plotProb(X, y, W1, W2, mu, sigma, 'seuil', seuil)
%        plotProb(X, y, W1, W2, 'seuil', seuil)
%        plotProb(X, y, W1, W2)
%
%Inputs:
% X : matrice de coordonn�es X1 et X2
% y : vecteur de labels
% W1 : Matrice de passage 1
% W2 : Matrice de passage 2
% mu : vecteur de moyennes des variables d'entrainement
%      par d�faut : mu = 0
% sigma : vecteur d'�carts types des variables d'entrainement
%         par d�faut : sigma = 1
% seuil : seuil de la d�cision pour tracer la fronti�re
%
% Note : mu et sigma sont utilis�es seulement si l'ensemble d'entrainement
%        �tait normalis� avant l'entrainement.
%------------------------------------------------------------------------

%------------------------------------
% Input parser
%------------------------------------
p = inputParser;

% Xtrain et Xtest doivent �tre des matrices contenant des nombres
X_valide = @(x) ismatrix(x) && isnumeric(x);

% w doit �tre un vecteur numerique
w_valide = @(x) ismatrix(x) && isnumeric(x);

% ytrain et ytest doivent �tre des vecteurs contenant des 1 ou 0.
y_valide = @(x) w_valide(x)  && all(x==0 | x==1);

% mu et sigma doivent �tre des vecteurs
musigma_valide = @(x) isvector(x) && isnumeric(x);

% Le seuil est un scalaire ente 0 et 1
seuil_valide = @(x) isscalar(x) && all(x>=0 && x<=1);

addRequired(p, 'X', X_valide);
addRequired(p, 'y', y_valide);
addRequired(p, 'W1', w_valide);
addRequired(p, 'W2', w_valide);
addOptional(p, 'mu', 0, musigma_valide);
addOptional(p, 'sigma', 1, musigma_valide);
addParameter(p, 'seuil', .5, seuil_valide);

parse(p, X, y, W1, W2, varargin{:});

mu = p.Results.mu;
sigma = p.Results.sigma;
seuil = p.Results.seuil;

%------------------------------------

% La fonction commence ici:

color1 = [246 94 0] ./ 255;
color2 = [51 202 255] ./ 255;
myMap = colorGradient(color1, color2);

mins = min(X);
minx = mins(1);
miny = mins(2);

maxs = max(X);
maxx = maxs(1);
maxy = maxs(2);

u = linspace(minx, maxx, 300);
v = linspace(miny, maxy, 300);

z = zeros(length(u), length(v));

for i = 1:length(u)
    for j = 1:length(v)
        x = [u(i) v(j)];
        
        x = (x - mu) ./ sigma;
        
        % Pr�voir:
        z(i,j) = pred(x, W1, W2);
    end
end

z = z';

figure;

colormap(myMap);
[C, h] = contourf(u, v, z, 20);
set(h, 'LineColor', 'none');
colorbar;
hold on;
plotData(X, y, ['w', 'w']);

xlabel('X1');
ylabel('X2');
title('Distribution de probabilit�s');

% Seuillage (binairisation)
z = z > seuil;

figure;
plotData(X, y);

hold on;

colormap winter;
[C, h] = contour(u, v, z, 1, 'b');
set(h, 'LineWidth', 2);

legend('positif', 'n�gatif', 'fronti�re');
xlabel('X1');
ylabel('X2');
title('Fronti�re de d�cision');


end