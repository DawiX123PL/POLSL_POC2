function [I1, level] = ImageBinarize(I, method)
    
    if method == "hist"
        level = HistogramHalf(I);
    elseif method == "otsu"
        level = OtsuTreshhold(I);
    end

    I1 = double( I > level );
end




function level = HistogramHalf(I)

    [counts,binLocations] = imhist(I);
    count_and_bin = [counts, binLocations]';
    
    all = numel(I);
    half = all/2;

    accumulator = 0;
    
    for cb = count_and_bin
        accumulator = accumulator + cb(1);
        
        if(accumulator >= half)
            level = cb(2);
            return;
        end
    end
    
    % function should never reach this
    level = 1;

end




function level = OtsuTreshhold(I)
    
    N = numel(I);

    [n_all, k_all] = imhist(I);


    p_all = n_all/N;


    selected_k = 0;
    max_sigma2_B = 0;

    for i = 1:numel(k_all)-1

        k = k_all(i);

        I_L = [1:i]';
        I_H = [i+1:numel(p_all)]';

        w0 = sum( p_all(I_L) );
        w1 = sum( p_all(I_H) );

        u0 = sum( I_L .* p_all(I_L) / w0 );
        u1 = sum( I_H .* p_all(I_H) / w1 );

        sigma2_B = w0*w1*(u1-u0)^2;

        if( max_sigma2_B <  sigma2_B)
            max_sigma2_B = sigma2_B;
            selected_k = k;
        end

    end

level = selected_k;


end




