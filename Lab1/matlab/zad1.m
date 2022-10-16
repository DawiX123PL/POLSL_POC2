clear all
close all
clc


images = [
        "baboon_512x512.bmp" ,      "img_1.png"
        "bangko_13_512x512.png",    "img_2.png"
        "frymire_512x512.png",      "img_3.png"
        "kodim23_512x512.png",      "img_4.png"
        "lena_512x512.bmp",         "img_5.png"
        "peppers3_512x512.bmp" ,    "img_6.png"
        "castle.png" ,              "img_7.png"
        ];

images_path = "../images/"

mkdir("../zad1");
mkdir("../zad1/gray");
mkdir("../zad1/rgb");


for image_name = images'

    [I, I_rgb_0, I_gray_0]       = convert_image(images_path, image_name, 0);
    [I, I_rgb_0_01, I_gray_0_01] = convert_image(images_path, image_name, 0.01);
    [I, I_rgb_0_02, I_gray_0_02] = convert_image(images_path, image_name, 0.02);
    [I, I_rgb_0_10, I_gray_0_10] = convert_image(images_path, image_name, 0.10);

    %real_noise_rgb = sum(I ~= I_rgb, 'all')  / numel(I_rgb);
    %real_noise_gray = sum(rgb2gray(I) ~= I_gray, 'all')  / numel(I_gray);
    real_noise = @(I1,I2) sum(I1 ~= I2, 'all')  / numel(I1);

    dst = image_name(2);
        Latex = [
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 1\% \\ psnr = " + string(psnr(I_gray_0_01, rgb2gray(I))) + " \\ Sz.Rz. = " + string(real_noise(I_gray_0_01, rgb2gray(I))*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.01/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 2\% \\ psnr = " + string(psnr(I_gray_0_02, rgb2gray(I))) + " \\ Sz.Rz. = " + string(real_noise(I_gray_0_02, rgb2gray(I))*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.02/" + dst + "}}  \hfill%"
"   \subfloat[O1 + szum 10\% \\ psnr = " + string(psnr(I_gray_0_10, rgb2gray(I))) + " \\ Sz.Rz. = " + string(real_noise(I_gray_0_10, rgb2gray(I))*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.1/" + dst + "}}   \\ "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 1\% \\ psnr = " + string(psnr(I_rgb_0_01, I)) + " \\ Sz.Rz. = " + string(real_noise(I_rgb_0_01, I)*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0.01/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 2\% \\ psnr = " + string(psnr(I_rgb_0_02, I)) + " \\ Sz.Rz. = " + string(real_noise(I_rgb_0_02, I)*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0.02/" + dst + "}}  \hfill%"
"   \subfloat[O1 + szum 10\% \\ psnr = " + string(psnr(I_rgb_0_10, I)) + " \\ Sz.Rz. = " + string(real_noise(I_rgb_0_10, I)*100) + "\% ]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0.1/" + dst + "}}"
"\caption{Porownanie}  "
" "
"\end{figure} "
"\let\ww\undefined "
]

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad1/" + dst + "_result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);


end



function [I, I_rgb, I_gray] = convert_image(images_path, image_names, d)

    src = image_names(1);
    dst = image_names(2);

    I = imread(images_path + src);

    I_rgb = imnoise(I,"salt & pepper", d);
    I_gray = imnoise( rgb2gray(I),"salt & pepper", d);

    rbg_path = "../zad1/rgb/" + string(d) + "/";
    gray_path = "../zad1/gray/" + string(d) + "/";

    mkdir(rbg_path);
    mkdir(gray_path);

    name = rbg_path + dst;
    imwrite(I_rgb,name);

    name = gray_path + dst;
    imwrite(I_gray,name);

end
















