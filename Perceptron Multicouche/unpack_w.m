function [W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out)

%%------------------------------------------------------------------------
%unpack_w - Fonction pour restaurer les matrices W1 et W2 � partir d'un
%           vecteur.
%------------------------------------------------------------------------
%
%Syntax: [W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out)
%
%Inputs:
%   nn_params : vecteur contenant tous les poids du r�seaux
%   nbr_in : nombre d'entr�es
%   nbr_cach : nombre de neurones de la couche cach�e
%   nbr_out : nombre de sorties
%
%Outputs:
% W1 : Matrice de passage 1
% W2 : Matrice de passage 2
%------------------------------------------------------------------------


W1 = reshape(nn_params(1:nbr_cach * (nbr_in + 1)), ...
                 nbr_cach, (nbr_in + 1));

W2 = reshape(nn_params((1 + (nbr_cach * (nbr_in + 1))):end), ...
                 nbr_out, (nbr_cach + 1));
end