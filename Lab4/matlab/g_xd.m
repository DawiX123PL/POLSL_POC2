
function I1 = g_xd(translation, rotation, scale)

    source = "../images/xD.png";

    % translation = [0 0];
    % rotation = [0];
    % scale = [0 0];
    
    I1 = imread(source);
    I1 = double(I1) ./ 255;
    
    if(size(I1,3) ~= 1)
        I1 = rgb2gray(I1);
    end
    
    canvas_size = [512, 512];
    size1 = 100;
    center = canvas_size./2;
    
    
    I1 = imrotate(I1, rotation);

    
    I1 = imresize(I1, scale.*canvas_size);



    I1 = [ zeros(size(I1,1), 500), I1, zeros(size(I1,1), 500)];
    I1 = [ zeros(500, size(I1,2)); I1; zeros(500, size(I1,2))];

    cutted_part = ((scale-1).*canvas_size)/2 + 500;

    crop_rect = [cutted_part,  511, 511];
    I1 = imcrop(I1, crop_rect);


    I1 = imtranslate(I1, translation);

    I1 = imresize(I1, [512, 512]);

end

