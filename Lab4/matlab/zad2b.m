clear all
close all
clc


mkdir("../Zad2b")

%%

[k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_rot()

plot_and_save("../Zad2b/k1_rot.png", [1:1:90] ,k1_circ, k1_sqr, k1_xd);
plot_and_save("../Zad2b/k2_rot.png", [1:1:90] ,k2_circ, k2_sqr, k2_xd);
plot_and_save("../Zad2b/k3_rot.png", [1:1:90] ,k3_circ, k3_sqr, k3_xd);

%%

[k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_scale()

plot_and_save("../Zad2b/k1_scale.png", [.1:.1:2] ,k1_circ, k1_sqr, k1_xd);
plot_and_save("../Zad2b/k2_scale.png", [.1:.1:2] ,k2_circ, k2_sqr, k2_xd);
plot_and_save("../Zad2b/k3_scale.png", [.1:.1:2] ,k3_circ, k3_sqr, k3_xd);

%%

[k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_trans()

plot_and_save("../Zad2b/k1_trans.png", [1:5:100] ,k1_circ, k1_sqr, k1_xd);
plot_and_save("../Zad2b/k2_trans.png", [1:5:100] ,k2_circ, k2_sqr, k2_xd);
plot_and_save("../Zad2b/k3_trans.png", [1:5:100] ,k3_circ, k3_sqr, k3_xd);


%%

dest_folder = "../Zad2b"

Latex = [
    "\newcommand{\ww}{0.32} "
    "\begin{figure}[H] "
    "   \captionsetup[subfloat]{justification=raggedright,singlelinecheck=false, position=bottom,labelformat=empty} % "
    ""
    "    \subfloat[K1 - Rotacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k1_rot.png}}  \hfill% "
    "    \subfloat[K1 - Skala]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k1_trans.png}}  \hfill% "
    "    \subfloat[K1 - Translacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k1_scale.png}}  \hfill% "
    ""
    "    \subfloat[K2 - Rotacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k2_rot.png}}  \hfill% "
    "    \subfloat[K2 - Skala]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k2_trans.png}}  \hfill% "
    "    \subfloat[K2 - Translacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k2_scale.png}}  \hfill% "
    ""
    "    \subfloat[K3 - Rotacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k3_rot.png}}  \hfill%"
    "    \subfloat[K3 - Skala]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k3_trans.png}}  \hfill%"
    "    \subfloat[K3 - Translacja]{"
    "        \includegraphics[width=\ww\linewidth]{" + dest_folder + "/k3_scale.png}}  \hfill%"
    ""
    ""
    ""   
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
    



%%

function plot_and_save(dest,x,circ, sqr, xd)
    % K1 - rot
    hold off;
    plot(x, circ); hold on;
    plot(x, sqr);
    plot(x, xd);
    grid on;
    legend("Circ", "Sqr", "XD");
    saveas(gcf, dest);

end



function [k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_rot()

    translation = [0 0];
    scale = [1 1];
    all_rotations = [1:1:90];

    i = 1;
    for rotation = all_rotations;

        disp(rotation);

        I1 = g_circles(translation, rotation, scale );
        [k1_circ(i), k2_circ(i), k3_circ(i)] = get_coeficients(I1);

        I1 = g_squares(translation, rotation, scale );
        [k1_sqr(i), k2_sqr(i), k3_sqr(i)] = get_coeficients(I1);

        I1 = g_xd(translation, rotation, scale );
        [k1_xd(i), k2_xd(i), k3_xd(i)] = get_coeficients(I1);

        i = i + 1;
    end

end


function [k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_scale()

    translation = [0 0];
    all_scale = [.1:.1:2];
    rotation = 0;

    i = 1;
    for s1 = all_scale;

        scale = [s1, s1]

        disp(s1);

        I1 = g_circles(translation, rotation, scale );
        [k1_circ(i), k2_circ(i), k3_circ(i)] = get_coeficients(I1);

        I1 = g_squares(translation, rotation, scale );
        [k1_sqr(i), k2_sqr(i), k3_sqr(i)] = get_coeficients(I1);

        I1 = g_xd(translation, rotation, scale );
        [k1_xd(i), k2_xd(i), k3_xd(i)] = get_coeficients(I1);

        i = i + 1;
    end

end

function [k1_circ, k2_circ, k3_circ, k1_sqr, k2_sqr, k3_sqr, k1_xd, k2_xd, k3_xd] = get_coeficients_trans()

    all_translation = [1:5:100];
    scale = [1 1];
    rotation = 0;

    i = 1;
    for t1 = all_translation;

        translation = [t1 0];

        disp(t1);

        I1 = g_circles(translation, rotation, scale );
        [k1_circ(i), k2_circ(i), k3_circ(i)] = get_coeficients(I1);

        I1 = g_squares(translation, rotation, scale );
        [k1_sqr(i), k2_sqr(i), k3_sqr(i)] = get_coeficients(I1);

        I1 = g_xd(translation, rotation, scale );
        [k1_xd(i), k2_xd(i), k3_xd(i)] = get_coeficients(I1);

        i = i + 1;
    end

end



function [k1, k2, k3] = get_coeficients(I1)

    k1 = wspolczynnik_kompaktowosci(I1);
    k2 = wspolczynnik_malinowskiej(I1);
    k3 = wspolczynnik_Mz(I1);

end

