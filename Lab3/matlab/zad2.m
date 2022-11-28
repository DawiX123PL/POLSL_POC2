clear all
close all


disp("Zad 2")

disp("   Img 1")
ProcessImages("../images/20191121_072040.jpg", "../zad2/Img1");

disp("   Img 2")
ProcessImages("../images/20191121_072227.jpg", "../zad2/Img2");




function ProcessImages(image_path, dest_folder)

    
    I = imread(image_path);
    I = rgb2gray(I);
    I = double(I) / 255;
    I = imresize(I, [512 512]);
    
    [I1, t1] = ImageBinarize(I, "hist");
    [I2, t2] = ImageBinarize(I, "otsu");

    I1 = -I1 + 1;
    I2 = -I2 + 1;
    
    [~, n1] = bwlabel(I1);
    [~, n2] = bwlabel(I2);
    
    I1_col = label2rgb(bwlabel(I1));
    I2_col = label2rgb(bwlabel(I2));
    
    % figure; imshow(I);
    % figure; imshow(I1); title("wartosc progu t1 = " + string(t1))
    % figure; imshow(I2); title("wartosc progu t2 = " + string(t2))
    % 
    % figure; imhist(I);
    % figure; imshow(I1_col); title("Liczba obszarów = " + string(n1))
    % figure; imshow(I2_col); title("Liczba obszarów = " + string(n2))
    
    
    mkdir(dest_folder);
    
    imwrite(cropToSquare(I), dest_folder + "/I.png");
    imwrite(cropToSquare(I1), dest_folder + "/I1.png");
    imwrite(cropToSquare(I2), dest_folder + "/I2.png");
    
    HistSave(I, dest_folder + "/I_hist.png")    
    imwrite(cropToSquare(I1_col), dest_folder + "/I1_col.png");
    imwrite(cropToSquare(I2_col), dest_folder + "/I2_col.png");
    
    
        Latex = [
    "\newcommand{\ww}{0.32} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    "   "
    "    \subfloat[ $O_k$ ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I.png}}  \hfill% "
    "    \subfloat[ Wartość progu $t$ = " + string(t1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
    "    \subfloat[ Wartość progu $t_o$ = " + string(t2) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2.png}}  \hfill%"
    ""
    "    \subfloat[]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I_hist.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n1) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1_col.png}}  \hfill% "
    "    \subfloat[Liczba obszarów = " + string(n2) + "]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2_col.png}}  \hfill%"
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













