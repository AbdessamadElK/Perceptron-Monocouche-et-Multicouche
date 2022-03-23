function [Xtrain, ytrain, Xcv, ycv, Xtest, ytest] = splitData(X, y, ptr, pcv)

m = size(X, 1);

ptr = round(m * ptr);
pcv = round(m * pcv);

ordre = randperm(m);
X = X(ordre, :);
y = y(ordre, :);

Xtrain = X(1:ptr,:);
ytrain = y(1:ptr, :);

Xcv = X(ptr+1:ptr+pcv, :);
ycv = y(ptr+1:ptr+pcv, :);

Xtest = X(ptr+pcv+1:end, :);
ytest = y(ptr+pcv+1:end, :);

end