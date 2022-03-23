function displayEchantillon(X, y, p, taille)
    
%------------------------------------------------------------------------
%displayEchantillon - fonction pour afficher un �chantillon de 9 images
%                     d'un dataset.
%------------------------------------------------------------------------
%
%Syntax : displayEchantillon(X, y, p, taille)
%         displayEchantillon(X, y, [], taille)
%
%Inputs :
%   - X : matrice contenant les pixels (normalis�s par 1/255) de chaque
%         image du dataset
%   - y : vecteurs de labels
%   - taille : taille des images [nl, nc]
%   - p : vecteur de pr�dictions
%
% Il faut que nl x nc = size(X, 2)
%
%------------------------------------------------------------------------

    % D�normalisation
    X = uint8(X.*255);
    
    % Ordre arbitraire:
    shuffle = randperm(size(X, 1));
    
    X = X(shuffle, :);
    
    y = y(shuffle, :);
    
    % Remplasser les labels 10 par 0 (seulement pour notre Dataset dataDigits.mat)
    y(y==10) = 0;
    
    % Prendre les 9 premiers �chantillons
    X = X(1:9, :);
    y = y(1:9);
    
    if ~isempty(p)
        % M�me pour p, s'il n'est pas vide
        p = p(shuffle, :);
        
        p(p==10) = 0;
        
        p = p(1:9);
    end
    
    % Affichage
    for idx = 1 : length(y)
            
            img = X(idx, :);
            img = reshape(img, taille);
            
            subplot(3, 3, idx);
            imshow(img);
            
            if isempty(p)
                % Affichage sans pr�dictions
                title(sprintf(' label = %d', y(idx)));
            else
                % Affichage avec pr�dictions
                if p(idx) == y(idx)
                color = '\color{black}';
                else
                color = '\color{red}';
                end
                
                
                title(sprintf('%s p=%d | y=%d', color, p(idx), y(idx)));
                
            end  
            
    end
    
end