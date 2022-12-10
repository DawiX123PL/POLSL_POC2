function M = wspolczynnik_malinowskiej(I1, all_data)

    if (~exist("all_data"))
        all_data = regionprops(I1,"all");
    end


    S = all_data.Area;
    L = all_data.Perimeter;

    M = L *.5 / sqrt(pi*S) -1

end
