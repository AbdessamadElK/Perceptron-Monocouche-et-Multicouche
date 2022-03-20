function displayImgData(X, y, imgsize)

quitcmd = '';

idx = 10;

colormap('gray');

while ~strcmp(quitcmd, 'quit')
    
    sample = X(idx, : );
    label = y(idx);
    
    if label == 10
        label = 0;
    end

    sample = reshape(sample, imgsize);

    imagesc(sample);

    title(sprintf('%d --> %d', idx, label));
    
    fprintf('Press enter to see other examples!\n')
    fprintf('Type: ''quit'' and hit enter to quit\n')
    
    quitcmd = input('', 's');
    idx = idx + 10;
    
    if idx > size(X, 1)
        break;
    end
    
end
end