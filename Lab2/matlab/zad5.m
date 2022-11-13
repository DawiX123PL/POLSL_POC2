clear all
close all
clc


images = [
%             src             
{"../images/lena_512x512.bmp"}
{"../images/kodim23_512x512.png"}
{"../images/lena_512x512.bmp"}
{"../images/kodim23_512x512.png"}
]


show_images(images(1))


function show_images(image)
    
    tiledlayout(2, 3, 'TileSpacing','none');

    src = image{1};

    I1 = imread(src);
    I1 = double(I1)./256;
    I1 = rgb2gray(I1);


    I2 = I1 + .3 * sinImage(size(I1), [.2 .2]);


    [im_level, ~, L1] = image_fft(I2);
    im_level = rescale(im_level);

    mask = sinMask(size(I2), [15 15],[1 1]);
%    mask = mask /2 + 0.5;

    mask2 = mask;
   

    nexttile
    imshow(I2);

    nexttile
    imshow(im_level);

    nexttile
    imshow(mask2);

    nexttile
    W = im_level;
    imshow([mask2(:,1:100), W(:, 400:end) ]);

    nexttile
    imshow(im_level .* mask2);

    nexttile
    imshow(image_ifft(L1 .* mask2));


end



function M = sinMask(dim, pos, width)

    M1 = ones(dim);
    M2 = ones(dim);

    center = ceil( dim./2 + 1 );

    M1(:, round(center + pos(1)):round(center + pos(1) + width(1)) ) = 0;
    M1(:, round(center - pos(1)):-1:round(center - pos(1) - width(1)) ) = 0;
    
    M2(round(center + pos(1)):round(center + pos(1) + width(1)), :) = 0;
    M2(round(center - pos(1)):-1:round(center - pos(1) - width(1)), :) = 0;


    M1 = imfilter(M1, fspecial('gaussian',3,2));
    M2 = imfilter(M2, fspecial('gaussian',3,2));

    M = min(M1,M2);

    m1 = min(M(50:end-50, 50:end-50), [], 'all');

     M = M - m1;

end


function I1 = sinImage(dim, multi)
    
    [X,Y] = meshgrid(1:dim(1), 1:dim(2));
    I1 = sin(X*multi(1) + Y*multi(2));
    I1 = (1 + I1)./2;

end



