function map = colorGradient(color1, color2)
%-----------------------------------------------------------------------
%colorGradient - fonction g�n�rer une table de gradient de couleur (map)
%-----------------------------------------------------------------------
%Syntax: map = colorGradient(color1, color2)
%
%Inputs:
% color1 : couleur de d�part (vecteur de 3 �l�ments RGB)
% color2 : couleur d'arriv�e (vecteur de 3 �l�ments RGB)
%
%Outputs:
% map : matrice 100x3 contenant le gradient correspondant au couleurs
%       d'entr�e.
%------------------------------------------------------------------------



    map = zeros(100, 3);
    
    for i = 1 : 3
        map(:, i) = linspace(color1(i), color2(i), 100)';
    end
    


end