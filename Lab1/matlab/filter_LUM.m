function [I] = filter_LUM(I1, window_size, k)

I = I1;

% dodanie krawędzi do obrazu

for i = 1:window_size
    I1 = [ I1(:,1,:), I1, I1(:,end,:) ];
    I1 = [ I1(1,:,:); I1; I1(end,:,:) ];
end

window_edge_length = window_size * 2 + 1;
vector_total_size = window_edge_length ^ 2;
vector_center_element_pos = (vector_total_size+1) /2;

for y = 1:size(I,2)
    for x = 1:size(I,1)
        
        window = I1(x:x+window_size*2, y:y+window_size*2,:);
        vec = reshape(window,[],1,size(window,3));
        sorted = sort(vec);

        x0 = window(window_size+1, window_size+1, :);
        xl = sorted(vector_center_element_pos-k, :, :);
        xu = sorted(vector_center_element_pos+k, :, :);

        I(x,y,:) = median([x0,xl,xu]);
    
    end
end



end