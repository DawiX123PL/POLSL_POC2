
clear all
close all
clc


figure

tiledlayout(3,4);


mkdir("../Zad2a/")
dest_folder = "../Zad2a";

K1 = zeros(12,1);
K2 = zeros(12,1);
K3 = zeros(12,1);

[K1( 1), K2( 1), K3( 1)] = show_img("../Zad2a/I1.png", @g_circles, [0 0],     0, [1 1]);    
[K1( 2), K2( 2), K3( 2)] = show_img("../Zad2a/I2.png", @g_circles, [100 100], 0, [1 1]);    
[K1( 3), K2( 3), K3( 3)] = show_img("../Zad2a/I3.png", @g_circles, [50 -50],  0, [.5 .5]);  
[K1( 4), K2( 4), K3( 4)] = show_img("../Zad2a/I4.png", @g_circles, [100 0],   0, [1 1]);    
[K1( 5), K2( 5), K3( 5)] = show_img("../Zad2a/I5.png", @g_squares, [0 0],     0, [1 1]);    
[K1( 6), K2( 6), K3( 6)] = show_img("../Zad2a/I6.png", @g_squares, [100 100], 0, [1 1]);    
[K1( 7), K2( 7), K3( 7)] = show_img("../Zad2a/I7.png", @g_squares, [50 -50],  0, [.5 .5]);  
[K1( 8), K2( 8), K3( 8)] = show_img("../Zad2a/I8.png", @g_squares, [100 0],   0, [1 1]);    
[K1( 9), K2( 9), K3( 9)] = show_img("../Zad2a/I9.png", @g_xd,      [0 0],     0, [1 1]);    
[K1(10), K2(10), K3(10)] = show_img("../Zad2a/I10.png", @g_xd,      [100 100], 0, [1 1]);   
[K1(11), K2(11), K3(11)] = show_img("../Zad2a/I11.png", @g_xd,      [50 -50],  0, [.5 .5]); 
[K1(12), K2(12), K3(12)] = show_img("../Zad2a/I12.png", @g_xd,      [100 0],   0, [1 1]);   


Latex = [
    "\newcommand{\ww}{0.24} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    ""
    "    \subfloat[k1 = " + string(K1(1)) + " \\k2 = " + string(K2(1)) + "\\k3 = " + string(K3(1)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I1.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(2)) + " \\k2 = " + string(K2(2)) + "\\k3 = " + string(K3(2)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I2.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(3)) + " \\k2 = " + string(K2(3)) + "\\k3 = " + string(K3(3)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I3.png}}  \hfill%"
    "    \subfloat[k1 = " + string(K1(4)) + " \\k2 = " + string(K2(4)) + "\\k3 = " + string(K3(4)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I4.png}}  \hfill%"
    ""
    ""
    "    \subfloat[k1 = " + string(K1(5)) + " \\k2 = " + string(K2(5)) + "\\k3 = " + string(K3(5)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I5.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(6)) + " \\k2 = " + string(K2(6)) + "\\k3 = " + string(K3(6)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I6.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(7)) + " \\k2 = " + string(K2(7)) + "\\k3 = " + string(K3(7)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I7.png}}  \hfill%"
    "    \subfloat[k1 = " + string(K1(8)) + " \\k2 = " + string(K2(8)) + "\\k3 = " + string(K3(8)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I8.png}}  \hfill%"
    ""
    ""
    "    \subfloat[k1 = " + string(K1(9)) + " \\k2 = " + string(K2(9)) + "\\k3 = " + string(K3(9)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I9.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(10)) + " \\k2 = " + string(K2(10)) + "\\k3 = " + string(K3(10)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I10.png}}  \hfill% "
    "    \subfloat[k1 = " + string(K1(11)) + " \\k2 = " + string(K2(11)) + "\\k3 = " + string(K3(11)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I11.png}}  \hfill%"
    "    \subfloat[k1 = " + string(K1(12)) + " \\k2 = " + string(K2(12)) + "\\k3 = " + string(K3(12)) + " ]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/I12.png}}  \hfill%"
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
    





function [k1, k2, k3] = show_img(dest, func, trans, rot, scale)
    nexttile
    I1 = func(trans,rot,scale);
    imshow(I1);
    imwrite(I1, dest);
    k1 = wspolczynnik_kompaktowosci(I1);
    k2 = wspolczynnik_malinowskiej(I1);
    k3 = wspolczynnik_Mz(I1);
    title("K1 = " + string(k1) + " K2 = " + string(k2) + " K3 = " + string(k3));

end
















