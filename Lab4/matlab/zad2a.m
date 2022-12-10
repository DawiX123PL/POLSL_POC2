

translation = [0 0];
scale = [1 1];



all_rotations = [1:5:90];


K  = all_rotations;
C1 = all_rotations;
C2 = all_rotations;
BB = all_rotations;
H  = all_rotations;

i = 1;

for rotation = all_rotations
    
    disp(i);

    %I1 = g_circles(translation, rotation, scale );
    %I1 = g_squares(translation, rotation, scale );
    I1 = g_xd(translation, rotation, scale );

    I1 = double(I1 > .5);

    [tmp_K, tmp_C1, tmp_C2, tmp_BB, tmp_H] = get_coeficients(I1);

    K (i) = tmp_K ;
    C1(i) = tmp_C1;
    C2(i) = tmp_C2;
    BB(i) = tmp_BB;
    H (i) = tmp_H ;

    i = i + 1;

end

figure
hold on;
plot(all_rotations, K, 'r');
plot(all_rotations, C1, 'y');
plot(all_rotations, H, 'b');
legend("K", "C1", "H");




function [K, C1, C2, BB, H] = get_coeficients(I1)

    all_data = regionprops(I1,"all");

    K = wspolczynnik_kompaktowosci(I1, all_data);
    [C1,C2] = wspolczynnik_kolowosci(I1, all_data);
    BB = wspolczynnik_blaira_blissa(I1, all_data);
    H = wspolczynnik_hararicka(I1, all_data);

end

