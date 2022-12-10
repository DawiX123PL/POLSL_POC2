function BB = wspolczynnik_blaira_blissa(I1, all_data)

    if (~exist("all_data"))
        all_data = regionprops(I1,"all");
    end


    S = all_data.Area;
    L = all_data.Perimeter;

    

    sr = sum_r(I1, all_data);

    BB = S/sqrt(2*pi*sr);

end


function sr = sum_r(I1, all_data)

    center = all_data.Centroid;
    xc = center(1);
    yc = center(2);

    [x,y] = meshgrid(1:size(I1,1), 1:size(I1,2));

    r = sqrt( (x-xc).^2 + (y-yc).^2 );
    r = double(I1 > .5) * r;

    sr = sum(r, "all");

end