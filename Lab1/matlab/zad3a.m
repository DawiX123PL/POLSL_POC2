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


    I1 = imread("../zad1/rgb/0/" + name);
    I1 = double(I1) / 255;

    I1_1 = imread("../zad1/rgb/0.01/" + name);
    I1_1 = double(I1_1) / 255;

    I1_2 = imread("../zad1/rgb/0.02/" + name);
    I1_2 = double(I1_2) / 255;

    I1_3 = imread("../zad1/rgb/0.1/" + name);
    I1_3 = double(I1_3) / 255;
    
    I2_1 = filter_median(I1_1,1); % okno 3x3
    I2_2 = filter_median(I1_2,2); % okno 5x5
    I2_3 = filter_median(I1_3,3); % okno 7x7


    mkdir("../zad3a/" + dst_path);

    imwrite(cropImage(I1, crop), "../zad3a/" + dst_path + "/I1.png");

    imwrite(cropImage(I1_1, crop), "../zad3a/" + dst_path + "/I1_1.png");
    imwrite(cropImage(I1_2, crop), "../zad3a/" + dst_path + "/I1_2.png");
    imwrite(cropImage(I1_3, crop), "../zad3a/" + dst_path + "/I1_3.png");
    
    imwrite(cropImage(I2_1, crop), "../zad3a/" + dst_path + "/I2_1.png");
    imwrite(cropImage(I2_2, crop), "../zad3a/" + dst_path + "/I2_2.png");
    imwrite(cropImage(I2_3, crop), "../zad3a/" + dst_path + "/I2_3.png");
    


        Latex = [
""
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I1.png}}  \hfill% "
"   \subfloat[O1 + szum 1\% \\ psnr = " + psnr(I1_1,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I1_1.png}}  \hfill% "
"   \subfloat[O1 + szum 2\% \\ psnr = " + psnr(I1_2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I1_2.png}}  \hfill%"
"   \subfloat[O1 + szum 10\% \\ psnr = " + psnr(I1_3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I1_3.png}}  \hfill% "
"   "
"   \subfloat[]{"
"      \includegraphics[width=\ww\linewidth]{other/empty.png}}  \hfill% "
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I2_1,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I2_1.png}}  \hfill% "
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I2_2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I2_2.png}}  \hfill%"
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I2_3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3a/img1/I2_3.png}}  \hfill% "
"   "
"\end{figure} "
"\let\ww\undefined "
""
];

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad3a/" + dst_path + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);





end







