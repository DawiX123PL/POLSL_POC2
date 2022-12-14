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
    I3 = filter_LUM(I2,1,0); % okno 3x3, K = 0
    I4 = filter_LUM(I2,1,1); % okno 3x3, K = 1
    I5 = filter_LUM(I2,1,2); % okno 3x3, K = 2
    I6 = filter_LUM(I2,1,3); % okno 3x3, K = 3
    I7 = filter_LUM(I2,1,4); % okno 3x3, K = 4
    I8 = filter_LUM(I2,2,0); % okno 5x5, K = 0


    I1 = I1(3:end-3, 3:end-3); 
    I2 = I2(3:end-3, 3:end-3);
    I3 = I3(3:end-3, 3:end-3);
    I4 = I4(3:end-3, 3:end-3);
    I5 = I5(3:end-3, 3:end-3);
    I6 = I6(3:end-3, 3:end-3);
    I7 = I7(3:end-3, 3:end-3);
    I8 = I8(3:end-3, 3:end-3);


    mkdir("../zad2b/" + dst_path);

    imwrite(cropImage(I1, crop), "../zad2b/" + dst_path + "/I1.png");
    imwrite(cropImage(I2, crop), "../zad2b/" + dst_path + "/I2.png");
    imwrite(cropImage(I3, crop), "../zad2b/" + dst_path + "/I3.png");
    imwrite(cropImage(I4, crop), "../zad2b/" + dst_path + "/I4.png");
    imwrite(cropImage(I5, crop), "../zad2b/" + dst_path + "/I5.png");
    imwrite(cropImage(I6, crop), "../zad2b/" + dst_path + "/I6.png");
    imwrite(cropImage(I7, crop), "../zad2b/" + dst_path + "/I7.png");
    imwrite(cropImage(I8, crop), "../zad2b/" + dst_path + "/I8.png");




    Latex = [
""
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I1.png}}  \hfill% "
"   \subfloat[O1 + 2\% \\ psnr = " + psnr(I2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I2.png}}  \hfill% "
"   \subfloat[LUM 3x3 k=0 \\ psnr = " + psnr(I3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I3.png}}  \hfill% "
"   \subfloat[LUM 3x3 k=1 \\ psnr = " + psnr(I4,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I4.png}}  \\"
"   \subfloat[LUM 3x3 k=2 \\ psnr = " + psnr(I5,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I5.png}}  \hfill%"
"   \subfloat[LUM 3x3 k=3 \\ psnr = " + psnr(I6,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I6.png}}  \hfill%"
"   \subfloat[LUM 3x3 k=4 \\ psnr = " + psnr(I7,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I7.png}}  \hfill%"
"   \subfloat[LUM 5x5 k=0 \\ psnr = " + psnr(I8,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2b/img1/I8.png}}"
"\caption{Porownanie}  "
" "
"\end{figure} "
"\let\ww\undefined "
""
];

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad2b/" + dst_path + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);




end







