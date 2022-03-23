function [W] = randInitW(n_in, n_out, varargin)
    
%--------------------------------------------------------------------------
%randInitW - Fonction pour initialiser une matrice de passage par des poids
%            arbitraires.
%--------------------------------------------------------------------------
%
%Syntax: W = randInitW(n_in, n_out, epsilon)
%        W = randInitW(n_in, n_out)
%
%Fonctionnement:
%   La fonction génére une matrice de taille (n_out, n_in + 1) contenant
%   des valeurs arbitraires entre -epsilon et +epsilon.
%
%Inputs:
% n_in : nombre de neurones de la couche de départ
% n_out : nombre de neurones de la couche de déstination
% epsilon : limite de la valeur absolue des poids
%           (par défaut : epsilon = 0.12)
%--------------------------------------------------------------------------


%----------------------------------------------------
% Input parser
%----------------------------------------------------
p = inputParser;

% Le seuil doit être un scalaire entre 0 et 1
input_valide = @(x) isscalar(x) && isnumeric(x);


addRequired(p, 'n_in', input_valide);
addRequired(p, 'n_out', input_valide);
addOptional(p, 'epsilon', .12, input_valide);

parse(p, n_in, n_out, varargin{:});

n_in = p.Results.n_in;
n_out = p.Results.n_out;
epsilon = p.Results.epsilon;

n_in = round(n_in);
n_out = round(n_out);

%----------------------------------------------------

    % La fonction commence ici
    
    W = rand(n_out, n_in + 1);
    
    % Pour obtenir des valeurs entre -epsilon et epsilon
    W = W * 2 * epsilon - epsilon;
    
end