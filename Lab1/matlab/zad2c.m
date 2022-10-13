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

    disp("Row 1")
    I1_1 = imread("../zad1/gray/0.01/" + name);
    I1_1 = double(I1_1) / 255;
    I1_2 = filter_median(I1_1, 1); % 3x3
    I1_3 = filter_LUM(I1_1, 1, 2); % 3x3, K=2
    I1_4 = filter_LUM(I1_1, 1, 3); % 3x3, K=3

    disp("Row 2")
    I2_1 = imread("../zad1/gray/0.02/" + name);
    I2_1 = double(I2_1) / 255;
    I2_2 = filter_median(I2_1, 1); % 3x3
    I2_3 = filter_LUM(I2_1, 1, 2); % 3x3, K=2
    I2_4 = filter_LUM(I2_1, 1, 3); % 3x3, K=3

    disp("Row 3")
    I3_1 = imread("../zad1/gray/0.1/" + name);
    I3_1 = double(I3_1) / 255;
    I3_2 = filter_median(I3_1, 1); % 3x3
    I3_3 = filter_LUM(I3_1, 1, 2); % 3x3, K=2
    I3_4 = filter_LUM(I3_1, 1, 3); % 3x3, K=3
    

    mkdir("../zad2c/" + dst_path);


    imwrite(cropImage(I1, crop), "../zad2c/" + dst_path + "/I1.png");

    imwrite(cropImage(I1_1, crop), "../zad2c/" + dst_path + "/I1_1.png");
    imwrite(cropImage(I1_2, crop), "../zad2c/" + dst_path + "/I1_2.png");
    imwrite(cropImage(I1_3, crop), "../zad2c/" + dst_path + "/I1_3.png");
    imwrite(cropImage(I1_4, crop), "../zad2c/" + dst_path + "/I1_4.png");

    imwrite(cropImage(I2_1, crop), "../zad2c/" + dst_path + "/I2_1.png");
    imwrite(cropImage(I2_2, crop), "../zad2c/" + dst_path + "/I2_2.png");
    imwrite(cropImage(I2_3, crop), "../zad2c/" + dst_path + "/I2_3.png");
    imwrite(cropImage(I2_4, crop), "../zad2c/" + dst_path + "/I2_4.png");

    imwrite(cropImage(I3_1, crop), "../zad2c/" + dst_path + "/I3_1.png");
    imwrite(cropImage(I3_2, crop), "../zad2c/" + dst_path + "/I3_2.png");
    imwrite(cropImage(I3_3, crop), "../zad2c/" + dst_path + "/I3_3.png");
    imwrite(cropImage(I3_4, crop), "../zad2c/" + dst_path + "/I3_4.png");



    Latex = [
""
""
"\newcommand{\ww}{0.19} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I1.png}}  \hfill% "
"   \subfloat[O1 + 1\% \\ psnr = " + psnr(I1_1, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I1_1.png}}  \hfill% "
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I1_2, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I1_2.png}}  \hfill%"
"   \subfloat[LUM 3x3 k=x \\ psnr = " + psnr(I1_3, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I1_3.png}}  \hfill% "
"   \subfloat[LUM 3x3 k=x \\ psnr = " + psnr(I1_4, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I1_4.png}} \\"
""
"   \subfloat[]{"
"      \includegraphics[width=\ww\linewidth]{other/empty.png}}  \hfill% "
"   \subfloat[O1 + 2\% \\ psnr = " + psnr(I2_1, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I2_1.png}}  \hfill% "
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I2_2, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I2_2.png}}  \hfill%"
"   \subfloat[LUM 3x3 k=x \\ psnr = " + psnr(I2_3, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I2_3.png}}  \hfill% "
"   \subfloat[LUM 3x3 k=x \\ psnr = " + psnr(I2_4, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I2_4.png}} \\"
""
"   \subfloat[]{"
"      \includegraphics[width=\ww\linewidth]{other/empty.png}}  \hfill% "
"   \subfloat[O1 + 10\% \\ psnr = " + psnr(I3_1, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I3_1.png}}  \hfill% "
"   \subfloat[mediana 3x3 \\ psnr = " + psnr(I3_2, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I3_2.png}}  \hfill%"
"   \subfloat[LUM 3x3 k=0 \\ psnr = " + psnr(I3_3, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I3_3.png}}  \hfill% "
"   \subfloat[LUM 3x3 k=1 \\ psnr = " + psnr(I3_4, I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad2c/img1/I3_4.png}}"
"\caption{Porownanie}  "
" "
"\end{figure} "
"\let\ww\undefined "
""
""
];

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad2c/" + dst_path + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);




end







