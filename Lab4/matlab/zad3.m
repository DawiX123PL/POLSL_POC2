
clear all
close all
clc



circ_source = "../images_gen/circ" + string(1:100) + ".png";
sqr_source = "../images_gen/sqr" + string(1:100) + ".png";
xD_source = "../images_gen/xD" + string(1:100) + ".png";




% plot3_coeficients(circ_source); hold on;
% plot3_coeficients(sqr_source);
% plot3_coeficients(xD_source);

mkdir("../Zad3")
plot_coeficients(circ_source, sqr_source, xD_source)



legend("Circ", "Sqr", "XD");
grid on;


function plot_coeficients(src_vec1, src_vec2, src_vec3)
    [k1_v1,k2_v1,k3_v1] = get_coeficient_vectors(src_vec1);
    [k1_v2,k2_v2,k3_v2] = get_coeficient_vectors(src_vec2);
    [k1_v3,k2_v3,k3_v3] = get_coeficient_vectors(src_vec3);

    hold off;
    plot(k1_v1, k2_v1, '*'); hold on;
    plot(k1_v2, k2_v2, '*'); 
    plot(k1_v3, k2_v3, '*'); 
    grid on;
    legend("Circ", "Sqr", "XD");
    xlabel("K1");
    ylabel("K2");
    saveas(gcf, "../Zad3/k1k2.png");

    
    hold off;
    plot(k1_v1, k3_v1, '*'); hold on;
    plot(k1_v2, k3_v2, '*'); 
    plot(k1_v3, k3_v3, '*'); 
    grid on;
    legend("Circ", "Sqr", "XD");
    xlabel("K1");
    ylabel("K3");
    saveas(gcf, "../Zad3/k1k3.png");


    hold off;
    plot(k2_v1, k3_v1, '*'); hold on;
    plot(k2_v2, k3_v2, '*'); 
    plot(k2_v3, k3_v3, '*'); 
    grid on;
    legend("Circ", "Sqr", "XD");
    xlabel("K2");
    ylabel("K3");
    saveas(gcf, "../Zad3/k2k3.png");

end

function plot3_coeficients(src_vec)
    [k1,k2,k3] = get_coeficient_vectors(src_vec);
    plot3(k1,k2,k3, "*");
    xlabel("K1");
    ylabel("K2");
    zlabel("K3");
end



function [k1, k2, k3] = get_coeficient_vectors(src_vec)

    i = 1;

    for source = src_vec
        
        disp(source);
        I1 = imread(source);
        I1 = double(I1) ./ 255;

        if(size(I1,3) ~= 1)
            I1 = rgb2gray(I1);
        end

        [k1(i), k2(i), k3(i)] = get_coeficients(I1);
    
        i = i + 1;
    end

end




function [k1, k2, k3] = get_coeficients(I1)

    k1 = wspolczynnik_kompaktowosci(I1);
    k2 = wspolczynnik_malinowskiej(I1);
    k3 = wspolczynnik_Mz(I1);

end











