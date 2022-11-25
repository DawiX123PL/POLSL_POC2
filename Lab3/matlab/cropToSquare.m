function I1 = cropToSquare(I)

    s1 = size(I,1);
    s2 = size(I,2);

    
    if s1 == s2
        I1 = I;

    elseif( s1 > s2 )
        
        diff2 = round((s1 - s2)/2);
        v1 = (1:s2) + diff2;
        v2 = 1:s2;
        
        I1 = I(v1,v2, :);

    elseif( s1 < s2 )

        diff2 = round((s2 - s1)/2);
        v1 = 1:s1;
        v2 = (1:s1) + diff2;
        
        I1 = I(v1,v2, :);

    end


end