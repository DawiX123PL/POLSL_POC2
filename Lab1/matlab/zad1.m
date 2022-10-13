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

    convert_image(images_path, image_name, 0)
    convert_image(images_path, image_name, 0.01)
    convert_image(images_path, image_name, 0.02)
    convert_image(images_path, image_name, 0.10)

end



function convert_image(images_path, image_names, d)

    src = image_names(1);
    dst = image_names(2);

    I = imread(images_path + src);

    I_rgb = imnoise(I,"salt & pepper", d);
    I_gray = imnoise( rgb2gray(I),"salt & pepper", d);

    rbg_path = "../zad1/rgb/" + string(d) + "/"
    gray_path = "../zad1/gray/" + string(d) + "/"

    mkdir(rbg_path);
    mkdir(gray_path);

    name = rbg_path + dst;
    imwrite(I_rgb,name);

    name = gray_path + dst;
    imwrite(I_gray,name);


        Latex = [
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 1\%]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.01/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 2\%]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.02/" + dst + "}}  \hfill%"
"   \subfloat[O1 + szum 10\%]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/gray/0.1/" + dst + "}}   \\ "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 1\%]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0.01/" + dst + "}}  \hfill% "
"   \subfloat[O1 + szum 2\%]{"
"      \includegraphics[width=\ww\linewidth]{../zad1/rgb/0.02/" + dst + "}}  \hfill%"
"   \subfloat[O1 + szum 10\%]{"
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
















