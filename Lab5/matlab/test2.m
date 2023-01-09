clear all
close all
clc

I = imread("..\tarcza\z3.jpg");
I = rgb2gray(I);
I = adapthisteq(I);
I = imfilter(I, fspecial("gaussian", 5, 2));
I = imbinarize(I, 0.9);
I = ~I;

imshow(I);

I1 = bwlabel(I);
props = find_props(I);



for index = 1:length(props)
    p = props(index);

    I_cut = imcrop(I, p.BoundingBox);
    center = p.Centroid - p.BoundingBox(1:2);
    
    count = find_teeth_count(I_cut, center, p)

end

imshow(label2rgb(I1));
hold on

for index = 1:length(props)
    p = props(index);
    center = p.Centroid - p.BoundingBox(1:2);
    viscircles(p.Centroid, p.MinorAxisLength/2);
    viscircles(p.Centroid, p.MajorAxisLength/2);
    viscircles(p.Centroid, p.MajorAxisLength/2 * 0.97);
end



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


function count = find_teeth_count(I, center, props)
    
   big_r = (props.MajorAxisLength/2);
   small_r = big_r * 0.97;

   [X,Y] = meshgrid(1:size(I,2),1:size(I,1));
   X = X - center(1);
   Y = Y - center(2);
   Circle = (X.^2 + Y.^2) < (small_r^2);
   I1 = I & ~Circle;

   %figure;
   %tiledlayout(1,2);
   %nexttile;
   %imshow(I)
   %nexttile;
   %imshow(bwlabel(I1));

   count = length(regionprops(I1));

end















