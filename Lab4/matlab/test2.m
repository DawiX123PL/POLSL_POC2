clear all
close all
clc


plot_coeficients("circ"); hold on;
plot_coeficients("sqr");
plot_coeficients("xD");


legend("circ", "sqr");


function plot_coeficients(src_prefix)
    
    K = [];
    C1 = [];
    C2 = [];
    BB = [];
    H = [];
    
    
    for i = 1:20
        
        src = "../images/" + src_prefix + string(i) + ".png";
        I1 = imread(src);
        
        I1 = double(I1) ./ 255;
        I1 = double(I1 > .5);
        
        
        k = wspolczynnik_kompaktowosci(I1);
        [c1,c2] = wspolczynnik_kolowosci(I1);
        bb = wspolczynnik_blaira_blissa(I1);
        h = wspolczynnik_hararicka(I1);
    
        K  = [K , k];
        C1 = [C1, c1];
        C2 = [C2, c2];
        BB = [BB, bb];
        H =  [H, h];

    end
    
    
    plot3(K, C1, H, "*");
    xlabel("Kompaktowość");
    ylabel("C1");
    zlabel("H");
    grid on;

end