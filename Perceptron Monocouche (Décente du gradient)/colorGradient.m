function map = colorGradient(color1, color2)
%-----------------------------------------------------------------------
%colorGradient - fonction générer une table de gradient de couleur (map)
%-----------------------------------------------------------------------
%Syntax: map = colorGradient(color1, color2)
%
%Inputs:
% color1 : couleur de départ (vecteur de 3 éléments RGB)
% color2 : couleur d'arrivée (vecteur de 3 éléments RGB)
%
%Outputs:
% map : matrice 100x3 contenant le gradient correspondant au couleurs
%       d'entrée.
%------------------------------------------------------------------------



    map = zeros(100, 3);
    
    for i = 1 : 3
        map(:, i) = linspace(color1(i), color2(i), 100)';
    end
    


end