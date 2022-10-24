clear all
close all
clc




images_triangle_rot = [
%                    path,  rotation, translation, scale
{"../images/triangle.png",         0,       [0 0],    1 }
{'../images/triangle.png',        15,       [0 0],    1 }
{'../images/triangle.png',        29,       [0 0],    1 }
{'../images/triangle.png',        50,       [0 0],    1 }
]

images_triangle_pos = [
%                    path,  rotation,  translation,  scale
{"../images/triangle.png",         0,        [0 0],    1 }
{'../images/triangle.png',         0,      [30 30],    1 }
{'../images/triangle.png',         0,    [100 100],    1 }
{'../images/triangle.png',         0,   [-100 -20],    1 }
]

images_circle_pos = [
%                  path,  rotation, translation,    scale
{"../images/circle.png",         0,         [0 0],    1 }
{'../images/circle.png',         0,       [30 30],    1 }
{'../images/circle.png',         0,     [100 100],    1 }
{'../images/circle.png',         0,    [-100 -20],    1 }
]


images_circle_scale = [
%                  path, rotation, translation, scale
{"../images/circle.png",        0,       [0 0],     1 }
{'../images/circle.png',        0,       [0 0],    .5 }
{'../images/circle.png',        0,       [0 0],     2 }
{'../images/circle.png',        0,       [0 0],     3 }
]


images_line_rot = [
%                 path,  rotation,  translation, scale
{"../images/lines.png",         0,        [0 0],     1 }
{'../images/lines.png',        15,        [0 0],     1 }
{'../images/lines.png',        29,        [0 0],     1 }
{'../images/lines.png',        50,        [0 0],     1 }
]

images_sine = [
%            path,  rotation,    translation,   scale
{       [.20 .20],         0,          [0 0],       1 }
{      [.05 .005],         0,          [0 0],       1 }
{        [1  .01],         0,          [0 0],       1 }
{         [.01 1],         0,          [0 0],       1 }
]


figure;
show_images(images_triangle_rot, "../zad2/triangle_rot");

figure;
show_images(images_triangle_pos, "../zad2/triangle_pos");

figure;
show_images(images_circle_pos, "../zad2/circle_pos");

figure;
show_images(images_circle_scale, "../zad2/circle_scale");

figure;
show_images(images_line_rot, "../zad2/line_rot");

figure;
show_images(images_sine, "../zad2/sine");



function show_images(images, dest_folder)

    mkdir(dest_folder);

    
    tiledlayout(3,size(images, 1), 'TileSpacing','none');
    
    tile_indexes = 1:(3*size(images, 1));
    tile_indexes = reshape(tile_indexes,[],3)';
    
    
    for tile_index = tile_indexes
    
        image = images(tile_index(1),:);
    
        src   = image{1};
        rot   = image{2};
        trans = image{3};
        scale = image{4};

        if isa(src, 'string') || isa(src, 'char') 
            I1 = imread(src);
            I1 = double(I1)./256;
            I1 = rgb2gray(I1);
        

            orig_size = size(I1);

            I1 = imrotate(I1, rot);
            I1 = imtranslate(I1, trans);
            I1 = imresize(I1, scale);

            if (orig_size - size(I1)) >= 0
                w = (orig_size - size(I1)) /2;
                w = w + [.1, -.1];
                w = round(w);
                I1 = padarray(I1, w, 0);
            else
                I1 = imcrop(I1, centerCropWindow2d(size(I1), orig_size));
            end

        elseif isa(src, 'double')
            [X,Y] = meshgrid(1:512, 1:512);
            I1 = sin(X*src(1) + Y*src(2));
            I1 = (1 + I1)./2;
        end
        
    
    
        [im_level, im_angle] = image_fft(I1);

        % scale values
        im_level = rescale(im_level);
        im_angle = rescale(im_angle);
    
        nexttile(tile_index(1))
        imshow(I1);
    
        nexttile(tile_index(2))
        imshow(im_level);
        xlabel('Widmo mocy');
    
        nexttile(tile_index(3))
        imshow(im_angle);
        xlabel('Faza');
    
        imwrite(I1, dest_folder + "/I" + tile_index(1) + ".png")
        imwrite(im_level, dest_folder + "/I" + tile_index(1) + "_mag.png")
        imwrite(im_angle, dest_folder + "/I" + tile_index(1) + "_angle.png")

    end


    trans2str = @(tran) "(" + tran(1) + ", " + tran(1) + ")"

    Latex = [
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   "
"    \subfloat[O1 \\ rot = " + string(images{1,2}) + " \\ trans = " + trans2str(images{1,3}) + " \\ scale = " + string(images{1,4}) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
"    \subfloat[O1 \\ rot = " + string(images{2,2}) + " \\ trans = " + trans2str(images{2,3}) + " \\ scale = " + string(images{2,4}) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2.png}}  \hfill% "
"    \subfloat[O1 \\ rot = " + string(images{3,2}) + " \\ trans = " + trans2str(images{3,3}) + " \\ scale = " + string(images{3,4}) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I3.png}}  \hfill%"
"    \subfloat[O1 \\ rot = " + string(images{4,2}) + " \\ trans = " + trans2str(images{4,3}) + " \\ scale = " + string(images{4,4}) + "]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I4.png}}  \hfill"
""
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_mag.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_mag.png}}  \hfill% "
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I3_mag.png}}  \hfill%"
"    \subfloat[Widmo mocy]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I4_mag.png}} \hfill"
""
"    \subfloat[Faza]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_angle.png}}  \hfill% "
"    \subfloat[Faza]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_angle.png}}  \hfill% "
"    \subfloat[Faza]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I3_angle.png}}  \hfill%"
"    \subfloat[Faza]{"
"        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I4_angle.png}}"
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






