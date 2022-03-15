function z = plotProb(X, y, w, degree, varargin)

%------------------------------------------------------------------------
%plotData - fonction pour l'affichage de probabilités de classifiaction
%------------------------------------------------------------------------
%
%Syntax: plotProb(X, y, w, degree, mu, sigma, 'seuil', seuil)
%        plotProb(X, y, w, degree, 'seuil', seuil)
%        plotProb(X, y, w, degree)
%
%Inputs:
% X : matrice de coordonnées X1 et X2
% y : vecteur de labels
% w : vecteur de poids
% degree : degré de variables polynômiales
% mu : vecteur de moyennes des variables d'entrainement
%      par défaut : mu = 0
% sigma : vecteur d'écarts types des variables d'entrainement
%         par défaut : sigma = 1
% seuil : seuil de la décision pour tracer la frontière
%
% Note : mu et sigma sont utilisées seulement si l'ensemble d'entrainement
%        était normalisé avant l'entrainement.
%------------------------------------------------------------------------

%------------------------------------
% Input parser
%------------------------------------
p = inputParser;

% Xtrain et Xtest doivent être des matrices contenant des nombres
X_valide = @(x) ismatrix(x) && isnumeric(x);

% w doit être un vecteur numerique
w_valide = @(x) isvector(x) && isnumeric(x);

% ytrain et ytest doivent être des vecteurs contenant des 1 ou 0.
y_valide = @(x) w_valide(x)  && all(x==0 | x==1);

% mu et sigma doivent être des vecteurs
musigma_valide = @(x) isvector(x) && isnumeric(x);

% Le seuil est un scalaire ente 0 et 1
seuil_valide = @(x) isscalar(x) && all(x>=0 && x<=1);

addRequired(p, 'X', X_valide);
addRequired(p, 'y', y_valide);
addRequired(p, 'w', w_valide);
addOptional(p, 'mu', 0, musigma_valide);
addOptional(p, 'sigma', 1, musigma_valide);
addParameter(p, 'seuil', .5, seuil_valide);

parse(p, X, y, w, varargin{:});

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
        
        x = mapFeature(x(1), x(2), degree);
        
        % Prévoir:
        z(i,j) = sigmoid(x*w);
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
title('Distribution de probabilités');

% Seuillage (binairisation)
z = z > seuil;

figure;
plotData(X, y);

hold on;

colormap winter;
[C, h] = contour(u, v, z, 1, 'b');
set(h, 'LineWidth', 2);

legend('positif', 'négatif', 'frontière');
xlabel('X1');
ylabel('X2');
title('Frontière de décision');


end