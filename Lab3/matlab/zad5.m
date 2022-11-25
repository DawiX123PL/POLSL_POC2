clear all
close all
clc


image_path = "../images/20191121_072040.jpg"

dest_folder = "../zad5"



ProcessImages(image_path, dest_folder)



function ProcessImages(image_path, dest_folder)

    
    I = imread(image_path);
    I = rgb2gray(I);
    I = double(I) / 255;
   
    [I_b, t] = ImageBinarize(I, "otsu");

    I_b_u8 = uint8(I_b*255);

    Ib1 = imerode(I_b_u8, offsetstrel('ball',5,5)) > 127;
    Ib2 = imdilate(I_b_u8, offsetstrel('ball',5,5)) > 127;

    [~, n] = bwlabel(I_b_u8);
    [~, n1] = bwlabel(Ib1);
    [~, n2] = bwlabel(Ib2);

    I_col = label2rgb(bwlabel(I_b_u8));
    I1_col = label2rgb(bwlabel(Ib1));
    I2_col = label2rgb(bwlabel(Ib2));
    
    
    mkdir(dest_folder);

    imwrite(cropToSquare(I), dest_folder + "/I.png");

    imwrite(cropToSquare(I_b), dest_folder + "/I_b.png");
    imwrite(cropToSquare(Ib1), dest_folder + "/Ib1.png");
    imwrite(cropToSquare(Ib2), dest_folder + "/Ib2.png");

    imwrite(cropToSquare(I_col), dest_folder + "/I_col.png");
    imwrite(cropToSquare(I1_col), dest_folder + "/I1_col.png");
    imwrite(cropToSquare(I2_col), dest_folder + "/I2_col.png");


    
        Latex = [
    "\newcommand{\ww}{0.32} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    "   "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{../other/Empty.png}}  \hfill%"
    "   "
    "    \subfloat[Wartość progu t = " + string(n) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_b.png}}  \hfill% "
    "    \subfloat[TODO: WSTAW OPIS]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib1.png}}  \hfill% "
    "    \subfloat[TODO: WSTAW OPIS]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/Ib2.png}}  \hfill%"
    "   "
    "    \subfloat[Liczba obszarów = " + string(n) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n2) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_col.png}}  \hfill%"
    ""
    " "
    "\caption{Porownanie}"
    ""
    "\end{figure} "
    "\let\ww\undefined "
        ]
    
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













