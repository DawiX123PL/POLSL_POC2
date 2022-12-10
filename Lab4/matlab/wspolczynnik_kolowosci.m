function [C1,C2] = wspolczynnik_kolowosci(I1, all_data)
    
    if (~exist("all_data"))
        all_data = regionprops(I1,"all");
    end


    S = all_data.Area;
    L = all_data.Perimeter;

    C1 = 2*sqrt(S/pi);
    C2 = L/pi;


end