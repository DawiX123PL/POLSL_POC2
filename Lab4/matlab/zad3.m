
clear all
close all
clc



circ_source = "../images_gen/circ" + string(1:20) + ".png";
sqr_source = "../images_gen/sqr" + string(1:20) + ".png";
xD_source = "../images_gen/xD" + string(1:20) + ".png";




plot_coeficients(circ_source); hold on;
plot_coeficients(sqr_source);
plot_coeficients(xD_source);

legend("Circ", "Sqr", "XD");
grid on;



function plot_coeficients(src_vec)
    [K,C1,C2,BB,H] = get_coeficient_vectors(src_vec);
    plot3(K,C1,C2, "*");
    xlabel("K");
    ylabel("C1");
    zlabel("C2");
end



function [K,C1,C2,BB,H] = get_coeficient_vectors(src_vec)

    K  = [];
    C1 = [];
    C2 = [];
    BB = [];
    H  = [];

    i = 1;

    for source = src_vec
        
        I1 = imread(source);
        I1 = double(I1) ./ 255;

        if(size(I1,3) ~= 1)
            I1 = rgb2gray(I1);
        end

        [tmp_K, tmp_C1, tmp_C2, tmp_BB, tmp_H] = get_coeficients(I1);
    
        K (i) = tmp_K ;
        C1(i) = tmp_C1;
        C2(i) = tmp_C2;
        BB(i) = tmp_BB;
        H (i) = tmp_H ;

        i = i + 1;
    end

end




function [K, C1, C2, BB, H] = get_coeficients(I1)

    all_data = regionprops(I1,"all");

    K = wspolczynnik_kompaktowosci(I1, all_data);
    [C1,C2] = wspolczynnik_kolowosci(I1, all_data);
    BB = wspolczynnik_blaira_blissa(I1, all_data);
    H = wspolczynnik_hararicka(I1, all_data);

end











