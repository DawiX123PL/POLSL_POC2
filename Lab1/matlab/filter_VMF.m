function [I] = filter_VMF(I1, window_size)

I = I1;

% dodanie krawędzi do obrazu

for i = 1:window_size
    I1 = [ I1(:,1,:), I1, I1(:,end,:) ];
    I1 = [ I1(1,:,:); I1; I1(end,:,:) ];
end


for y = 1:size(I,2)
    for x = 1:size(I,1)
        
        window = I1(x:x+window_size*2, y:y+window_size*2,:);
        vec = reshape(window,[],1,size(window,3));

        R_vec = R(vec);

        [~, index] = sort(R_vec);

        I(x,y,:) = vec(index(1),:,:);

    end
end

end



function R_vec = R(vec)

    R_vec = vec;

    for i = 1:length(vec)
        Ri = 0;
        for j = 1:length(vec)
            Fi = vec(i);
            Fj = vec(j);
            Ri = Ri + L1(Fi,Fj);
        end

        R_vec(i) = Ri;
    end
    

end


function ro = L1(Fi, Fj)
    ro = sum(abs(Fi - Fj));
end

function ro = L2(Fi, Fj)
    ro = sqrt( sum( (Fi - Fj).^2 ) );
end

function ro = L_inf(Fi, Fj)
    ro = max( abs(Fi - Fj) );
end