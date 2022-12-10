
function I1 = g_squares(translation, rotation, scale)
    
    % translation = [0 0];
    % rotation = [0];
    % scale = [0 0];
    
    
    canvas_size = [512, 512];
    size1 = 100;
    center = canvas_size./2;
    
    % xy coordinates
    [x,y] = meshgrid(1:canvas_size(1), 1:canvas_size(2));
    x = x - center(1);
    y = y - center(2);

    % apply scale
    x = x ./ scale(1);
    y = y ./ scale(2);

    

    % draw square
    I1 = (abs(x) < size1) & (abs(y) < size1);
    I1 = double(I1);
    
    I1 = imtranslate(I1, translation);
    I1 = imrotate(I1, rotation);


    cutted_part = [(size(I1,1) - 512), (size(I1,2) - 512)]/2;
    crop_rect = [cutted_part,  511, 511];
    I1 = imcrop(I1, crop_rect);



    I1 = imresize(I1, [512, 512]);

end

