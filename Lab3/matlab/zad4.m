clear all
close all


disp("Zad 4")

disp("   Img 1")
ProcessImages("../images/20191121_072040.jpg", "../zad4/Img1");

disp("   Img 2")
ProcessImages("../images/20191121_072227.jpg", "../zad4/Img2");



function ProcessImages(image_path, dest_folder)

    
    I = imread(image_path);
    I = rgb2gray(I);
    I = double(I) / 255;
    I = imresize(I, [512, 512]);
   
    [I_b, t] = ImageBinarize(I, "otsu");

    I_b = -I_b + 1;

    I_b_u8 = uint8(I_b*255);

    Ib1 = imerode(I_b_u8, offsetstrel('ball',5,5)) > 127;
    Ib2 = imerode(I_b_u8, offsetstrel('ball',10,10)) > 127;
    Ib3 = imdilate(I_b_u8, offsetstrel('ball',5,5)) > 127;
    Ib4 = imdilate(I_b_u8, offsetstrel('ball',10,10)) > 127;

    [~, n] = bwlabel(I_b_u8);
    [~, n1] = bwlabel(Ib1);
    [~, n2] = bwlabel(Ib2);
    [~, n3] = bwlabel(Ib3);
    [~, n4] = bwlabel(Ib4);

    I_col = label2rgb(bwlabel(I_b_u8));
    I1_col = label2rgb(bwlabel(Ib1));
    I2_col = label2rgb(bwlabel(Ib2));
    I3_col = label2rgb(bwlabel(Ib3));
    I4_col = label2rgb(bwlabel(Ib4));
    
    
    mkdir(dest_folder);

    imwrite(cropToSquare(I), dest_folder + "/I.png");

    imwrite(cropToSquare(I_b), dest_folder + "/I_b.png");
    imwrite(cropToSquare(Ib1), dest_folder + "/Ib1.png");
    imwrite(cropToSquare(Ib2), dest_folder + "/Ib2.png");
    imwrite(cropToSquare(Ib3), dest_folder + "/Ib3.png");
    imwrite(cropToSquare(Ib4), dest_folder + "/Ib4.png");

    imwrite(cropToSquare(I_col), dest_folder + "/I_col.png");
    imwrite(cropToSquare(I1_col), dest_folder + "/I1_col.png");
    imwrite(cropToSquare(I2_col), dest_folder + "/I2_col.png");
    imwrite(cropToSquare(I3_col), dest_folder + "/I3_col.png");
    imwrite(cropToSquare(I4_col), dest_folder + "/I4_col.png");


    
        Latex = [
    "\newcommand{\ww}{0.19} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    "   "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill%"
        "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill%"
    "   "
    "    \subfloat[Wartość progu t = " + string(n) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_b.png}}  \hfill% "
    "    \subfloat[   s = offsetstrel('ball',5,5); \\ imerode(I, s);    ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib1.png}}  \hfill% "
    "    \subfloat[   s = offsetstrel('ball',10,10); \\ imerode(I, s);    ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib2.png}}  \hfill%"
    "    \subfloat[   s = offsetstrel('ball',5,5); \\ imdilate(I, s);    ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib3.png}}  \hfill% "
    "    \subfloat[   s = offsetstrel('ball',10,10); \\ imdilate(I, s);    ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib4.png}}  \hfill%"
    "   "
    "    \subfloat[Liczba obszarów = " + string(n) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n2) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_col.png}}  \hfill%"
    "    \subfloat[Liczba obszarów = " + string(n3) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I3_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n4) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I4_col.png}}  \hfill%"
    ""
    " "
    "\caption{Porownanie}"
    ""
    "\end{figure} "
    "\let\ww\undefined "
        ];
    
        Latex = join(Latex,[''],2);
        Latex = join(Latex,[newline],1);
    
        fid = fopen(dest_folder + "/result.tex",'wt');
        fprintf(fid,"%s", Latex);
        fclose(fid);
    




end



function HistSave(I, dest)
    f = figure;
    f.Position = [0,0,512,512];
    imhist(I);
    saveas(gcf, dest)
    close(gcf);
end













