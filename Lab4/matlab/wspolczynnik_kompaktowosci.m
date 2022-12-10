function K = wspolczynnik_kompaktowosci(I1, all_data)

    if (~exist("all_data"))
        all_data = regionprops(I1,"all");
    end

    S = all_data.Area;
    L = all_data.Perimeter;

    
    K = 4*pi*S/L;

end