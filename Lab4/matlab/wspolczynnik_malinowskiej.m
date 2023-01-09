function M = wspolczynnik_malinowskiej(I1)

    I1 = I1 > 0.5;

    all1 = regionprops(I1, "all");

    S = all1.Area;
    L = all1.Perimeter;


    
    M = L / (2*sqrt(pi*S)) - 1;

end