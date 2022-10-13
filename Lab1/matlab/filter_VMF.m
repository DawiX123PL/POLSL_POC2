function [I] = filter_VMF(I1, window_size, norm)


    function ro = L1(Fi, Fj)
        ro = sum(abs(Fi - Fj));
    end
    
    function ro = L2(Fi, Fj)
        ro = sqrt( sum( (Fi - Fj).^2 ) );
    end
    
    function ro = L_inf(Fi, Fj)
        ro = max( abs(Fi - Fj) );
    end


%     function R_vec = R(vec, R_function)
%         R_vec = vec;
%     
%         for i = 1:length(vec)
%             Ri = 0;
%             for j = 1:length(vec)
%                 Fi = vec(i,:,:);
%                 Fj = vec(j,:,:);
%                 Ri = Ri + R_function(Fi,Fj); 
%                 %Ri = Ri + sum(abs(Fi - Fj));
%             end
%     
%             R_vec(i) = Ri;
%         end
%     end


%     function R_vec = R_L1(vec)
%         %R_vec = vec;
%         R_vec = zeros([1,size(vec,1)]);
% 
%         for ii = 1:length(vec)
%             Ri = 0;
%             for j = 1:length(vec)
%                 Fi = vec(ii,:,:);
%                 Fj = vec(j,:,:);
%                 %Ri = Ri + L1(Fi,Fj); 
%                 Ri = Ri + sum(abs(Fi - Fj));
%             end
%     
%             R_vec(ii) = Ri;
%         end
%     end

    function R_vec = R_L1(vec)

        v1 = repmat(vec,1,size(vec,1));
        v2 = permute(v1,[2 1 3]);

        R_vec = sum(sum(abs(v1 - v2),3));
        

%       %R_vec = vec;
%        R_vec = zeros([1,size(vec,1)]);
%         for ii = 1:length(vec)
%             Ri = 0;
%             for j = 1:length(vec)
%                 Fi = vec(ii,:,:);
%                 Fj = vec(j,:,:);
%                 %Ri = Ri + L1(Fi,Fj); 
%                 Ri = Ri + sum(abs(Fi - Fj));
%             end
%     
%             R_vec(ii) = Ri;
%         end
    end

    function R_vec = R_L2(vec)

        v1 = repmat(vec,1,size(vec,1));
        v2 = permute(v1,[2 1 3]);

        %ro = sqrt( sum( (Fi - Fj).^2 ) );

        R_vec = sum( sqrt( sum( (v1 - v2).^2 ,3) ));

%        %R_vec = vec;
%         R_vec = zeros([1,size(vec,1)]);
%     
%         for ii = 1:length(vec)
%             Ri = 0;
%             for j = 1:length(vec)
%                 Fi = vec(ii,:,:);
%                 Fj = vec(j,:,:);
%                 %Ri = Ri + L1(Fi,Fj); 
%                 Ri = Ri + sqrt( sum( (Fi - Fj).^2 ) );
%             end
%     
%             R_vec(ii) = Ri;
%         end
    end

    function R_vec = R_L_inf(vec)

        v1 = repmat(vec,1,size(vec,1));
        v2 = permute(v1,[2 1 3]);

        R_vec = sum( max( abs(v1 - v2) ,[],3) );

%         %R_vec = vec;
%         R_vec = zeros([1,size(vec,1)]);
% 
%         for ii = 1:length(vec)
%             Ri = 0;
%             for j = 1:length(vec)
%                 Fi = vec(ii,:,:);
%                 Fj = vec(j,:,:);
%                 %Ri = Ri + L1(Fi,Fj); 
%                 Ri = Ri + max( abs(Fi - Fj) );
%             end
%     
%             R_vec(ii) = Ri;
%         end
    end



% wybranie normy
if norm == "L1"
    R_Function = @R_L1;
elseif norm == "L2"
    R_Function = @R_L2;
elseif norm == "Linf"
    R_Function = @R_L_inf;
else
    error 'wybierz norme "L1" "L2" "Linf"'
end


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

        %R_vec = R(vec,R_Function);
        R_vec = R_Function(vec);
        
        [~, index] = sort(R_vec);

        I(x,y,:) = vec(index(1),:,:);

    end
end

end





