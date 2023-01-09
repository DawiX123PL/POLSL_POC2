clear all
close all
clc

mkdir("../result")


I_orig = imread("..\tarcza\z3.jpg");
I = rgb2gray(I_orig);
I = adapthisteq(I);
I = imfilter(I, fspecial("gaussian", 5, 2));
I = imbinarize(I, 0.9);
I = ~I;

I1 = bwlabel(I);
props = find_props(I);


for index = 1:length(props)
    p = props(index);

    I_cut = imcrop(I, p.BoundingBox);
    center = p.Centroid - p.BoundingBox(1:2);
    
    result_file = "../result/I" + index + ".png";
    count(index) = find_teeth_count(I_cut, center, p, result_file);

end

%% 

disp("Count")
disp(count)

figure('units','normalized','outerposition',[0 0 1 1])
tiledlayout(1,2)
nexttile
imshow(I_orig);
nexttile
imshow(label2rgb(I1));
hold on

for index = 1:length(props)
    p = props(index);

    txt = string(count(index));
    text(p.Centroid(1),p.Centroid(2),txt,'FontSize',20);

    %viscircles(p.Centroid, p.MinorAxisLength/2);
    viscircles(p.Centroid, p.MajorAxisLength/2);
    viscircles(p.Centroid, p.MajorAxisLength/2 * 0.97);
end





saveas(gcf,"../result/I.png")


%%


function prop = find_props_with_max(props)
    [~, index] = max([props.Area]);
    prop = props(index);
end


function prop1 = find_props(I)
    props = regionprops(I, "all");
    
    prop1 = [];
    for i = 1:length(props)
        if props(i).Area > 10000
            prop1 = [prop1, props(i)];
        end
    end


end



function count = find_teeth_count(I, center, props, filename)
    
   big_r = (props.MajorAxisLength/2);
   small_r = big_r * 0.97;

   [X,Y] = meshgrid(1:size(I,2),1:size(I,1));
   X = X - center(1);
   Y = Y - center(2);
   Circle = (X.^2 + Y.^2) < (small_r^2);
   I1 = I & ~Circle;

   figure('units','normalized','outerposition',[0 0 1 1])
   tiledlayout(1,2);
   nexttile;
   imshow(I)
   nexttile;
   imshow(label2rgb(bwlabel(I1)));

   count = length(regionprops(I1));
   saveas(gcf,filename);

end















