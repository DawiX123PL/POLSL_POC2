function H = wspolczynnik_hararicka(I1, all_data)

    if (~exist("all_data"))
        all_data = regionprops(I1,"all");
    end


    S = all_data.Area;
    L = all_data.Perimeter;

    

    sd = sum_d(I1, all_data);

    n = sum(double(bwperim(I1) > .5), "all");

    H = sqrt( (sd^2) / ( n*sd^2 - 1) );

end


function sr = sum_d(I1, all_data)

    I1 = bwperim(I1);

    center = all_data.Centroid;
    xc = center(1);
    yc = center(2);

    [x,y] = meshgrid(1:size(I1,1), 1:size(I1,2));

    r = sqrt( (x-xc).^2 + (y-yc).^2 );

    r = double(I1 > .5) * r;

    sr = sum(r, "all");

end