function res = sigmoid(z)
    %Fonction sigmo�de.
    res = 1 ./ (1 + exp(-z));
end