function Mz = wspolczynnik_Mz(I1)

    I1 = I1 > 0.5;

    all1 = regionprops(I1, "all");

    S = all1.Area;
    L = all1.Perimeter;

    
    Mz = 2 * sqrt(pi*S) / L;

end