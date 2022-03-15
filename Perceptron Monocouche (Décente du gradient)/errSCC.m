function err = errSCC(X, y, w, lambda)
%-----------------------------------------------------------------------
%errSCC - fonction d'erreur (Sparse Categorical Crossentropy)
%-----------------------------------------------------------------------
%Syntax: err = accuracy(X, y, w, lambda)
%
%Inputs:
% X : matrice contenant les variables d'entrée
% y : vecteur de labels
% w : vecteur de poids
% lambda : taux de régularisation
%
%Outputs:
% err : Erreur correspondant aux entrées.
%------------------------------------------------------------------------


    m = size(X, 1);
    
    h = sigmoid(X * w);
    
    err = -1 /m * sum(y.*log(h) + (1-y) .* log(1-h));
    
    w(1) = 0;
    
    err = err + lambda /(2*m) * sum(w.^2);
end