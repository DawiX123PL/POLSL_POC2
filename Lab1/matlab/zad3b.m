clear all
close all
clc



images = [
    "img1", "img_1.png"
]

convert_image(images(1,:));


function convert_image(names)

    dst_path = names(1);
    name = names(2)

    I1 = imread("../zad1/rgb/0/" + name);
    I1 = double(I1) / 255;

    I1_1 = imread("../zad1/rgb/0.01/" + name);
    I1_1 = double(I1_1) / 255;

    I1_2 = imread("../zad1/rgb/0.02/" + name);
    I1_2 = double(I1_2) / 255;

    I1_3 = imread("../zad1/rgb/0.1/" + name);
    I1_3 = double(I1_3) / 255;
    
    I2_1 = filter_VMF(I1_1,1, "L1"); % 
    I2_2 = filter_VMF(I1_2,1, "L1"); % 
    I2_3 = filter_VMF(I1_3,1, "L1"); % 

    I3_1 = filter_VMF(I1_1,1, "L2"); % 
    I3_2 = filter_VMF(I1_2,1, "L2"); % 
    I3_3 = filter_VMF(I1_3,1, "L2"); % 


    mkdir("../zad3b/" + dst_path);

    imwrite(I1, "../zad3b/" + dst_path + "/I1.png");

    imwrite(I1_1, "../zad3b/" + dst_path + "/I1_1.png");
    imwrite(I1_2, "../zad3b/" + dst_path + "/I1_2.png");
    imwrite(I1_3, "../zad3b/" + dst_path + "/I1_3.png");
    
    imwrite(I2_1, "../zad3b/" + dst_path + "/I2_1.png");
    imwrite(I2_2, "../zad3b/" + dst_path + "/I2_2.png");
    imwrite(I2_3, "../zad3b/" + dst_path + "/I2_3.png");
    
    imwrite(I3_1, "../zad3b/" + dst_path + "/I3_1.png");
    imwrite(I3_2, "../zad3b/" + dst_path + "/I3_2.png");
    imwrite(I3_3, "../zad3b/" + dst_path + "/I3_3.png");


    
        Latex = [
""
"\newcommand{\ww}{0.24} "
"\begin{figure}[H] "
"   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
"   \subfloat[O1]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I1.png}}  \hfill% "
"   \subfloat[O1 + szum 1\% \\ psnr = " + psnr(I1_1,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I1_1.png}}  \hfill% "
"   \subfloat[O1 + szum 2\% \\ psnr = " + psnr(I1_2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I1_2.png}}  \hfill%"
"   \subfloat[O1 + szum 10\% \\ psnr = " + psnr(I1_3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I1_3.png}}  \hfill% "
"   "
"   \subfloat[]{"
"      \includegraphics[width=\ww\linewidth]{other/empty.png}}  \hfill% "
"   \subfloat[VMF 3x3 L1 \\ psnr = " + psnr(I2_1,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I2_1.png}}  \hfill% "
"   \subfloat[VMF 3x3 L1 \\ psnr = " + psnr(I2_2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I2_2.png}}  \hfill%"
"   \subfloat[VMF 3x3 L1 \\ psnr = " + psnr(I2_3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I2_3.png}}  \hfill% "
""
"   \subfloat[]{"
"      \includegraphics[width=\ww\linewidth]{other/empty.png}}  \hfill% "
"   \subfloat[VMF 3x3 L2 \\ psnr = " + psnr(I3_1,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I3_1.png}}  \hfill% "
"   \subfloat[VMF 3x3 L2 \\ psnr = " + psnr(I3_2,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I3_2.png}}  \hfill%"
"   \subfloat[VMF 3x3 L2 \\ psnr = " + psnr(I3_3,I1) + "]{"
"      \includegraphics[width=\ww\linewidth]{../zad3b/img1/I3_3.png}}  \hfill% "
"   "
""
"\end{figure} "
"\let\ww\undefined "
""
""
];

  
    Latex = join(Latex,[''],2);
    Latex = join(Latex,[newline],1);

    fid = fopen("../zad3b/" + dst_path + "/result.tex",'wt');
    fprintf(fid,"%s", Latex);
    fclose(fid);




end







