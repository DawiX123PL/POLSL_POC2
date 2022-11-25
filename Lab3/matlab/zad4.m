clear all
close all
clc


image_path = "../images/20191121_072040.jpg"

dest_folder = "../zad4"



ProcessImages(image_path, dest_folder)



function ProcessImages(image_path, dest_folder)

    
    I = imread(image_path);
    I = rgb2gray(I);
    I = double(I) / 255;
    
    I1 = imnoise(I, "salt & pepper", .02);
    I2 = imfilter(I, fspecial("gaussian", 3, 1));
    
    [I_b, t] = ImageBinarize(I, "otsu");
    [I1_b, t1] = ImageBinarize(I1, "otsu");
    [I2_b, t2] = ImageBinarize(I2, "otsu");
    
    [~, n] = bwlabel(I_b);
    [~, n1] = bwlabel(I1_b);
    [~, n2] = bwlabel(I2_b);
    
    I_col = label2rgb(bwlabel(I_b));
    I1_col = label2rgb(bwlabel(I1_b));
    I2_col = label2rgb(bwlabel(I2_b));
        
    
    mkdir(dest_folder);
    
    imwrite(cropToSquare(I),  dest_folder + "/I.png");
    imwrite(cropToSquare(I1), dest_folder + "/I1.png");
    imwrite(cropToSquare(I2), dest_folder + "/I2.png");
    
    HistSave(I,  dest_folder + "/H.png")
    HistSave(I1, dest_folder + "/H1.png")
    HistSave(I2, dest_folder + "/H2.png")
    
    imwrite(cropToSquare(I_b),  dest_folder + "/I_b.png");
    imwrite(cropToSquare(I1_b), dest_folder + "/I1_b.png");
    imwrite(cropToSquare(I2_b), dest_folder + "/I2_b.png");

    imwrite(cropToSquare(I_col),  dest_folder + "/I_col.png");
    imwrite(cropToSquare(I1_col), dest_folder + "/I1_col.png");
    imwrite(cropToSquare(I2_col), dest_folder + "/I2_col.png");
    
    
        Latex = [
    "\newcommand{\ww}{0.24} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    "   "
    "    \subfloat[ Oryginalny ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/H.png}}  \hfill% "
    "    \subfloat[ Wartość progu $t$ = " + string(t) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_b.png}}  \hfill%"
    "    \subfloat[ Liczba obszarów " + string(n) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_col.png}}  \hfill%"
    "   "
    "    \subfloat[ Zakłócony ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/H1.png}}  \hfill% "
    "    \subfloat[ Wartość progu $t$ = " + string(t1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_b.png}}  \hfill%"
    "    \subfloat[ Liczba obszarów " + string(n1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_col.png}}  \hfill%"
    "   "
    "    \subfloat[ Filtrowany ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2.png}}  \hfill% "
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/H2.png}}  \hfill% "
    "    \subfloat[ Wartość progu $t_2$ = " + string(t2) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_b.png}}  \hfill%"
    "    \subfloat[ Liczba obszarów " + string(n2) + "]{"
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













