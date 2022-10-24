clear all
close all
clc




images = [
%             src            ,     iterations,                filter
{"../images/lena_512x512.bmp",     [1 2 5 10], @(I1) imfilter(I1, fspecial('average',5)) ,"../zad3/lena_smooth"   }
{"../images/lena_512x512.bmp",     [1 2 5 10], @(I1) imsharpen(I1)                       ,"../zad3/lena_sharp"   }
{"../images/kodim23_512x512.png",  [1 2 5 10], @(I1) imfilter(I1, fspecial('average',5)) ,"../zad3/kodim_smooth"   }
{"../images/kodim23_512x512.png",  [1 2 5 10], @(I1) imsharpen(I1)                       ,"../zad3/kodim_sharp"   } 
]




for image = images'

    figure
    show_images(image)

end



function show_images(image)
    
    tiledlayout(2,1 + length(image{2}));
    
    tile_indexes = 1:(2*length(image{2}) + 2);
    tile_indexes = reshape(tile_indexes,[],2)';
    
    
    src = image{1};
    filter_iters = image{2};
    %filte_mat = image{3};
    filter_func = image{3};
    dest_folder = image{4};

    
    I1 = imread(src);
    I1 = double(I1)./256;
    I1 = rgb2gray(I1);
    
    [im_level, ~] = image_fft(I1);
    im_level = rescale(im_level);


    nexttile(tile_indexes(1,1))
    imshow(I1);
    
    nexttile(tile_indexes(2,1))
    imshow(im_level,[]);
    xlabel('Widmo mocy');



    mkdir(dest_folder)
    imwrite(I1, dest_folder + "/I1.png");
    imwrite(im_level, dest_folder + "/I1_mag.png");


    
    % filtering 
    x = 1;
    for iter = filter_iters
    
        I2 = I1;
        for i = 1:iter
            I2 = filter_func(I2);
        end
    
        [im_level, ~] = image_fft(I2);
        im_level = rescale(im_level);

        nexttile(tile_indexes(1,x + 1))
        imshow(I2);
        
        nexttile(tile_indexes(2,x + 1))
        imshow(im_level,[]);
        xlabel('Widmo mocy');


        imwrite(I2, dest_folder + "/I1_iter" + iter + ".png");
        imwrite(im_level, dest_folder + "/I1_iter" + iter + "_mag.png");
    
        x = x + 1;
    
    end


    Latex = [
"\newcommand{\ww}{0.19} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   "
"    \subfloat[O1]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
"    \subfloat[O1 - iteracja " + filter_iters(1) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(1) + ".png}}  \hfill% "
"    \subfloat[O1 - iteracja " + filter_iters(2) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(2) + ".png}}  \hfill%"
"    \subfloat[O1 - iteracja " + filter_iters(3) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(3) + ".png}}  \hfill"
"    \subfloat[O1 - iteracja " + filter_iters(4) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(4) + ".png}}  \hfill"
""
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(1) + "_mag.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(2) + "_mag.png}}  \hfill%"
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(3) + "_mag.png}} \hfill"
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_iter" + filter_iters(4) + "_mag.png}} \hfill"
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




