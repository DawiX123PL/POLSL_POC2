function [I] = filter_median(I1, window_size)

I = I1;

% dodanie krawędzi do obrazu

for i = 1:window_size
    I1 = [ I1(:,1,:), I1, I1(:,end,:) ];
    I1 = [ I1(1,:,:); I1; I1(end,:,:) ];
end


for y = 1:size(I,2)
    for x = 1:size(I,1)
        
        window = I1(x:x+window_size*2, y:y+window_size*2, :);
        m = median(window,[1,2]);
        I(x,y,:) = m;
    
    end
end



end