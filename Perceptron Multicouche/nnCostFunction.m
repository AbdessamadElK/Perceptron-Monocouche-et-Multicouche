function [J, grad] = nnCostFunction(nn_params, ...
                                   nbr_in, ...
                                   nbr_cach, ...
                                   nbr_out, ...
                                   X, y, lambda)
                               
%-------------------------------------------------------------------------
%nnCostFunction - Fonction qui calcule l'erreur et les gradients des poids
%                 d'un Perceptron à une seule couche cachée.
%-------------------------------------------------------------------------
%
%Inputs:
%   nn_params : vecteur contenant tous les poids du réseaux
%   nbr_in : nombre d'entrées
%   nbr_cach : nombre de neurones de la couche cachée
%   nbr_out : nombre de sorties
%   X : Matrice des variables d'entrée
%   y : Vecteur de labels
%   lambda : Taux de régularisation
%
%Outputs:
%  J : Valeur de la fonction d'erreur
%  grad : vecteur contenant les poids de tous les poids
%-------------------------------------------------------------------------
%
%nnCostFunction est compatible avec la fonction fmincg qui nécéssite une
%fonction pour calculer J et grad.


[W1, W2] = unpack_w(nn_params, nbr_in, nbr_cach, nbr_out);

% Setup some useful variables
m = size(X, 1);

X = [ones(m, 1) X];

% label = (1 : nbr_out)';
label = (1 : nbr_out);


% Vectorized labels matrix
Y = label == y;

% Forward and backpropagation:
a1 = X;

z2 = a1 * W1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];

z3 = a2 * W2';
a3 = sigmoid(z3);

% Cost function:
J = 1/m * sum( sum( -Y .* log(a3) - (1-Y) .* log(1-a3) ));

% Cost function (regularisation):
J = J + 1/2/m * lambda * sum(sum(W1(:, 2:end).^2));
J = J + 1/2/m * lambda * sum(sum(W2(:, 2:end).^2));

% Backpropagation:
delta3 = a3 - Y;

delta2 = (delta3 * W2);
delta2 = delta2(:, 2:end);
delta2 = delta2 .* sigmoidGradient(z2);

W2_grad = 1/m * delta3' * a2;
W1_grad = 1/m * delta2' * a1;

% Gradient Regularisation:

W1(:, 1) = zeros(size(W1(:, 1)));
W2(:, 1) = zeros(size(W2(:, 1)));

W1_grad = W1_grad + lambda / m * W1;
W2_grad = W2_grad + lambda / m * W2;


grad = [W1_grad(:) ; W2_grad(:)];


end
