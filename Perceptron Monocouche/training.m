%% Entrainement du Perceptron Monocouche
clc, clear, close all;

% Chargement de donn�es
load('Data1.mat'); % vous pouvez essayer avec Data2.mat

plotData(X, y);
xlabel('X1');
ylabel('X2');
legend('positif', 'n�gatif');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;
%% Pr�paration de donn�es

% Il faut d'abord m�langer les donn�es (matrices X et y)
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

% Affichage de pr�cision en fonction des pas
plot(H);
xlabel('iterations');
ylabel('Pr�cision(w)');
title('Evolution de pr�cision');

fprintf('Programme en pause, appuiyer sur une touche pour continuer!\n');
pause;
close all;

%% Affichage de r�sultats

% Seuil de d�cision

% Affichage de la fronti�re de d�cision
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
        
        % Pr�voir:
        z(i,j) = x*w;  
    end
end

% Affichage:

z = z';

z = z >= 0; % Seuillage (binairisation)


% Fronti�re de d�cision:

figure;
plotData(X, y);

hold on;

colormap winter;
[C, h] = contour(u, v, z, 1, 'b');
set(h, 'LineWidth', 2);

legend('positive', 'negative', 'fronti�re');
xlabel('X1');
ylabel('X2');
title(sprintf('Fronti�re de d�cision'));


