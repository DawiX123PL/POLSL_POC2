function K = wspolczynnik_kompaktowosci(I1)

    I1 = I1 > 0.5;

    all1 = regionprops(I1, "all");

    S = all1.Area;
    L = all1.Perimeter;

    
    K = 4*pi*S/L^2;

end