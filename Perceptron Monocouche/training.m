%% Entrainement du Perceptron Monocouche
clc, clear, close all;

% Chargement de données
load('Data1.mat'); % vous pouvez essayer avec Data2.mat

plotData(X, y);
xlabel('X1');
ylabel('X2');
legend('positif', 'négatif');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;
%% Préparation de données

% Il faut d'abord mélanger les données (matrices X et y)
ordre = randperm(size(X, 1));
X = X(ordre, :);
y = y(ordre);
 
% Normalisation
Xt = X;
[Xt, mu, sigma] = normData(Xt);

% Ajout du biais
Xt = [ones(size(Xt, 1), 1), Xt];

%% Entrainnement

% Initialisation des poids
w = zeros(size(Xt, 2), 1);

% Entrainnement
[w, H] = perceptronTrain(Xt, y, w);

% Affichage de précision en fonction des pas
plot(H);
xlabel('iterations');
ylabel('Précision(w)');
title('Evolution de précision');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%% Affichage de résultats

% Seuil de décision

% Affichage de la frontiére de décision
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
        
        x = [1, x];
        
        % Prévoir:
        z(i,j) = x*w;  
    end
end

% Affichage:

z = z';

z = z >= 0; % Seuillage (binairisation)


% Frontiére de décision:

figure;
plotData(X, y);

hold on;

colormap winter;
[C, h] = contour(u, v, z, 1, 'b');
set(h, 'LineWidth', 2);

legend('positive', 'negative', 'frontière');
xlabel('X1');
ylabel('X2');
title(sprintf('Frontière de décision'));


