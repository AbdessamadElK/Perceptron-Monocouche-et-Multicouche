function res = sigmoid(z)
    %Fonction sigmoïde.
    res = 1 ./ (1 + exp(-z));
end