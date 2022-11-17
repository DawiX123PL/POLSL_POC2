clear all
close all
clc


images = [
%             src              ,  mask
{"../images/lena_512x512.bmp",    { "circle", 100,  40}, "../zad4/lena_circ"  }
{"../images/kodim23_512x512.png", { "circle", 100,  40}, "../zad4/kodim_circ"  }
{"../images/lena_512x512.bmp",    { "gauss",  150,  70}, "../zad4/lena_gauss"  }
{"../images/kodim23_512x512.png", { "gauss",  150,  70}, "../zad4/kodim_gauss"  }
{"../images/lena_512x512.bmp",    { "invcircle", 100,  40}, "../zad4/lena_invcirc"  }
{"../images/kodim23_512x512.png", { "invcircle", 100,  40}, "../zad4/kodim_invcirc"  }
{"../images/lena_512x512.bmp",    { "invgauss",  150,  70}, "../zad4/lena_invgauss"  }
{"../images/kodim23_512x512.png", { "invgauss",  150,  70}, "../zad4/kodim_invgauss"  }
]





for image = images'
    show_images(image)
end


function show_images(image)
    
    
    tiledlayout(2, 5, 'TileSpacing','none');
    
    src = image{1};
    mask = image{2};
    dest_folder = image{3};

    
    I1 = imread(src);
    I1 = double(I1)./256;
    I1 = rgb2gray(I1);
    
    
    [im_level, ~, L1] = image_fft(I1);
    im_level = rescale(im_level);
    
    if mask{1} == "circle" 
        im_mask1 = MaskCircle(size(I1), mask{2});
        im_mask2 = MaskCircle(size(I1), mask{3});
    elseif mask{1} == "gauss" 
        im_mask1 = MaskGauss(size(I1), mask{2});
        im_mask2 = MaskGauss(size(I1), mask{3});
    elseif mask{1} == "invcircle"
        im_mask1 = MaskCircle(size(I1), mask{2})*-1 + 1;
        im_mask2 = MaskCircle(size(I1), mask{3})*-1 + 1;
    elseif mask{1} == "invgauss"
        im_mask1 = MaskGauss(size(I1), mask{2})*-1 + 1;
        im_mask2 = MaskGauss(size(I1), mask{3})*-1 + 1;
    end


    % mask 1
    nexttile
    imshow(I1);
    
    nexttile
    imshow(im_level,[]);
    
    nexttile
    imshow(im_mask1);
    
    nexttile
    imshow(im_level .* im_mask1 , []);
    
    nexttile
    imshow(image_ifft(L1 .* im_mask1));
    
    % mask 1
    nexttile
    imshow(I1);
    
    nexttile
    imshow(im_level,[]);
    
    nexttile
    imshow(im_mask2);
    
    nexttile
    imshow(im_level .* im_mask2  , []);
    
    nexttile
    imshow(image_ifft(L1 .* im_mask2));

    mkdir(dest_folder)
    imwrite(I1,                         dest_folder + "/I1.png");
    imwrite(im_level,                   dest_folder + "/I1_mag.png");
    imwrite(im_mask1,                   dest_folder + "/I1_mask1.png");
    imwrite(im_level .* im_mask1,       dest_folder + "/I1_mag_mask1.png");
    imwrite(image_ifft(L1 .* im_mask1), dest_folder + "/I1_1.png");

    % imwrite(I1,                         dest_folder + "/I1.png");
    % imwrite(im_level,                   dest_folder + "/I1_mag.png");
    imwrite(im_mask2,                   dest_folder + "/I1_mask2.png");
    imwrite(im_level .* im_mask2,       dest_folder + "/I1_mag_mask2.png");
    imwrite(image_ifft(L1 .* im_mask2), dest_folder + "/I1_2.png");



    
    Latex = [
"\newcommand{\ww}{0.19} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   "
"    \subfloat[O1]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag.png}}  \hfill% "
"    \subfloat[Maska 1]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mask1.png}}  \hfill%"
"    \subfloat[Widmo mocy * Maska 1]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag_mask1.png}}  \hfill"
"    \subfloat[O1 przefiltrowany]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_1.png}}  \hfill"
""
"    \subfloat[O1]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag.png}}  \hfill% "
"    \subfloat[Maska 2]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mask2.png}}  \hfill%"
"    \subfloat[Widmo mocy * Maska 2]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag_mask2.png}} \hfill"
"    \subfloat[O1 przefiltrowany]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_2.png}} \hfill"
""
"\caption{Porownanie}  "
" "
"\end{figure} "
"\let\ww\undefined "
    ]

    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen(dest_folder + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);



end






function M = MaskCircle(dim, r)

    x = (1:dim(1)) - dim(1)/2;
    y = (1:dim(2)) - dim(2)/2;
    [X, Y] = meshgrid(x, y);

    R2 = X.*X + Y.*Y;
    r2 = r.*r;

    M = R2 < r2;
    M = double(M);

end



function M = MaskGauss(dim, sigma)

    x = (1:dim(1)) - dim(1)/2;
    y = (1:dim(2)) - dim(2)/2;
    [X, Y] = meshgrid(x, y);

    R = sqrt(X.*X + Y.*Y);

    M = normpdf(R, 1,sigma);
    M = M ./ max(M, [], "all");

end













