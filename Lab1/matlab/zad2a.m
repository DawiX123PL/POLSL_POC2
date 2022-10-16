clear all
close all
clc


images = {
    "img1", "img_1.png", [.1 .4 .4 .1]
}

convert_image(images(1,:));


function convert_image(names)

    dst_path = string(names(1));
    name = string(names(2));
    crop = cell2mat(names(3));

    I1 = imread("../zad1/gray/0/" + name);
    I1 = double(I1) / 255;
    I2 = imread("../zad1/gray/0.02/" + name);
    I2 = double(I2) / 255;
    I3 = filter_median(I2,1); % okno 3x3
    I4 = filter_median(I2,2); % okno 5x5
    I5 = filter_median(I2,3); % okno 7x7


    mkdir("../zad2a/" + dst_path);

    imwrite(cropImage(I1, crop), "../zad2a/" + dst_path + "/I1.png");
    imwrite(cropImage(I2, crop), "../zad2a/" + dst_path + "/I2.png");
    imwrite(cropImage(I3, crop), "../zad2a/" + dst_path + "/I3.png");
    imwrite(cropImage(I4, crop), "../zad2a/" + dst_path + "/I4.png");
    imwrite(cropImage(I5, crop), "../zad2a/" + dst_path + "/I5.png");



    Latex = [
"\newcommand{\ww}{0.19} "
"\begin{figure}[H]  "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} %   " 
"   \subfloat[O1]{  "
"      \includegraphics[width=\ww\linewidth]{../zad2a/img1/I1.png}}  \hfill%   "
"   \subfloat[O1 + 2\% \\ psnr=" + psnr(I2,I1) + "]{  "
"      \includegraphics[width=\ww\linewidth]{../zad2a/img1/I2.png}}  \hfill%   "
"   \subfloat[mediana 3x3 \\ psnr=" + psnr(I3,I1) + "]{  "
"      \includegraphics[width=\ww\linewidth]{../zad2a/img1/I3.png}}  \hfill%   "
"   \subfloat[mediana 5x5 \\ psnr=" + psnr(I4,I1) + "]{  "
"      \includegraphics[width=\ww\linewidth]{../zad2a/img1/I4.png}}  \hfill%  "
"   \subfloat[mediana 7x7 \\ psnr=" + psnr(I5,I1) + "]{  "
"      \includegraphics[width=\ww\linewidth]{../zad2a/img1/I5.png}}  "
"\caption{Porownanie}    "
""
"\end{figure}" 
"\let\ww\undefined" 
]

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad2a/" + dst_path + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);


end







